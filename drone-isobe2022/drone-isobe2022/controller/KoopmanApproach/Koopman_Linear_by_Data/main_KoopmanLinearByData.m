%% Koopman Linear by Data %%
% 先に main.m の Initialize settings を実行すること
% initialize
clc
clear
close all
% フラグ管理
flg.bilinear = 0; %1:双線形モデルへの切り替え

%% 
%データ保存先ファイル名(逐次変更する)
% delete controller\KoopmanApproach\Koopman_Linear_by_Data\EstimationResult_12state_6_26_circle=circle_estimation=circle.mat; %同じファイル名を使うときはコメントイン
FileName = 'EstimationResult_12state_7_26_circle=takeoff_estimation=circle.mat';  %plotResultの方も変更するように
% FileName = 'test2.mat'; %お試し用

% 読み込むデータファイル名(run_mainManyTime.mのファイル名と一致させる,ここで読み込むデータファイル名を識別してる)
% loading_filename = 'test';  
loading_filename = 'experiment_6_20_circle';  %matは含まないように注意！

%データ保存用,現在のファイルパスを取得,保存先を指定
activeFile = matlab.desktop.editor.getActive;
nowFolder = fileparts(activeFile.Filename);
targetpath=append(nowFolder,'\',FileName);

%% Defining Koopman Operator

%<使用している観測量>
F = @(x) [x;1]; % 状態そのまま
% F = @quaternions; % 状態+クォータニオンの1乗2乗3乗 オイラー角パラメータ用(動作確認済み)   <こちらが最新の観測量>

% load data
% 実験データから必要なものを抜き出す処理,↓状態,→データ番号(同一番号のデータが対応関係にある)
% Data.X 入力前の対象の状態
% Data.U 対象への入力
% Data.Y 入力後の対象の状態

% 使用するデータセットの数を指定
% 23/01/26 run_mainManyTime.m で得たデータを合成
disp('now loading data set')
Data.HowmanyDataset = 10; %読み込むデータ数に応じて変更

for i= 1: Data.HowmanyDataset
    if contains(loading_filename,'.mat')
        Dataset = ImportFromExpData(loading_filename);
    else
        Dataset = ImportFromExpData(append(loading_filename,'_',num2str(i),'.mat'));
    end
    if i==1
        Data.X = [Dataset.X];
        Data.U = [Dataset.U];
        Data.Y = [Dataset.Y];        
    else
        Data.X = [Data.X, Dataset.X];
        Data.U = [Data.U, Dataset.U];
        Data.Y = [Data.Y, Dataset.Y];
    end
    disp(append('loading data number: ',num2str(i),', now data:',num2str(Dataset.N),', all data: ',num2str(size(Data.X,2))))
end
disp('loaded')

% クォータニオンのノルムをチェック(クォータニオンのノルムは1にならなければいけないという制約がある)
% 閾値を下回った or 上回った場合注意文を提示
% attitude_norm 各時間におけるクォータニオンのノルム
if size(Data.X,1)==13
    thre = 0.01;
    attitude_norm = checkQuaternionNorm(Dataset.est.q',thre);
end

%% Koopman linear
% 12/12 関数化(双線形であるかどかの切り替え，上が双線形)
disp('now estimating')
if flg.bilinear == 1
    est = KL_biLinear(Data.X,Data.U,Data.Y,F);
else
    est = KL(Data.X,Data.U,Data.Y,F);
end

est.observable = F;
disp('Estimated')

%% Simulation by Estimated model(作ったモデルでシミュレーション)
%中間発表の推定精度検証シミュレーション
% simResult.reference = ImportFromExpData('TestData3.mat');
simResult.reference = ImportFromExpData2('experiment_6_20_circle_estimaterdata');
% simResult.reference = ImportFromExpData2('sim_7_28_circle');
% simResult.reference = ImportFromExpData2('experiment_7_11_circle_radius=0.7');


% 2023/06/12 アーミングphaseの実験データがうまく取れていないのを強引に解消
takeoff_idx = find(simResult.reference.T,1,'first');
simResult.reference.X = simResult.reference.X(:,takeoff_idx:end);
simResult.reference.Y = simResult.reference.Y(:,takeoff_idx:end);
simResult.reference.U = simResult.reference.U(:,takeoff_idx:end);
simResult.reference.T = simResult.reference.T(takeoff_idx:end);
simResult.reference.T = simResult.reference.T - simResult.reference.T(1);
simResult.reference.N = simResult.reference.N - takeoff_idx;

simResult.Z(:,1) = F(simResult.reference.X(:,1));
simResult.Xhat(:,1) = simResult.reference.X(:,1);
simResult.U = simResult.reference.U(:,1:end);
simResult.T = simResult.reference.T(1:end);

if flg.bilinear == 1     
    for i = 1:1:simResult.reference.N-2
        simResult.Z(:,i+1) = est.ABE'*[simResult.Z(:,i);simResult.U(:,i);reshape(kron(simResult.Z(:,i),simResult.U(:,i)),[],1)];
    end
else
    for i = 1:1:simResult.reference.N-2
        simResult.Z(:,i+1) = est.A * simResult.Z(:,i) + est.B * simResult.U(:,i);
    end
end
simResult.Xhat = est.C * simResult.Z;

%% Save Estimation Result(結果保存場所)
if size(Data.X,1)==13
    simResult.state.p = simResult.Xhat(1:3,:);
    simResult.state.q = simResult.Xhat(4:7,:);
    simResult.state.v = simResult.Xhat(8:10,:);
    simResult.state.w = simResult.Xhat(11:13,:);
else
    simResult.state.p = simResult.Xhat(1:3,:);
    simResult.state.q = simResult.Xhat(4:6,:);
    simResult.state.v = simResult.Xhat(7:9,:);
    simResult.state.w = simResult.Xhat(10:12,:);
end
simResult.state.N = simResult.reference.N-1;

save(targetpath,'est','Data','simResult')
disp('Saved to')
disp(targetpath)

%% プロット

% plotResult
%% 
% F = @(x) [x;1]; % 状態そのまま
% F = @quaternionParameter; % クォータニオンを含む13状態の観測量
% F = @eulerAngleParameter; % 姿勢角をオイラー角モデルの状態方程式からdq/dt部分を抜き出した観測量
% F = @eulerAngleParameter_withinConst; % eulerAngleParameter+慣性行列を含む部分(dvdt)を含む観測量
% F = @eulerAngleParameter_InputAndConst; % eulerAngleParameter_withinConst+入力にかかる係数行列の項を含む観測量
% F = @quaternions; % 状態+クォータニオンの1乗2乗3乗 オイラー角パラメータ用(動作確認済み) <こちらが最新の観測量>
% F = @quaternions_13state; % 状態+クォータニオンの1乗2乗3乗 クォータニオンパラメータ用
% F = @eulerAngleParameter_withoutP;

