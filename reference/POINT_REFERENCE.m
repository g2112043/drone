% classdef POINT_REFERENCE < handle
%     properties
%         param
%         self
%         result
% 
%         pointflag = 1
%         point
% 
%     end
% 
%     methods
%         function obj = POINT_REFERENCE(self,sample_param)
%             % 参照
%             obj.self = self;
%             obj.result.state = state_copy(obj.self.estimator.model.state);
%             obj.param = sample_param;
%             obj.result.state.set_state(obj.param.point(1));
%         end
%         function  result= do(obj,varargin)
%             % 【Input】result = {Xd(optional)}
%             pe = obj.self.estimator.result.state.p - obj.param.point(obj.pointflag).p;
%             qe = obj.self.estimator.result.state.q - obj.param.point(obj.pointflag).q;
%             if vnorm(pe - qe) < obj.param.threshold && obj.pointflag < obj.param.num
%                 obj.pointflag = obj.pointflag + 1;%フラグ更新
%                 if obj.pointflag <= obj.param.num
%                     obj.result.state.set_state(obj.param.point(obj.pointflag));
%                     disp("flag passed")
%                 end
%             end
% 
%             result=obj.result;
%         end
%         function show(obj,param)            
%         end
%     end
% end

%%
% 
% classdef POINT_REFERENCE < handle
%     properties
%         param
%         self
%         result
%         pointflag = 1
%         point
%         goal  % ゴールのポイントを保持するプロパティ
%     end
% 
%     methods
%         function obj = POINT_REFERENCE(self, sample_param)
%             % Initialization
%             obj.self = self;
%             obj.result.state = state_copy(obj.self.estimator.model.state);
%             obj.param = sample_param;
%             obj.result.state.set_state(obj.param.point(1)); % 初期のリファレンスポイントを設定
% 
%             % ゴールポイントをparamから設定
%             obj.goal = obj.param.goal_point;  % ゴールとして、sample_paramで設定されたものを保持
%         end
% 
% %         function result = do(obj, varargin)
% %     % 【Input】result = {Xd(optional)}
% %     pe = obj.self.estimator.result.state.p - obj.param.point(obj.pointflag).p;
% %     qe = obj.self.estimator.result.state.q - obj.param.point(obj.pointflag).q;
% % 
% %     if vnorm(pe - qe) < obj.param.threshold
% %         % フラグ更新
% %         obj.pointflag = obj.pointflag + 1;
% % 
% %         % pointflag が num の範囲内であることを確認
% %         if obj.pointflag <= obj.param.num
% %             obj.result.state.set_state(obj.param.point(obj.pointflag));
% %             disp("flag passed");
% %         else
% %             disp("All points processed.");
% %         end
% %     end
% % 
% %     result = obj.result;
% % end
% 
%     function result = do(obj, varargin)
%         % 【Input】result = {Xd(optional)}
%         pe = obj.self.estimator.result.state.p - obj.param.point(obj.pointflag).p;
%         qe = obj.self.estimator.result.state.q - obj.param.point(obj.pointflag).q;
% 
%         % 位置のずれを確認する閾値（例: 1.0メートル）
%         distance_threshold = 0.25;
%         current_position = obj.self.estimator.result.state.p;
%         ref_position = obj.param.point(obj.pointflag).p;
% 
%         % 推定位置がリファレンスポイントから大きくずれているかを確認
%         if vnorm(current_position - ref_position) > distance_threshold
%             % 大きくずれている場合、現在のリファレンスポイントに「戻る」処理
%             disp("Position drifted significantly; attempting to return to previous point.");
%             obj.result.state.set_state(obj.param.point(obj.pointflag));
%         else
%             % 通常のリファレンスポイント更新処理
%             if vnorm(pe - qe) < obj.param.threshold
%                 % フラグ更新
%                 obj.pointflag = obj.pointflag + 1;
% 
%                 % pointflag が num の範囲内であることを確認
%                 if obj.pointflag <= obj.param.num
%                     obj.result.state.set_state(obj.param.point(obj.pointflag));
%                     disp("flag passed");
%                 else
%                     disp("All points processed.");
%                 end
%             end
%         end
% 
%         result = obj.result;
%     end
% 
% 
%         function next_point = decide_next_point(obj)
%     current_point = obj.param.point(obj.pointflag); % 現在のリファレンスポイント
%     goal_point = obj.param.goal_point; % ゴールポイントを取得
%     candidates = []; % 候補リストの初期化
% 
%     % リファレンスポイントの候補を探す
%     for i = 1:obj.param.num
%         candidate_point = obj.param.point(i);
%         % xまたはy座標が同じで、ゴールに近いポイントを候補に追加
%         if (candidate_point.p(1) == current_point.p(1) || candidate_point.q(1) == current_point.q(1))
%             candidates = [candidates; candidate_point]; % 候補として追加
%         end
%     end
% 
%     % コストを計算し、最もコストの低いポイントを選択
%     min_cost = inf; % 無限大で初期化
%     for j = 1:length(candidates)
%         cost = obj.estimate_cost(candidates(j), goal_point);
%         if cost < min_cost
%             min_cost = cost;
%             next_point = candidates(j);
%         end
%     end
% end
% 
%         function cost = estimate_cost(obj, candidate_point, goal_point)
%     % ゴールへのユークリッド距離をコストとして計算
%     cost = sqrt((candidate_point.p - goal_point.p).^2 + (candidate_point.q - goal_point.q).^2);
% end
% 
% 
%         function show(obj, param)            
%         end
%     end
% end

