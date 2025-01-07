% clc; close all;
% 
% % 動画設定
% ax = gca;
% v = VideoWriter("newfile_with_orientation.avi");
% v.Quality = 100;
% v.FrameRate = 5;
% open(v)
% 
% % ユーザーに開始時刻と終了時刻を指定させる
% prompt1 = "開始時刻を指定してください (1～" + num2str(logger.k) + "): ";
% start_time = input(prompt1);
% prompt2 = "終了時刻を指定してください (" + num2str(start_time) + "～" + num2str(logger.k) + "): ";
% end_time = input(prompt2);
% 
% % 入力チェック
% if start_time < 1 || end_time > logger.k || start_time > end_time
%     error('指定された時刻が不正です。正しい範囲で再入力してください。');
% end
% 
% % 全体の長さ
% total_frames = end_time - start_time + 1;
% 
% % 指定された範囲で動画を生成
% for j = start_time:end_time
%     scatter(agent.estimator.fixedSeg.Location(:,1), agent.estimator.fixedSeg.Location(:,2), 10, "filled")
%     hold(ax, "on")
% 
%     pr_x(j) = logger.Data.agent.reference.result{1,j}.state.p(1,1);
%     pr_y(j) = logger.Data.agent.reference.result{1,j}.state.p(2,1);
%     plot(pr_x, pr_y, "pentagram", "MarkerSize", 20)
% 
%     ndtpc = pctransform(logger.Data.agent.estimator.result{1,j}.ndtPCdata, ...
%         logger.Data.agent.estimator.result{1,j}.tform);
%     scatter(ndtpc.Location(:,1), ndtpc.Location(:,2), 1, "filled");
% 
%     scatter(logger.Data.agent.estimator.result{1,j}.state.p(1), ...
%         logger.Data.agent.estimator.result{1,j}.state.p(2), ...
%         'MarkerFaceColor', [1 0 0]);
% 
%     % ロボットの向きを矢印で描画
%     % ロボットのオリエンテーションがオイラー角（yaw, pitch, roll）で得られる場合
%     q = logger.Data.agent.estimator.result{1,j}.state.q;  % オリエンテーション（クォータニオンかオイラー角）
%     yaw = q(3);  % yaw角（z軸の回転、ロボットの進行方向に対応）
% 
%     % 矢印のベクトルを計算
%     arrow_length = 0.5;  % 矢印の長さ（適宜調整）
%     x_dir = arrow_length * cos(yaw);  % x方向のベクトル
%     y_dir = arrow_length * sin(yaw);  % y方向のベクトル
% 
%     % 現在のロボットの位置
%     robot_x = logger.Data.agent.estimator.result{1,j}.state.p(1);
%     robot_y = logger.Data.agent.estimator.result{1,j}.state.p(2);
% 
%     % 矢印をプロット（ロボットの向きを表す）
%     quiver(robot_x, robot_y, x_dir, y_dir, 'MaxHeadSize', 10, 'Color', 'b', 'LineWidth', 2);
% 
%     % 現時刻を表示
%     current_time_text = ['Time: ', num2str(j)];
%     text(min(xlim), max(ylim), current_time_text, 'Color', 'black', 'FontSize', 12, 'VerticalAlignment', 'top', 'HorizontalAlignment', 'left');
% 
%     % 時間経過バーを追加
%     progress = (j - start_time + 1) / total_frames;
%     bar_x = [min(xlim) min(xlim) + progress * range(xlim)];
%     bar_y = [min(ylim) min(ylim)];
%     line(bar_x, bar_y, 'Color', 'blue', 'LineWidth', 5);
% 
%     drawnow
%     frame = getframe(ax);
%     writeVideo(v, frame);
%     hold(ax, "off")
% end
% 
% close(v)

clc; close all;

% 動画設定
ax = gca;
v = VideoWriter("newfile_with_orientation.avi");
v.Quality = 100;
v.FrameRate = 5;
open(v)

% ユーザーに開始時刻と終了時刻を指定させる
prompt1 = "開始時刻を指定してください (1～" + num2str(logger.k) + "): ";
start_time = input(prompt1);
prompt2 = "終了時刻を指定してください (" + num2str(start_time) + "～" + num2str(logger.k) + "): ";
end_time = input(prompt2);

% 入力チェック
if start_time < 1 || end_time > logger.k || start_time > end_time
    error('指定された時刻が不正です。正しい範囲で再入力してください。');
end

% 全体の長さ
total_frames = end_time - start_time + 1;

% リファレンスポイントの軌跡データを準備
pr_x = [];
pr_y = [];

% 指定された範囲で動画を生成
for j = start_time:end_time
    scatter(agent.estimator.fixedSeg.Location(:,1), agent.estimator.fixedSeg.Location(:,2), 10, "filled")
    hold(ax, "on")

    % リファレンスポイントを取得し、デバッグ用に表示
    ref_x = logger.Data.agent.reference.result{1, j}.state.p(1); % 修正箇所
    ref_y = logger.Data.agent.reference.result{1, j}.state.p(2); % 修正箇所
    disp(['Frame ', num2str(j), ': Reference Point = (', num2str(ref_x), ', ', num2str(ref_y), ')']);

    % 軌跡データに追加
    pr_x = [pr_x, ref_x];
    pr_y = [pr_y, ref_y];

    % リファレンスポイントの過去軌跡を描画
    plot(pr_x, pr_y, "pentagram", "MarkerSize", 10, "Color", [0.5, 0.5, 0.5]);

    % 現在のリファレンスポイントを強調表示
    scatter(ref_x, ref_y, 100, "red", "filled", "DisplayName", "Current Reference");

    % NDT点群データを黄色に設定して描画
    ndtpc = pctransform(logger.Data.agent.estimator.result{1, j}.ndtPCdata, ...
        logger.Data.agent.estimator.result{1, j}.tform);
    scatter(ndtpc.Location(:,1), ndtpc.Location(:,2), 1, 'filled', ...
        'MarkerEdgeColor', [1, 0.647, 0], 'MarkerFaceColor', [1, 0.647, 0]); % 黄色に設定

    % 現在のロボット位置を描画
    scatter(logger.Data.agent.estimator.result{1, j}.state.p(1), ...
        logger.Data.agent.estimator.result{1, j}.state.p(2), ...
        'MarkerFaceColor', [1 0 0]);

    % ロボットの向きを矢印で描画
    q = logger.Data.agent.estimator.result{1, j}.state.q;
    yaw = q(3);
    arrow_length = 0.5;
    x_dir = arrow_length * cos(yaw);
    y_dir = arrow_length * sin(yaw);
    robot_x = logger.Data.agent.estimator.result{1, j}.state.p(1);
    robot_y = logger.Data.agent.estimator.result{1, j}.state.p(2);
    quiver(robot_x, robot_y, x_dir, y_dir, 'MaxHeadSize', 10, 'Color', 'b', 'LineWidth', 2);

    % 現時刻を表示
    current_time_text = ['Time: ', num2str(j)];
    text(min(xlim), max(ylim), current_time_text, 'Color', 'black', 'FontSize', 12, 'VerticalAlignment', 'top', 'HorizontalAlignment', 'left');

    % 時間経過バーを追加
    progress = (j - start_time + 1) / total_frames;
    bar_x = [min(xlim) min(xlim) + progress * range(xlim)];
    bar_y = [min(ylim) min(ylim)];
    line(bar_x, bar_y, 'Color', 'blue', 'LineWidth', 5);

    drawnow
    frame = getframe(ax);
    writeVideo(v, frame);
    hold(ax, "off")
end

close(v)

