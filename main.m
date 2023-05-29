%% Drone 班用共通プログラム
%% Initialize settings
% set path
activeFile = matlab.desktop.editor.getActive;
cd(fileparts(activeFile.Filename));
[~, activeFile] = regexp(genpath('.'), '\.\\\.git.*?;', 'match', 'split');
cellfun(@(xx) addpath(xx), activeFile, 'UniformOutput', false);
close all hidden; clear all; clc;
userpath('clear');
% warning('off', 'all');

%% general setting
N = 1; % number of agents
fExp = 0; % 1: experiment   0: numerical simulation
fMotive = 1; % 1: active
fOffline = 0; % 1: active : offline verification with saved data
fDebug = 0; % 1: active : for debug function
run("main1_setting.m");

% set logger
% デフォルトでsensor, estimator, reference,のresultと inputのログはとる
LogData = [% agentのメンバー関係以外のデータ
        ];
LogAgentData = [% 下のLOGGER コンストラクタで設定している対象agentに共通するdefault以外のデータ
              ];

if (fOffline)
  logger = LOGGER("Data/Log(21-Aug-2022_06_16_24).mat", ["sensor", "estimator"]);
else
  logger = LOGGER(1:N, size(ts:dt:te, 2), fExp, LogData, LogAgentData);
end

%
run("main2_agent_setup.m");

%agent.set_model_error("ly",0.02);
%% main loop
run("main3_loop_setup.m");

try

  while round(time.t, 5) <= te
    %% sensor
    %    tic
    tStart = tic;

    if (fOffline)
      logger.overwrite("plant", time.t, agent, i);
      FH.CurrentCharacter = char(logger.Data.phase(offline_time));
      time.t = logger.Data.t(offline_time);
      offline_time = offline_time + 1;
    end

    if fMotive
      %motive.getData({agent,["pL"]},mparam);
      motive.getData(agent, mparam);
    end

    for i = 1:N
      % sensor
      if fMotive; param(i).sensor.motive = {}; end
      param(i).sensor.rpos = {agent};
      param(i).sensor.imu = {[]};
      param(i).sensor.direct = {};
%       param(i).sensor.rdensity = {Env};
%       param(i).sensor.lrf = {Env.param};
      param(i).sensor.lidar = {};

      for j = 1:length(agent(i).sensor.name)
        param(i).sensor.list{j} = param(i).sensor.(agent(i).sensor.name(j));
      end

      agent(i).do_sensor(param(i).sensor.list);
      if (fOffline); logger.overwrite("sensor", time.t, agent, i); end
    end

    %% estimator, reference generator, controller
    for i = 1:N
      % estimator
      agent(i).do_estimator(cell(1, 10));
      if (fOffline); logger.overwrite("estimator", time.t, agent, i); end

      % reference
      if time.t < 2
          FH.CurrentCharacter = 'h';
      else
        FH.CurrentCharacter = 'f';
      end
      param(i).reference.covering = [];
      param(i).reference.point = {FH, [2; 0; 1], time.t, dt};
      param(i).reference.timeVarying = {time, FH};
      param(i).reference.tvLoad = {time};
      param(i).reference.wall = {1};
      param(i).reference.tbug = {};
      param(i).reference.path_ref_mpc = {1};
      param(i).reference.agreement = {logger, N, time.t};

      for j = 1:length(agent(i).reference.name)
        param(i).reference.list{j} = param(i).reference.(agent(i).reference.name(j));
      end
      % if time.t < 2
      %   agent.reference.result.state.xd(1:12) = [initial.p;0; initial.v;0; 0;0;0;0];
      %   agent.reference.result.state.xd(13:end) = zeros(16, 1);
      % end

      agent(i).do_reference(param(i).reference.list);
      if (fOffline); logger.overwrite("reference", time.t, agent, i); end

      
      % controller
      param(i).controller.hlc = {time.t};
      param(i).controller.ftc = {time.t};
      param(i).controller.pid = {};
      param(i).controller.tscf = {dt, time.t};
      param(i).controller.mpc = {};

      for j = 1:length(agent(i).controller.name)
        param(i).controller.list{j} = param(i).controller.(agent(i).controller.name(j));
      end

      agent(i).do_controller(param(i).controller.list);
      if (fOffline); logger.overwrite("input", time.t, agent, i); end
    end

    if fDebug
      agent.reference.path_ref_mpc.FHPlot(Env,FH,[]);
      %agent.show(["sensor", "lidar"], "FH", FH, "param", struct("fLocal", true));%false));
    end

    %% update state
    figure(FH)
    drawnow

    for i = 1:N                       % 状態更新
      model_param.param = agent(i).model.param;
      model_param.FH = FH;
      agent(i).do_model(model_param); % 算出した入力と推定した状態を元に状態の1ステップ予測を計算

      model_param.param = agent(i).plant.param;
      agent(i).do_plant(model_param);
    end

    %%
