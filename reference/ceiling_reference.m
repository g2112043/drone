classdef ceiling_reference < REFERENCE_CLASS
    % 時間関数としてのリファレンスを生成するクラス
    % obj = TIME_VARYING_REFERENCE()
    properties
        param
        func % 時間関数のハンドル
        self
        margin
        t=[];
        cha='s';
        dfunc
    end

    methods
        function obj = ceiling_reference(self, args)
            % 【Input】ref_gen, param, "HL"
            % ref_gen : reference function generator
            % param : parameter to generate the reference function
            % "HL" : flag to decide the reference for HL
            arguments
                self
                args
            end
            obj.self = self;
            gen_func_name = str2func(args{1});
            param_for_gen_func = args{2};
            obj.func = gen_func_name(param_for_gen_func);
            if length(args) > 2
                if strcmp(args{3}, "HL")
                    obj.func = gen_ref_for_HL(obj.func);
                    obj.result.state = STATE_CLASS(struct('state_list', ["xd", "p", "q", "v"], 'num_list', [20, 3, 3, 3]));
                end
            else
                obj.result.state = STATE_CLASS(struct('state_list', ["xd", "p", "q", "v"], 'num_list', [length(obj.func(0)), 3, 3, 3]));
            end
        end
        function result = do(obj, Param)  
           %Param={time,FH}　目標位置の算出
           obj.cha = get(Param{2}, 'currentcharacter');
           if obj.cha=='f'&& ~isempty(obj.t)    %flightからreferenceの時間を開始
                t = Param{1}.t-obj.t; % 現在時刻 ‐ 前時刻
                obj.t=Param{1}.t; %前時刻の保存
           else %前時刻の保存
                obj.t=Param{1}.t;
                t = obj.t;
           end
           %% 自己位置
           p = obj.self.estimator.result.state.p;%自己位置
           yaw = 0;%目標位置への角度
           y_marjin = 1.5;
           %% x座標
           goal_potential = obj.func(t);%目標位置に向かうポテンシャル 
           obs_potential_x = -obj.func(t)/(Param{3}-p(1))^2;%*((y_marjin-p(2))/y_marjin);%障害物からのポテンシャル
           %obs_potential_x = -obj.func(t)/(obj.self.sensor.VL.result.distance(2))^2;%*((y_marjin-p(2))/y_marjin);%障害物からのポテンシャル(実験用)
           obj.result.state.p = obs_potential_x + goal_potential;%potentialの合成
           obj.result.state.p(1) = p(1) + obj.result.state.p(1);%現在位置にpotentialを付与
           
           %% y座標
%             obs_potential_y = -obj.func(t)/(-obj.self.estimator.result.state.p(2))^2;%障害物からのポテンシャル
%             obj.result.state.p(6) = goal_potential(6);
%             obj.result.state.p(2) = p(2) +goal_potential(2);%obj.result.state.p(2);%現在位置にpotentialを付与
           %% %sensorの値から高度を指定　z座標
           margin_z = Param{4};
           obj.result.state.p(3) = obj.self.sensor.celing.result.ceiling_distance + p(3) - margin_z;%z方向の目標位置
%            obj.result.state.p(3) = obj.self.sensor.VL.result.distance(1) + p(3) - margin_z;%z方向の目標位置(実験用)
           %% 目標位置にたどり着いたか
           if obj.cha =='f'
               if norm(Param{5}(1)-obj.self.reference.result.state.p(1)) < 0.1%目標位置にたどり着いたか
                   obj.result.state.p(1) = p(1);%Param{5}(1);%その場停滞
                   obj.result.state.p(5) = 0;
               end
%                if norm(Param{5}(2)-obj.self.reference.result.state.p(2)) < 0.1%目標位置にたどり着いたか
%                    obj.result.state.p(2) = Param{5}(2);%その場停滞
%                end
           end
           result = obj.result;
        end
        function show(obj, logger)
            rp = logger.data(1,"p","r");
            plot3(rp(:,1), rp(:,2), rp(:,3));                     % xy平面の軌道を描く
            daspect([1 1 1]);
            hold on
            ep = logger.data(1,"p","e");
            plot3(ep(:,1), ep(:,2), ep(:,3));       % xy平面の軌道を描く
            legend(["reference", "estimate"]);
            title('reference and estimated trajectories');
            xlabel("x [m]");
            ylabel("y [m]");
            hold off
        end
    end
end


