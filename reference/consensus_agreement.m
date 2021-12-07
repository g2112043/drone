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
            obj.result.state = STATE_CLASS(struct('state_list',["p","xd"],'num_list',[3]));
        end

            
       %% �ڕW�ʒu
        function  result= do(obj,Param)
            sensor = obj.self.sensor.motive.result.rigid;%Param{1}.result;�@%�@���̋@�̂̈ʒu
            state = obj.self.estimator.result.state;%Param{2}.state; % ���Ȉʒu

%             consensus_point = [0;0;0]; %���ӏd�S
            if obj.self.sensor.motive.rigid_num == 1
                x_0 = 0;
                y_0 = 0;
                t = Param{3};

                s = 4;

                x = x_0+sin(t/s);
                y = y_0+cos(t/s);
                z = 1;
                obj.result.state.xd = [x;y;z];
            else
                if norm(state.p - sensor(1).p)>1.5 %�߂��Ƀ��[�_�[�@�̂����Ȃ�
                    obj.result.state.xd = state.p;
                else
                    Wo = 0.1;
                    Wd = 0.18;
                    x_0 = 0;
                    y_0 = 0;
                    t = Param{3};

                    s = 4; % s = 2 �� period = 4*pi (12 sec)�n�[�g1��

                    x = x_0+sin(t/s);
                    y = y_0+cos(t/s);
                    z = 1;
                    P = obj.offset(:,obj.self.id)+[x;y;z]; %�ڕW�ʒu
                    gradPx = 0;
                    gradPy = 0;
                    if obj.self.sensor.motive.rigid_num == 2
                        gradPx = gradPx+Wd*(2*state.p(1)-2*P(1,1))/(2*((state.p(1) - P(1,1))^2 + (state.p(2) - P(2,1))^2 + (state.p(3) - P(3,1))^2)^(3/2)) - (Wo*(2*state.p(1) - 2*sensor(1).p(1)))/(2*((state.p(1) - sensor(1).p(1))^2 + (state.p(2) - sensor(1).p(2))^2 + (state.p(3) - sensor(1).p(3))^2)^(3/2));
                        gradPy = gradPy+Wd*(2*state.p(2)-2*P(2,1))/(2*((state.p(1) - P(1,1))^2 + (state.p(2) - P(2,1))^2 + (state.p(3) - P(3,1))^2)^(3/2)) - (Wo*(2*state.p(2) - 2*sensor(1).p(2)))/(2*((state.p(1) - sensor(1).p(1))^2 + (state.p(2) - sensor(1).p(2))^2 + (state.p(3) - sensor(1).p(3))^2)^(3/2));
                        gradPx = gradPx+Wd*(2*state.p(1)-2*P(1,1))/(2*((state.p(1) - P(1,1))^2 + (state.p(2) - P(2,1))^2 + (state.p(3) - P(3,1))^2)^(3/2)) - (Wo*(2*state.p(1) - 2*sensor(3).p(1)))/(2*((state.p(1) - sensor(3).p(1))^2 + (state.p(2) - sensor(3).p(2))^2 + (state.p(3) - sensor(3).p(3))^2)^(3/2));
                        gradPy = gradPy+Wd*(2*state.p(2)-2*P(2,1))/(2*((state.p(1) - P(1,1))^2 + (state.p(2) - P(2,1))^2 + (state.p(3) - P(3,1))^2)^(3/2)) - (Wo*(2*state.p(2) - 2*sensor(3).p(2)))/(2*((state.p(1) - sensor(3).p(1))^2 + (state.p(2) - sensor(3).p(2))^2 + (state.p(3) - sensor(3).p(3))^2)^(3/2));
                    else
                        gradPx = gradPx+Wd*(2*state.p(1)-2*P(1,1))/(2*((state.p(1) - P(1,1))^2 + (state.p(2) - P(2,1))^2 + (state.p(3) - P(3,1))^2)^(3/2)) - (Wo*(2*state.p(1) - 2*sensor(1).p(1)))/(2*((state.p(1) - sensor(1).p(1))^2 + (state.p(2) - sensor(1).p(2))^2 + (state.p(3) - sensor(1).p(3))^2)^(3/2));
                        gradPy = gradPy+Wd*(2*state.p(2)-2*P(2,1))/(2*((state.p(1) - P(1,1))^2 + (state.p(2) - P(2,1))^2 + (state.p(3) - P(3,1))^2)^(3/2)) - (Wo*(2*state.p(2) - 2*sensor(1).p(2)))/(2*((state.p(1) - sensor(1).p(1))^2 + (state.p(2) - sensor(1).p(2))^2 + (state.p(3) - sensor(1).p(3))^2)^(3/2));
                        gradPx = gradPx+Wd*(2*state.p(1)-2*P(1,1))/(2*((state.p(1) - P(1,1))^2 + (state.p(2) - P(2,1))^2 + (state.p(3) - P(3,1))^2)^(3/2)) - (Wo*(2*state.p(1) - 2*sensor(2).p(1)))/(2*((state.p(1) - sensor(2).p(1))^2 + (state.p(2) - sensor(2).p(2))^2 + (state.p(3) - sensor(2).p(3))^2)^(3/2));
                        gradPy = gradPy+Wd*(2*state.p(2)-2*P(2,1))/(2*((state.p(1) - P(1,1))^2 + (state.p(2) - P(2,1))^2 + (state.p(3) - P(3,1))^2)^(3/2)) - (Wo*(2*state.p(2) - 2*sensor(2).p(2)))/(2*((state.p(1) - sensor(2).p(1))^2 + (state.p(2) - sensor(2).p(2))^2 + (state.p(3) - sensor(2).p(3))^2)^(3/2));
                    end
                    obj.result.state.xd = [state.p(1)-gradPx;state.p(2)-gradPy;0.5]; %�t�H�����[�@�̖ڕW���W
                end
            end
            
            result = obj.result; %�Ԃ��l�i���̖ڕW�ʒu�j
        end
        
        function show(obj,param)
        end
    end
end