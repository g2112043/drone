clc; close all;

% 動画設定
ax = gca;
v = VideoWriter("newfile.avi");
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

% 指定された範囲で動画を生成
for j = start_time:end_time
    scatter(agent.estimator.fixedSeg.Location(:,1), agent.estimator.fixedSeg.Location(:,2), 10, "filled")
    hold(ax, "on")
    
    pr_x(j) = logger.Data.agent.reference.result{1,j}.state.p(1,1);
    pr_y(j) = logger.Data.agent.reference.result{1,j}.state.p(2,1);
    plot(pr_x, pr_y, "pentagram", "MarkerSize", 20)
    
    ndtpc = pctransform(logger.Data.agent.estimator.result{1,j}.ndtPCdata, ...
        logger.Data.agent.estimator.result{1,j}.tform);
    scatter(ndtpc.Location(:,1), ndtpc.Location(:,2), 1, "filled");
    
    scatter(logger.Data.agent.estimator.result{1,j}.state.p(1), ...
        logger.Data.agent.estimator.result{1,j}.state.p(2), ...
        'MarkerFaceColor', [1 0 0]);
    
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