%     data.input_v{round(time.t/dt + 1)} = agent.controller.result.input_v;


    % for exp
    if fExp
      %% logging
      logger.logging(time.t, FH, agent, []);
      calculation1 = toc(tStart);
      time.t = time.t + calculation1;

      %% logging
      %             calculation = toc;
      %             wait_time = 0.9999 * (sampling - calculation);
      %
      %             if wait_time < 0
      %                 wait_time
      %                 warning("ACSL : sampling time is too short.");
      %             end
      %            time.t = time.t + calculation;

      %            else
      %                pause(wait_time);  %　センサー情報取得から制御入力印加までを早く保ちつつ，周期をできるだけ一定に保つため
      % これをやるとpause中が不安定になる．どうしても一定時間にしたいならwhile でsamplingを越えるのを待つなどすればよいかも．
      % それよりは推定などで，calculationを意識した更新をしてあげた方がよい？
      %                time.t = time.t + sampling;
      %            end
    else
      logger.logging(time.t, FH, agent, []);

      if (fOffline)
        time.t
      else
        time.t = time.t + dt % for sim
      end

    end

  end

catch ME % for error
  % with FH
  for i = 1:N
    agent(i).do_plant(struct('FH', FH), "emergency");
  end

  warning('ACSL : Emergency stop! Check the connection.');
  rethrow(ME);
end

%profile viewer
%%
logt = logger.data('t',[],[]);
% for R = 1:te/dt
%     InputV(:, R) = data.input_v{R};
% end

close all
clc
set(0, 'defaultAxesFontSize',15);
set(0,'defaultTextFontsize',15);
set(0,'defaultLineLineWidth',1.5);
set(0,'defaultLineMarkerSize',15);
% plot
%logger.plot({1,"p","per"},{1,"controller.result.z",""},{1,"input",""});
%logger.plot({1, "q1", "e"});
% logger.plot({1, "p", "er"}, {1, "q", "p"}, {1, "v", "p"}, {1, "input", ""}, {1, "p1-p2", "er"}, "fig_num", 5, "row_col", [2, 3]);
logger.plot({1, "p", "er"}, {1, "q", "p"}, {1, "v", "p"}, {1, "input", ""},"fig_num", 5, "row_col", [2, 2]);
% 仮想入力
% figure(10); plot(logt, InputV); legend("input1", "input2", "input3", "input4");
% xlabel("Time [s]"); ylabel("input.V");
% grid on; xlim([0 te]); ylim([-inf inf]);
saveas(gcf, 'HL_slope-landing-ref', "png");
%%
% InputV(:, te/dt+1) = InputV(:, te/dt);
% save("Data/InputV_HL.mat", "InputV");   %仮想入力の保存
% Idata = logger.data(1,"input",[])';
% save("Data/Input_HL.mat", "Idata"); % 実入力の保存
%% Save figure
% d = char(yyyymmddHHMMSS(datetime));
% d = datestr(now, "yyyy-mm-dd_HH:MM:SS");
% dsave = append(d, ".png");
%%
% saveas(gcf, "../save_figure/HL/dsave");

% agent(1).reference.timeVarying.show(logger)

%% animation
%VORONOI_BARYCENTER.draw_movie(logger, N, Env,1:N)
%agent(1).estimator.pf.animation(logger,"target",1,"FH",figure(),"state_char","p");
agent(1).animation(logger, "target", 1:N);
%%
%logger.save();
%logger.save("AROB2022_Prop400s2","separate",true);