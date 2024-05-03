%% initialize
%位置，姿勢角，速度，角速度の推定結果を表示するためのプログラム
%一つのグラフにまとめて表示される(例：位置x,y,zが一つのfigureに表示)
clear all
close all

%% flag
flg.ylimHold = 0; % 指定した値にylimを固定
flg.xlimHold = 1; % 指定した値にxlimを固定
startTime = 0;

%% select file to load
%出力するグラフを選択(最大で3つのデータを同一のグラフに重ねることが可能)
loadfilename{1} = 'EstimationResult_12state_2_7_Exp_sprine+zsprine+P2Pz_torque_incon_150data_vzからz算出';
% loadfilename{1} = 'EstimationResult_2024-05-02_Exp_Kiyama_code00_1' ;
% loadfilename{1} = 'EstimationResult_Exp_Kiyama_code01';
% loadfilename{2} = '.mat';
% loadfilename{3} = '.mat';

WhichRef = 1; % 出力するデータの中で，どのファイルをリファレンスに使うか(基本変更しなくてよい)

%% グラフの保存
save_fig = 0; %1：出力したグラフをfigで保存する

if save_fig == 1 % Graphフォルダ内に保存 .figで保存
    name = 'data2_sadP2Pz'; %ファイル名
    folderName = 'data2_sadP2Pz'; %フォルダ名
    mkdir(folderName) %新規フォルダ作成
end

%% plot range
%何ステップまで表示するか
%ステップ数とxlinHoldの幅を変えればグラフの長さを変えられる
% stepN = 121; %検証用シミュレーションのステップ数がどれだけあるかを確認,これを変えると出力時間が伸びる
RMSE.Posylim = 0.1^2;
RMSE.Atiylim = 0.0175^2;

stepnum = 1; %ステップ数，xの範囲を設定 default: 1
if stepnum == 0
    stepN = 31;
    if flg.xlimHold == 1
        xlimHold = [0,0.5];
    end
elseif stepnum == 1
    stepN = 55;
    if flg.xlimHold == 1
        xlimHold = [0,0.8];
    end
elseif stepnum == 2
    stepN = 91;
    if flg.xlimHold == 1
        xlimHold = [0,1.5];
    end
else
    stepN = 121;
    if flg.xlimHold == 1
        xlimHold = [0,2];
    end
end

% flg.ylimHoldがtrueのときのplot y範囲
if flg.ylimHold == 1
    ylimHold.p = [-1.5, 1.5];
    ylimHold.q = [-0.2, 0.8];
    ylimHold.v = [-3, 4];
    ylimHold.w = [-1.5, 2];
end

%% Font size(グラフの軸ラベルや凡例の大きさを調整できる)
Fsize.label = 18;
Fsize.lgd = 18;
Fsize.luler = 18;

%% load(基本いじる必要は無い)
HowmanyFile = size(loadfilename,2);
for i = 1:HowmanyFile
    file{i} = load(loadfilename{i});
    file{i}.name = loadfilename{i};
    file{i}.lgdname.p = {append('$data',num2str(i),'_x$'),append('$data',num2str(i),'_y$'),append('$data',num2str(i),'_z$')};
    file{i}.lgdname.q = {append('$data',num2str(i),'_{roll}$'),append('$data',num2str(i),'_{pitch}$'),append('$data',num2str(i),'_{yaw}$')};
    file{i}.lgdname.v = {append('$data',num2str(i),'_{vx}$'),append('$data',num2str(i),'_{vy}$'),append('$data',num2str(i),'_{vz}$')};
    file{i}.lgdname.w = {append('$data',num2str(i),'_{w1}$'),append('$data',num2str(i),'_{w2}$'),append('$data',num2str(i),'_{w3}$')};
    
    if ~isfield(file{i}.simResult,'initTindex')
        file{i}.simResult.initTindex = 1;
    end

    if i == 1
        indexcheck = file{i}.simResult.initTindex
    elseif indexcheck ~= file{i}.simResult.initTindex
            disp('Caution!! 読み込んだファイルの初期状態が異なっています!!')
            dammy = input('Enterで無視して続行します');
    end
