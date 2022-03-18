classdef TrackingMPCMEX_Controller <CONTROLLER_CLASS
    %MPC_CONTROLLER MPCのコントローラー
    %   fminiconで車両モデルに対するMPC
    %   目標点を追従する
    
    properties
        options
        param
        previous_input
        previous_state
        model
        NoiseR
        SensorRange
        RangeGain
        result
        self
        SolverName
    end
    
    methods
        function obj = TrackingMPCMEX_Controller(self,param)
            obj.self = self;
            %---MPCパラメータ設定---%
            obj.param.H  = param.H;                % モデル予測制御のホライゾン
            obj.param.dt = param.dt;              % モデル予測制御の刻み時間
            obj.param.input_size = self.model.dim(2);%
            obj.param.state_size = self.model.dim(1);
            obj.param.total_size = obj.param.input_size + obj.param.state_size;
            obj.param.Num = obj.param.H+1; %初期状態とホライゾン数の合計
            %重み%
            obj.param.Q = diag([15,15,1,1]);%状態の重み
            obj.param.R = diag([1,1]);%入力の重み
            obj.param.Qf = diag([18,18,1,1]);%終端状態の重み
%             obj.param.Qf = diag([17,17,1,1]);
            obj.param.T = diag([40,40,40]);%Fisherの重み
            obj.param.S = [1,0.7];%入力の上下限
            obj.NoiseR = 3.0e-3;%param of Fisher Information matrix
            obj.RangeGain = 10;%gain of sigmoid function for sensor range logic
            obj.SensorRange = self.estimator.(self.estimator.name).constant.SensorRange;
            obj.previous_input = zeros(obj.param.input_size,obj.param.Num);
            obj.model = self.model;
        end
        
        function result = do(obj,param,~)
            % param = {model, reference}
            % param{1}.state : 推定したstate構造体
            % param{2}.result.state : 参照状態の構造体 % n x Num :  n : number of state,  Num : horizon
            % param{3} : 構造体
            %---ロボットの状態をとる---%
            RobotState = [obj.self.estimator.result.state.p(1) , obj.self.estimator.result.state.p(2) , obj.self.estimator.result.state.q];
            if ~isempty(obj.self.input)
                oldinput = obj.self.input;
            else
                oldinput=[1,0];
            end
            %---reference情報を取得---%
            ref = obj.self.reference.result.state;
            obj.param.Xr = [obj.self.estimator.result.state.get(),ref.xd];
            %-------------------------%
            %---マップ情報をとる---%
            LineParam = CFMEX_ConvertLineParam(obj.self.estimator.result.map_param);
            AssociationInfo = obj.self.estimator.result.AssociationInfo;
            %---------------------%
            
            %---センサ情報をとる---%
            Sensor = obj.self.sensor.result;
            Measured.ranges = Sensor.length;
            Measured.angles = Sensor.angle - RobotState(3);%
            if iscolumn(Measured.ranges)
                Measured.ranges = Measured.ranges';% Transposition
            end
            if iscolumn(Measured.angles)
                Measured.angles = Measured.angles';% Transposition
            end
            %---------------------%
            
            %---対応づけしたレーザ（壁にあたってるレーザ）の角度faiおよびその壁のdとalpahaを取得---%
            AssociationAvailableIndex = find(AssociationInfo.index ~= 0);%Index corresponding to the measured value
%             Flag = AssociationInfo.index';
%             Flag(Flag~=0) = 1;%on off FLag Matrix
            AssociationAvailableount = length(AssociationAvailableIndex);%Count
            Dis = inf(1,length(Measured.angles));
            Alpha = inf(1,length(Measured.angles));
            for i = 1:AssociationAvailableount
                MesuredRef = AssociationAvailableIndex(i);
                idx = AssociationInfo.index(AssociationAvailableIndex(i));
                Dis(MesuredRef) = LineParam.d(idx);%対応付けした距離を代入
                Alpha(MesuredRef) = LineParam.delta(idx);%対応付けしたalphaを代入
            end
            Dis = Dis(Dis~=inf);
            Alpha = Alpha(Alpha~=inf);
            AssoFai = Measured.angles(AssociationAvailableIndex);
            %----------------------------------------------------------------------------------%
            %---各種パラメータを格納---%
            obj.param.dis = Dis;
            obj.param.alpha = Alpha;
            obj.param.phi = AssoFai;
%             obj.param.NoiseR = obj.self.estimator.(obj.self.estimator.name).R;
            obj.param.X0 = obj.self.model.state.get();%[state.p;state.q;state.v;state.w];
            obj.param.U0 = obj.previous_input(:,1);%現在時刻の入力
            obj.param.model_param = obj.self.model.param;
            %------------------------%
            obj.previous_state = repmat(obj.param.X0,1,obj.param.Num);
            problem.solver    = 'fmincon';
            problem.options   = obj.options;
            problem.x0		  = [obj.previous_state;obj.previous_input;zeros(2,obj.param.Num)]; % 最適化計算の初期状態
            % obj.options.PlotFcn                = [];
            %---評価関数と制約条件を設定した関数MEX化するときはここをやる---%
            [var,fval,exitflag,~,~,~,~] = fminconMEX_ObFimAndFimobjective(problem.x0,obj.param,obj.NoiseR,obj.SensorRange,obj.RangeGain);
%             [var,fval,exitflag,~,~,~,~] = fminconMEX_Fimobjective(problem.x0,obj.param,obj.NoiseR,obj.SensorRange,obj.RangeGain);
%             [var,fval,exitflag,~,~,~,~] = fminconMEX_Trackobjective(problem.x0,obj.param);
            %------------------------------------%
            obj.result.input = var(obj.param.state_size + 1:obj.param.total_size, 1);
            obj.self.input = obj.result.input;
            obj.result.fval = fval;
            obj.result.exitflag = exitflag;
            obj.result.eachfval = GetobjectiveFimEval(var, obj.param,obj.NoiseR,obj.SensorRange,obj.RangeGain);%評価関数の値の計算 for plot
%             disp(exitflag);
            obj.previous_input = var(obj.param.state_size + 1:obj.param.total_size, :);  
%             obj.SolverName = func2str(problem.objective);
            result = obj.result;
        end
        
        function show(obj)
            
        end
    end
    
    methods(Access = private)
        outStruct = CFMEX_ConvertLineParam(MapStruct);
        eval = TrackobjectiveMEX(x, params);
        eval = FimobjectiveMEX(x, params);
        [cineq, ceq] = constraintsMEX(x, params);
        [StageState,StageInput,stageevFim,terminalState] = GetobjectiveFimEval(var, params);
        [var,fval,exitflag,output,lambda,grad,hessian] = fminconMEX_Fimobjective(objective,x0,nonlcon,options,param);
        [var,fval,exitflag,output,lambda,grad,hessian] = fminconMEX_Trackobjective(objective,x0,nonlcon,options,param);
    end
end

