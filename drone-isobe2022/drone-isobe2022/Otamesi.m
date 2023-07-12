close all hidden;
clear all;
clc;

%% データのインポート
load("experiment_7_11_circle_radius=0.7.mat") %読み込むデータファイルの設定
% load("simulation_7_5_saddle.mat")
disp('load finished')

for i = find(log.Data.phase==102,1,'first')+220:find(log.Data.phase==108,1,'first')
    data.t(1,i-(find(log.Data.phase==102,1,'first')+220)+1) = log.Data.t(i,1);                                      %時間t
    data.p(:,i-(find(log.Data.phase==102,1,'first')+220)+1) = log.Data.agent.estimator.result{i}.state.p(:,1);      %位置p               %入力
end

figure(1)
plot(data.p(1,:),data.p(2,:));
grid on