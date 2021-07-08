classdef consensus_agreement < REFERENCE_CLASS
    % ���ӏd�S���Z�o����N���X
    %   �ڍא����������ɋL�q
    
    properties
        param
        self
        offset
    end
    
    methods
        %%�@�v�Z��
        function obj = consensus_agreement(self,param)
            obj.self = self;
            obj.offset = param;
            obj.result.state = STATE_CLASS(struct('state_list',["p"],'num_list',[3]));
        end

            
       %% �ڕW�ʒu
        function  result= do(obj,param)
            sensor = obj.self.sensor.result;%Param{1}.result;�@%�@���̋@�̂̈ʒu
            state = obj.self.estimator.result.state;%Param{2}.state; % ���Ȉʒu

            ni = size(sensor.neighbor,2);
            if ni==0
                obj.result.state.p = state.p;
            else
%                 obj.result.state.p = [1;0;0]+obj.offset(:,obj.self.id);
                obj.result.state.p = (state.p+(ni+1)*(obj.offset(:,obj.self.id))+sum(sensor.neighbor,2))/(ni+1); %�������ӓ_���Z�o
            end
            result = obj.result;
        end
        
        function show(obj,param)
        end
    end
end