%%

classdef POINT_REFERENCE
    properties
        M           % 隣接行列：各ノード間の距離を格納
        startNode   % 始点ノード
        goalNode    % ゴールノード
        currentNode % 現在のノード
        path        % 最短経路
        pathIndex   % 経路上の現在のインデックス
    end

    methods
        % コンストラクタ
        function obj = POINT_REFERENCE(M, startNode, goalNode)
            obj.M = M;
            obj.startNode = startNode;
            obj.goalNode = goalNode;
            obj.currentNode = startNode;
            obj.path = obj.calculateShortestPath();
            obj.pathIndex = 1;
        end

        % 最短経路計算メソッド（Dijkstraアルゴリズムに相当する手動実装）
        function path = calculateShortestPath(obj)
            I = 1:size(obj.M, 1);   % インデックスのリスト
            V = inf(size(I));       % 各ノードまでのコストを初期化（無限大）
            V(obj.startNode) = 0;   % 始点ノードのコストを0に設定
            H = zeros(size(obj.M, 1)^2, 5); % 履歴行列

            H(1,:) = [1, 1, 0, obj.startNode, 0]; % 初期設定
            lH = 1; % 履歴の長さ

            for i = 2:size(obj.M, 1)
                ids = H(:,2) == i - 1; % 前の世代のノード
                v0 = H(ids, 4);        % 前のノード
                V0 = H(ids, 5);        % 前のノードまでのコスト
                Vi = obj.M(:, v0);     % 次のノードまでの距離

                for col = 1:size(Vi, 2)
                    lH = find(H(:,1) == 0, 1) - 1;
                    V = Vi(:, col);
                    vi = find(V);
                    ei = V ~= 0;
                    V(ei) = V(ei) + V0(col);

                    TV = V;
                    TV(TV == 0) = inf;
                    V(V == 0) = inf;

                    mini = find(V < TV);
                    V(mini) = TV(mini);

                    ids = (lH+1:lH+length(mini))';
                    H(ids,:) = [ids, repmat([i, col], length(ids), 1), mini, V(mini)];
                end

                ngen = find(H(:,1) == 0, 1) - 1 - lH;
                lH = find(H(:,1) == 0, 1) - 1;

                if ngen == 0
                    break;
                end
            end

            % スタートからゴールまでの経路を生成
            nid = obj.goalNode;
            id = H(:,4) == nid;
            gen = H(id, 2);
            path = zeros(1, gen);
            path(end) = obj.goalNode;

            for g = gen - 1:-1:1
                gid = H(:,2) == g;
                tmp = H(gid, :);
                tmp = tmp(H(id, 3), :);
                nid = tmp(4);
                id = tmp(1);
                path(g) = nid;
            end
        end

        % 次のポイントを取得するメソッド
        function nextPoint = getNextPoint(obj)
            if obj.pathIndex < length(obj.path)
                obj.pathIndex = obj.pathIndex + 1;
                nextPoint = obj.path(obj.pathIndex);
                obj.currentNode = nextPoint;
            else
                nextPoint = obj.goalNode; % ゴールに到達した場合はゴールノードを返す
            end
        end

        % 実行メソッド
        function do(obj)
            while obj.currentNode ~= obj.goalNode
                nextPoint = obj.getNextPoint();
                disp(['Moving to next point: ', num2str(nextPoint)]);
                obj.currentNode = nextPoint;
            end
            disp('Goal reached.');
        end
    end
end
