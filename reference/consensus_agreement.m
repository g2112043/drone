classdef consensus_agreement < REFERENCE_CLASS
    % ���ӏd�S���w�肵�đ�����`������N���X
    % �w�肷��Ίe�����ɂ����鍇�ӏd�S�̎Z�o���\
    
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
        function  result= do(obj,Param)
            sensor = obj.self.sensor.result;%Param{1}.result;�@%�@���̋@�̂̈ʒu
            state = obj.self.estimator.result.state;%Param{2}.state; % ���Ȉʒu

            ni = size(sensor.neighbor,2);%�Z���T�����W���ɂ��鑼�@�̂̈ʒu���
%             consensus_point = [0;0;0]; %���ӏd�S
            if obj.self.id == 1
                r=1;
                theta = linspace(0,2*pi,1000);
                x = r*cos(theta(Param{1}.i));
                y = r*sin(theta(Param{1}.i));
                z = 1;
                if state.p - [0;0;0] < 1
                    obj.result.state.p = -0.01*(state.p - [x;y;z]);
                end
                obj.result.state.p = [x;y;z];
            else
                if ni==0 %�߂��ɑ��̋@�̂����Ȃ�
                    obj.result.state.p = state.p;
                else
                    r=1;
                    theta = linspace(0,2*pi,1000);
                    x = r*cos(theta(Param{1}.i));
                    y = r*sin(theta(Param{1}.i));
                    z = 1;
                    obj.result.state.p = [x;y;z]+obj.offset(:,obj.self.id); %���ӏd�S��ݒ肵�đ�����`��
                    
%                     obj.result.state.p = (state.p+(ni+1)*(obj.offset(:,obj.self.id))+sum(sensor.neighbor,2))/(ni+1); %�������ӏd�S���Z�o
                end
            end

            result = obj.result; %�Ԃ��l�i���̖ڕW�ʒu�j
        end
        
        function show(obj,param)
        end
    end
end