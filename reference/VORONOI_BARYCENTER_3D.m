classdef VORONOI_BARYCENTER_3D < REFERENCE_CLASS
    %3次元ボロノイ重心を算出するクラス
    %   詳細説明をここに記述
    
    properties
        param
        self
        fShow
        id
    end
    
    methods
        function obj = VORONOI_BARYCENTER_3D(self,param)
            arguments
                self
                param
            end
            obj.self = self;
            obj.param = param;
            obj.result.state = STATE_CLASS(struct('state_list',"p",'num_list',3));
            obj.fShow = param.fShow;
            obj.id = self.sensor.motive.rigid_num;
        end
        
        function result = do(obj,~)
            % param = range, pos_range, d, void
            % 【Output】 result = 目標値（グローバル座標）
            %% 共通設定１：ボロノイセル確定
            sensor = obj.self.sensor.result;
            state = obj.self.estimator.result.state;
            if isfield(sensor,'neighbor')
                neighbor = sensor.neighbor; % 通信領域内の他機体位置　グローバル座標
            elseif isfield(sensor,'rigid')
                neighbor = [sensor.rigid(1:size(sensor.rigid,2) ~= obj.id).p];
            end

            % ここから相対座標
            Ps = -6*[1,1,1]+ 12*[0,0,0;0,1,0;1,0,0;1,1,0;0,0,1;0,1,1;1,0,1;1,1,1]; %ボロノイ分割用の座標ベクトル
            if ~isempty(neighbor) && obj.id == 1
                Ps = [state.p';neighbor(:,1)';neighbor(:,2)';Ps];
            elseif ~isempty(neighbor) && obj.id == 2
                Ps = [neighbor(:,1)';state.p';neighbor(:,2)';Ps];
            elseif ~isempty(neighbor) && obj.id == 3
                Ps = [neighbor(:,1)';neighbor(:,2)';state.p';Ps];
            else
                Ps = [state.p';Ps];
            end
            [v,c] = voronoin(Ps); % 3次元ボロノイ分割
            %% 共通設定２：3次元ボロノイセルの重み確定
            [k{obj.id},~] = convhull(v(c{obj.id},1),v(c{obj.id},2),v(c{obj.id},3),'Simplify',true); % エージェント周りのボロノイ空間
            TR = triangulation(k{obj.id},v(c{obj.id},1),v(c{obj.id},2),v(c{obj.id},3)); % 三角形分割
            F = faceNormal(TR); % 三角形分割した面に対する法線ベクトル
            Ptri = incenter(TR); % 三角形分割した面の内心

            [qx,qy,qz] = meshgrid(-2:obj.param.void:2,-2:obj.param.void:2,-2:obj.param.void:2);
            bx = [reshape(qx,[numel(qx),1]),reshape(qy,[numel(qx),1]),reshape(qz,[numel(qx),1])];

            % 領域質量
            zo = find(max(sum(Ptri.*F,2) - (F*bx') < 0,[],1) == 0);
            phi_d = normpdf(vecnorm(obj.param.phi0 - bx(zo,:),2,2),0,0.5); % 重み位置と領域内ボクセルとの距離の正規分布関数
            weight_bx = bx(zo,:).*phi_d; % 重み付きボクセル
            dmass = sum(weight_bx,1); % 各方向の重みを合算
            mass = sum(phi_d,"all"); % 全部の重みを合算

            % 領域重心
            cent = dmass / mass; % 重心

            % 描画用変数
            obj.result.state.p = cent';
            result = obj.result;
            if obj.fShow
                obj.show();
            end
        end

        function show(obj,Env)
        end
    end
end

