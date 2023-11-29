function Controller = Controller_MPC_Koopman(Agent)
%UNTITLED この関数の概要をここに記述
%   各種値
    Controller_param.dt = 0.08; % MPCステップ幅
    Controller_param.H = 10;
    Controller_param.state_size = 12;
    Controller_param.input_size = 4;
    Controller_param.total_size = Controller_param.state_size + Controller_param.input_size;

    %% Koopman
%     load("EstimationResult_12state_7_19_circle=circle_estimation=circle.mat",'est');
    load("EstimationResult_12state_10_30_data=cirandrevsadP2Pxy_cir=cir_est=cir_Inputandconst.mat",'est');
    Controller_param.A = est.A;
    Controller_param.B = est.B;
    Controller_param.C = est.C;

    %% 重み
    % Controller_param.weight.P = diag([70; 55; 1]);    % 座標   1000 1000 10000
    % Controller_param.weight.V = diag([40; 35; 55]);    % 速度
    % Controller_param.weight.R = diag([1; 1; 1; 1]); % 入力
    % Controller_param.weight.RP = 0 * diag([1; 1; 1; 1]);  % 1ステップ前の入力との差    0*(無効化)
    % Controller_param.weight.QW = diag([1; 1; 1; 1; 1; 50]);  % 姿勢角，角速度
    % 
    % Controller_param.weight.Pf = diag([70; 60; 20]); % 6
    % Controller_param.weight.Vf = diag([30; 55; 25]);
    % Controller_param.weight.QWf = diag([1; 1; 1; 1; 1; 60]); % 7,8

    Controller_param.weight.P = diag([20; 1; 1]);    % 座標   1000 1000 10000
    Controller_param.weight.V = diag([370; 470; 690]);    % 速度
    Controller_param.weight.R = diag([1; 1; 1; 1]); % 入力
    Controller_param.weight.RP = 0 * diag([1; 1; 1; 1]);  % 1ステップ前の入力との差    0*(無効化)
    Controller_param.weight.QW = diag([20; 20; 200; 1; 1; 300]);  % 姿勢角，角速度

    Controller_param.weight.Pf = diag([20; 1; 100]); % 6
    Controller_param.weight.Vf = diag([1300; 850; 1500]);
    Controller_param.weight.QWf = diag([20; 100; 200; 1; 1; 300]); % 7,8

    %% 4inputs
    Controller_param.input.u = Agent.parameter.mass * 9.81 / 4 * [1;1;1;1]; % 4入力
%     Controller_param.torque_TH = 0;

    %% 以下は変更なし
    fprintf("勾配MPC controller\n")

    Controller_param.ref_input = Controller_param.input.u; %入力の目標値

    Controller.name = "mpc";
    Controller.type = "MPC_controller_org";
    Controller.param = Controller_param;

end