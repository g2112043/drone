classdef TIME_VARYING_REFERENCE < REFERENCE_CLASS
    % 時間関数としてのリファレンスを生成するクラス
    % obj = TIME_VARYING_REFERENCE()
    properties
        param
        func % 時間関数のハンドル
        self
        t=[];
        cha='s';
        dfunc
    end

    methods
        function obj = TIME_VARYING_REFERENCE(self, args)
            % 【Input】ref_gen, param, "HL"
            % ref_gen : reference function generator
            % param : parameter to generate the reference function
            % "HL" : flag to decide the reference for HL
            arguments
                self
                args
            end
            gen_func_name = str2func(args{1});
            param_for_gen_func = args{2};
            obj.func = gen_func_name(param_for_gen_func);
            if length(args) > 2
                if strcmp(args{3}, "HL")
                    obj.func = gen_ref_for_HL(obj.func);
                    obj.result.state = STATE_CLASS(struct('state_list', ["xd", "p", "v"], 'num_list', [20, 3, 3]));
                end
            else
                obj.result.state = STATE_CLASS(struct('state_list', ["xd", "p", "v"], 'num_list', [length(obj.func(0)), 3, 3]));
            end
            syms t real
            obj.dfunc = matlabFunction(diff(obj.func,t),"Vars",t);
        end
        function result = do(obj, Param)  
           %Param={time,FH}
           obj.cha = get(Param{2}, 'currentcharacter');
           if obj.cha=='f'&& ~isempty(obj.t)    %flightからreferenceの時間を開始
                t = Param{1}.t-obj.t; % 目標重心位置（絶対座標）
           else
                obj.t=Param{1}.t;
                t = obj.t;
           end
           obj.result.state.xd = obj.func(t); % 目標重心位置（絶対座標）
           obj.result.state.p = obj.result.state.xd(1:3);
           obj.result.state.v = obj.dfunc(t);
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
