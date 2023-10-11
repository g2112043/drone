classdef MPC_controller_Koopman < handle
    % MCMPC_CONTROLLER MPCのコントローラー
    % Imai Case study 
    % 勾配MPCコントローラー

    properties
%         options
        param
        current_state
        previous_input
        previous_state
        input
        state
        const
        reference
        fRemove
        model
        result
        self
    end

    methods
        function obj = MPC_controller_Koopman(self, param)
            %-- 変数定義
            obj.self = self; %agentへの接続
            %---MPCパラメータ設定---%
            obj.param = param.param; %Controller_MPC_Koopmanの値を保存

            %%
            obj.input = obj.param.input;
            % obj.const = param.const;
            % obj.input.v = obj.input.u;   % 前ステップ入力の取得，評価計算用
%             obj.param.H = obj.param.H + 1; %なぜ？
            obj.model = self.plant;
            
            %% 入力
            obj.result.input = zeros(self.estimator.model.dim(2),1); % 入力初期値

            %% 重み　統合
%             obj.param.Weight = blkdiag(obj.param.P, obj.param.Q, obj.param.V, obj.param.W);
%             obj.param.Weightf = blkdiag(obj.param.P, obj.param.Qf, obj.param.Vf, obj.param.Wf);
            
            obj.previous_input = repmat(obj.input.u, 1, obj.param.H);

        end

        %-- main()的な
        function result = do(obj,varargin)
            tic
            % profile on
            % varargin 
            % 1:TIME,  2:flight phase,  3:LOGGER,  4:?,  5:agent,  6:1?
            obj.param.t = varargin{1}.t;
            rt = obj.param.t; %時間
            idx = round(rt/varargin{1}.dt+1); %プログラムの周回数

            obj.state.ref = obj.Reference(rt); %リファレンスの更新
            obj.current_state = obj.self.estimator.result.state.get(); %現在状態
%             currentstate = obj.current_state;
            Param = obj.param;
            Param.current = obj.current_state;
            Param.ref = obj.state.ref;
            obj.previous_state = repmat(obj.current_state, 1, obj.param.H);

            % MPC設定(problem)
            %-- fmincon 設定
            options = optimoptions('fmincon');
            %     options = optimoptions(options,'Diagnostics','off');
            %     options = optimoptions(options,'MaxFunctionEvaluations',1.e+12);     % 評価関数の最大値
            options = optimoptions(options,'MaxIterations',      1.e+9); % 最大反復回数
            options = optimoptions(options,'ConstraintTolerance',1.e-3);     % 制約違反に対する許容誤差
            
            %-- fmincon設定
            options.Algorithm = 'sqp';  % 逐次二次計画法
            options.Display = 'none';   % 計算結果の表示
            problem.solver = 'fmincon'; % solver
            problem.options = options;  %

            x0 = [obj.previous_input];        % 状態，入力を初期値とする              % 現在状態
            A = [];
            b = [];
            Aeq = [];
            beq = [];
            lb = [];
            ub = [];
            nonlcon = [];

%             [var, fval, exitflag, ~, ~, ~, ~] = fmincon(@(x) Objective(obj,x),x0,A,b,Aeq,beq,lb,ub,nonlcon,problem); %最適化計算
            [var, fval, exitflag, ~, ~, ~, ~] = fmincon(@(x) Objective_mex(Param,x),x0,A,b,Aeq,beq,lb,ub,nonlcon,problem);

            %%
            obj.previous_input = var;
            % obj.previous_input = repmat(var(13:16,1), 1, obj.param.H);
            % obj.previous_input = repmat(obj.param.ref_input, 1, obj.param.H);

            obj.result.input = var(:, 1); % 印加する入力 4入力

            %% データ表示用
            obj.input.u = obj.result.input; 

            %% 保存するデータ
            result = obj.result; % controllerの値の保存
            % profile viewer

            %% 情報表示
            state_monte = obj.self.estimator.result.state;
            fprintf("==================================================================\n")
            fprintf("==================================================================\n")
            fprintf("ps: %f %f %f \t vs: %f %f %f \t qs: %f %f %f \n",...
                    state_monte.p(1), state_monte.p(2), state_monte.p(3),...
                    state_monte.v(1), state_monte.v(2), state_monte.v(3),...
                    state_monte.q(1)*180/pi, state_monte.q(2)*180/pi, state_monte.q(3)*180/pi); % s:state 現在状態
            fprintf("pr: %f %f %f \t vr: %f %f %f \t qr: %f %f %f \n", ...
                    obj.state.ref(1,1), obj.state.ref(2,1), obj.state.ref(3,1),...
                    obj.state.ref(7,1), obj.state.ref(8,1), obj.state.ref(9,1),...
                    obj.state.ref(4,1)*180/pi, obj.state.ref(5,1)*180/pi, obj.state.ref(6,1)*180/pi)                             % r:reference 目標状態
            fprintf("t: %f \t input: %f %f %f %f \t fval: %f \t flag: %d", ...
                rt, obj.input.u(1), obj.input.u(2), obj.input.u(3), obj.input.u(4), fval, exitflag);
%             fprintf("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
            fprintf("\n");

            %% z < 0で終了
            if obj.self.estimator.result.state < 0
                warning("墜落しました")
            end
            calT = toc
        end
        function show(obj)
            obj.result
        end

        function [xr] = Reference(obj, T)
            % パラメータ取得
            % timevaryingをホライズンごとのreferenceに変換する
            % params.dt = 0.1;
            xr = zeros(obj.param.total_size, obj.param.H);    % initialize
            % 時間関数の取得→時間を代入してリファレンス生成
            RefTime = obj.self.reference.func;    % 時間関数の取得
            for h = 0:obj.param.H-1
                t = T + obj.param.dt * h; % reference生成の時刻をずらす
                ref = RefTime(t);
                xr(1:3, h+1) = ref(1:3);
                xr(7:9, h+1) = ref(5:7);
                xr(4:6, h+1) =   [0;0;0]; % 姿勢角
                xr(10:12, h+1) = [0;0;0];
                xr(13:16, h+1) = obj.param.ref_input; % MC -> 0.6597,   HL -> 0
            end
        end
    end
end