end

%%
% 凡例に特別な名前をつける時はここで指定, ない時は勝手に番号をふります
file{1}.lgdname.p = {'$\hat{x}_{\rm case1}$','$\hat{y}_{\rm case1}$','$\hat{z}_{\rm case1}$'};
file{1}.lgdname.q = {'$\hat{\phi}_{\rm case1}$','$\hat{\theta}_{\rm case1}$','$\hat{\psi}_{\rm case1}$'};
file{1}.lgdname.v = {'$\hat{v}_{x,{\rm case1}}$','$\hat{v}_{y,{\rm case1}}$','$\hat{v}_{z,{\rm case1}}$'};
file{1}.lgdname.w = {'$\hat{\omega}_{1,{\rm case1}}$','$\hat{\omega}_{2,{\rm case1}}$','$\hat{\omega}_{3,{\rm case1}}$'};
file{2}.lgdname.p = {'$\hat{x}_{\rm case2}$','$\hat{y}_{\rm case2}$','$\hat{z}_{\rm case2}$'};
file{2}.lgdname.q = {'$\hat{\phi}_{\rm case2}$','$\hat{\theta}_{\rm case2}$','$\hat{\psi}_{\rm case2}$'};
file{2}.lgdname.v = {'$\hat{v}_{x,{\rm case2}}$','$\hat{v}_{y,{\rm case2}}$','$\hat{v}_{z,{\rm case2}}$'};
file{2}.lgdname.w = {'$\hat{\omega}_{1,{\rm case2}}$','$\hat{\omega}_{2,{\rm case2}}$','$\hat{\omega}_{3,{\rm case2}}$'};
file{3}.lgdname.p = {'$\hat{x}_{\rm case3}$','$\hat{y}_{\rm case3}$','$\hat{z}_{\rm case3}$'};
file{3}.lgdname.q = {'$\hat{\phi}_{\rm case3}$','$\hat{\theta}_{\rm case3}$','$\hat{\psi}_{\rm case3}$'};
file{3}.lgdname.v = {'$\hat{v}_{x,{\rm case3}}$','$\hat{v}_{y,{\rm case3}}$','$\hat{v}_{z,{\rm case3}}$'};
file{3}.lgdname.w = {'$\hat{\omega}_{1,{\rm case3}}$','$\hat{\omega}_{2,{\rm case3}}$','$\hat{\omega}_{3,{\rm case3}}$'};

columnomber = size(file,2)+1;

% マーカーに特別なものをつける時はここで指定
file{1}.markerSty = ':o'; % 点線と丸印
file{2}.markerSty = ':square';
file{3}.markerSty = ':x';

dt = file{WhichRef}.simResult.reference.T(2)-file{WhichRef}.simResult.reference.T(1);
startInd = round(startTime / dt); % 何ステップから使用するか
tlength = file{1}.simResult.initTindex + startInd:file{1}.simResult.initTindex+stepN-1 + startInd;

newcolors = [0 0.4470 0.7410
             0.8500 0.3250 0.0980
             0.4660 0.6740 0.1880]; %グラフの色指定
