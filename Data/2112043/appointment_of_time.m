% プロット関数のコメントアウト部分は不要
% plot(logger.Data.agent.estimator.result{1,3}.state.p(1), ...
%     logger.Data.agent.estimator.result{1,3}.state.p(2),'r*');

% 初期設定
clc; close all;

% ユーザーに時刻を指定させる
prompt = "プロットする時刻を指定してください (1～" + num2str(logger.k) + "): ";
t = input(prompt);

% 指定された時刻におけるデータをプロット
figure;

% agent.estimator.fixedSegのポイントクラウドデータをプロット
scatter(agent.estimator.fixedSeg.Location(:,1), agent.estimator.fixedSeg.Location(:,2), 10, "filled");
hold on;

% 参照状態のプロット
pr_x = logger.Data.agent.reference.result{1,t}.state.p(1,1);
pr_y = logger.Data.agent.reference.result{1,t}.state.p(2,1);
plot(pr_x, pr_y, "pentagram", "MarkerSize", 20);

% NDTポイントクラウドデータの変換とプロット
ndtpc = pctransform(logger.Data.agent.estimator.result{1,t}.ndtPCdata, logger.Data.agent.estimator.result{1,t}.tform);
scatter(ndtpc.Location(:,1), ndtpc.Location(:,2), 1, "filled");

% 現在の状態のプロット
scatter(logger.Data.agent.estimator.result{1,t}.state.p(1), ...
    logger.Data.agent.estimator.result{1,t}.state.p(2), ...
    'MarkerFaceColor', [1 0 0]);

hold off;

title(['時刻 ', num2str(t), ' におけるデータプロット']);
xlabel('X');
ylabel('Y');
legend('fixedSeg Points', 'Reference State', 'NDT Transformed Points', 'Current State');
