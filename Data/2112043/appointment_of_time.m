% % プロット関数のコメントアウト部分は不要
% % plot(logger.Data.agent.estimator.result{1,3}.state.p(1), ...
% %     logger.Data.agent.estimator.result{1,3}.state.p(2),'r*');
% 
% % 初期設定
% clc; close all;
% 
% % ユーザーに時刻を指定させる
% prompt = "プロットする時刻を指定してください (1～" + num2str(logger.k) + "): ";
% t = input(prompt);
% 
% % 指定された時刻におけるデータをプロット
% figure;
% 
% % agent.estimator.fixedSegのポイントクラウドデータをプロット
% scatter(agent.estimator.fixedSeg.Location(:,1), agent.estimator.fixedSeg.Location(:,2), 10, "filled");
% hold on;
% 
% % 参照状態のプロット
% pr_x = logger.Data.agent.reference.result{1,t}.state.p(1,1);
% pr_y = logger.Data.agent.reference.result{1,t}.state.p(2,1);
% plot(pr_x, pr_y, "pentagram", "MarkerSize", 20);
% 
% % NDTポイントクラウドデータの変換とプロット
% ndtpc = pctransform(logger.Data.agent.estimator.result{1,t}.ndtPCdata, logger.Data.agent.estimator.result{1,t}.tform);
% scatter(ndtpc.Location(:,1), ndtpc.Location(:,2), 1, "filled");
% 
% % 現在の状態のプロット
% scatter(logger.Data.agent.estimator.result{1,t}.state.p(1), ...
%     logger.Data.agent.estimator.result{1,t}.state.p(2), ...
%     'MarkerFaceColor', [1 0 0]);
% 
% hold off;
% 
% title_handle =title(['時刻 ', num2str(t), ' におけるデータプロット']);
% xlabel('X[m]');
% ylabel('Y[m]');
% 
% lgd=legend('fixedSeg Points', 'Reference State', 'NDT Transformed Points', 'Current State');
% 
% xlabel_handle = xlabel('X[m]');
% ylabel_handle = ylabel('Y[m]');
% 
% title_handle.FontSize = 14; % タイトルのフォントサイズを16に設定
% xlabel_handle.FontSize = 14; % 横軸ラベルのフォントサイズを14に設定
% ylabel_handle.FontSize = 14; % 縦軸ラベルのフォントサイズを14に設定
% % 凡例のフォントサイズを変更
% lgd.FontSize = 14; % フォントサイズを14に設定（例）

% 初期設定
clc; close all;

% ユーザーに時刻を指定させる
prompt = "プロットする時刻を指定してください (1～" + num2str(logger.k) + "): ";
t = input(prompt);

% 入力チェック
if t < 1 || t > logger.k
    error('指定された時刻が不正です。正しい範囲で再入力してください。');
end

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
current_x = logger.Data.agent.estimator.result{1,t}.state.p(1);
current_y = logger.Data.agent.estimator.result{1,t}.state.p(2);
scatter(current_x, current_y, 'MarkerFaceColor', [1 0 0]);

% ロボットの向きを矢印で描画
% ロボットのオリエンテーションがオイラー角（yaw, pitch, roll）で得られる場合
q = logger.Data.agent.estimator.result{1,t}.state.q;  % オリエンテーション（クォータニオンかオイラー角）
yaw = q(3);  % yaw角（z軸の回転、ロボットの進行方向に対応）

% 矢印のベクトルを計算
arrow_length = 0.5;  % 矢印の長さ（適宜調整）
x_dir = arrow_length * cos(yaw);  % x方向のベクトル
y_dir = arrow_length * sin(yaw);  % y方向のベクトル

% 矢印をプロット（ロボットの向きを表す）
quiver(current_x, current_y, x_dir, y_dir, 'MaxHeadSize', 10, 'Color', 'b', 'LineWidth', 2);

hold off;

% グラフの装飾
title(['時刻 ', num2str(t), ' におけるデータプロット']);
xlabel('X[m]');
ylabel('Y[m]');

legend('fixedSeg Points', 'Reference State', 'NDT Transformed Points', 'Current State', 'Orientation');