%% P
figure(1)
% Referenceをplot
colororder(newcolors)
plot(file{WhichRef}.simResult.reference.T(tlength),file{WhichRef}.simResult.reference.est.p(tlength,:)','LineWidth',2); % 精度検証用データ
% Referenceの凡例をtmpに保存
lgdtmp = {'$x_d$','$y_d$','$z_d$'};
hold on
grid on
% 推定したA, B, Cを使った状態推定の結果
% 入力されたファイル数分ループ
for i = 1:HowmanyFile
    % i番目のファイルをplot
    if i == 1
        plot(file{i}.simResult.T(tlength) , file{i}.simResult.state.p(:,tlength),file{i}.markerSty,'MarkerSize',7,'LineWidth',1,'LineStyle','--');
    elseif i == 2
        plot(file{i}.simResult.T(tlength) , file{i}.simResult.state.p(:,tlength),file{i}.markerSty,'MarkerSize',7,'LineWidth',1,'LineStyle',':');
    elseif i == 3
        plot(file{i}.simResult.T(tlength) , file{i}.simResult.state.p(:,tlength),file{i}.markerSty,'MarkerSize',12,'LineWidth',1,'LineStyle','-.');
    end
    % file{i}に凡例が保存されている場合実行
    if isfield(file{i},'lgdname')
        if isfield(file{i}.lgdname,'p')
            % file{i}の凡例名をtmpに保存
            lgdtmp = [lgdtmp,file{i}.lgdname.p];
        end
    end
end
% xlim, ylimの設定
if flg.xlimHold == 1
    if ~isfield(xlimHold,'p')
        xlim(xlimHold);
    else
        xlim(xlimHold.p);
    end
end
if flg.ylimHold == 1
    if ~isfield(ylimHold,'p')
        ylim(ylimHold);
    else
        ylim(ylimHold.p);
    end
end
% tmpに保存された凡例を表示
lgd = legend(lgdtmp,'FontSize',Fsize.lgd,'Interpreter','latex','Location','best');
lgd.NumColumns = columnomber;
set(gca,'FontSize',Fsize.luler);
xlabel('time [sec]','FontSize',Fsize.label);
ylabel('Position [m]','FontSize',Fsize.label);
hold off

if save_fig == 1
    cd(folderName)
    savefig(strcat('Position_',name));
end

%% Q
figure(2)
colororder(newcolors)
plot(file{WhichRef}.simResult.reference.T(tlength),file{WhichRef}.simResult.reference.est.q(tlength,:)','LineWidth',2);
if size(file{WhichRef}.simResult.reference.est.q(tlength,:)',1) == 3
    lgdtmp = {'$\phi_d$','$\theta_d$','$\psi_d$'};
elseif size(file{WhichRef}.simResult.reference.est.q(tlength,:)',1) == 4
    lgdtmp = {'$q_{0,r}$','$q_{1,r}$','$q_{2,r}$','$q_{3,r}$'};
end
hold on
grid on
for i = 1:HowmanyFile
    if i == 1
        plot(file{i}.simResult.T(tlength) , file{i}.simResult.state.q(:,tlength),file{i}.markerSty,'MarkerSize',7,'LineWidth',1,'LineStyle','--');
    elseif i == 2
        plot(file{i}.simResult.T(tlength) , file{i}.simResult.state.q(:,tlength),file{i}.markerSty,'MarkerSize',7,'LineWidth',1,'LineStyle',':');
    elseif i == 3
        plot(file{i}.simResult.T(tlength) , file{i}.simResult.state.q(:,tlength),file{i}.markerSty,'MarkerSize',12,'LineWidth',1,'LineStyle','-.');
    end
    if isfield(file{i},'lgdname')
        if isfield(file{i}.lgdname,'q')
            lgdtmp = [lgdtmp,file{i}.lgdname.q];
        end
    end
end
if flg.xlimHold == 1
    if ~isfield(xlimHold,'q')
        xlim(xlimHold);
    else
        xlim(xlimHold.p);
    end
end
if flg.ylimHold == 1
    if ~isfield(ylimHold,'q')
        ylim(ylimHold);
    else
        ylim(ylimHold.q);
    end
end
lgd = legend(lgdtmp,'FontSize',Fsize.lgd,'Interpreter','latex','Location','best');
lgd.NumColumns = columnomber;
set(gca,'FontSize',Fsize.luler);
xlabel('time [sec]','FontSize',Fsize.label);
ylabel('Attitude [rad]','FontSize',Fsize.label);
hold off

if save_fig == 1
    savefig(strcat('Attitude_',name));
end

%% V
figure(3)
colororder(newcolors)
plot(file{WhichRef}.simResult.reference.T(tlength),file{WhichRef}.simResult.reference.est.v(tlength,:)','LineWidth',2);
lgdtmp = {'$v_{xd}$','$v_{yd}$','$v_{zd}$'};
hold on
grid on
for i = 1:HowmanyFile
    if i == 1
        plot(file{i}.simResult.T(tlength) , file{i}.simResult.state.v(:,tlength),file{i}.markerSty,'MarkerSize',7,'LineWidth',1,'LineStyle','--');
    elseif i == 2
        plot(file{i}.simResult.T(tlength) , file{i}.simResult.state.v(:,tlength),file{i}.markerSty,'MarkerSize',7,'LineWidth',1,'LineStyle',':');
    elseif i == 3
        plot(file{i}.simResult.T(tlength) , file{i}.simResult.state.v(:,tlength),file{i}.markerSty,'MarkerSize',12,'LineWidth',1,'LineStyle','-.');
    end
    if isfield(file{i},'lgdname')
        if isfield(file{i}.lgdname,'v')
            lgdtmp = [lgdtmp,file{i}.lgdname.v];
        end
    end
end
if flg.xlimHold == 1
    if ~isfield(xlimHold,'v')
        xlim(xlimHold);
    else
        xlim(xlimHold.v);
    end
end
if flg.ylimHold == 1
    if ~isfield(ylimHold,'v')
        ylim(ylimHold);
    else
        ylim(ylimHold.v);
    end
end
lgd = legend(lgdtmp,'FontSize',Fsize.lgd,'Interpreter','latex','Location','best');
set(gca,'FontSize',Fsize.luler);
xlabel('time [sec]','FontSize',Fsize.label);
ylabel('Velocity [[m/s]','FontSize',Fsize.label);
lgd.NumColumns = columnomber;
hold off

if save_fig == 1
    savefig(strcat('Velocity_',name));
end

%% W
figure(4)
colororder(newcolors)
% lgd = ('$\omega_{\phi d}$','$\omega_{\theta d}$','$\omega_{\psi d}$','$\hat{\omega}_\phi$','$\hat{\omega}_\theta$','$\hat{\omega}_\psi$','FontSize',Fsize.lgd,'Interpreter','latex','Location','best');
plot(file{WhichRef}.simResult.reference.T(tlength),file{WhichRef}.simResult.reference.est.w(tlength,:)','LineWidth',2);
lgdtmp = {'$\omega_{1 d}$','$\omega_{2 d}$','$\omega_{3 d}$'};
hold on
grid on
for i = 1:HowmanyFile
    if i == 1
        plot(file{i}.simResult.T(tlength) , file{i}.simResult.state.w(:,tlength),file{i}.markerSty,'MarkerSize',7,'LineWidth',1,'LineStyle','--');
    elseif i == 2
        plot(file{i}.simResult.T(tlength) , file{i}.simResult.state.w(:,tlength),file{i}.markerSty,'MarkerSize',7,'LineWidth',1,'LineStyle',':');
    elseif i == 3
        plot(file{i}.simResult.T(tlength) , file{i}.simResult.state.w(:,tlength),file{i}.markerSty,'MarkerSize',12,'LineWidth',1,'LineStyle','-.');
    end
    if isfield(file{i},'lgdname')
        if isfield(file{i}.lgdname,'w')
            lgdtmp = [lgdtmp,file{i}.lgdname.w];
        end
    end
end
if flg.xlimHold == 1
    if ~isfield(xlimHold,'w')
        xlim(xlimHold);
    else
        xlim(xlimHold.w);
    end
end
if flg.ylimHold == 1
    if ~isfield(ylimHold,'w')
        ylim(ylimHold);
    else
        ylim(ylimHold.w);
    end
end
set(gca,'FontSize',Fsize.luler);
xlabel('time [sec]','FontSize',Fsize.label);
ylabel('Angular Velocity [rad/s]','FontSize',Fsize.label);
lgd = legend(lgdtmp,'FontSize',Fsize.lgd,'Interpreter','latex','Location','best');
lgd.NumColumns = columnomber;
hold off

if save_fig == 1
    savefig(strcat('Angular velocity_',name));
end
