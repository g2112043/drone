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
                    for i=1:ni
                        Po(:,i) = 1/sqrt((state.p(1) - sensor.neighbor(1,i))^2+(state.p(3) - sensor.neighbor(3,i))^2+(state.p(3) - sensor.neighbor(3,i))^2); %��Q���i���@�́j�̃|�e���V�����֐�
                    end
                    Xd = [x;y;z]+obj.offset(:,obj.self.id); %�ڕW���W
                    for i=2:Param{2}
                        Pd(:,i) = -1/sqrt((state.p(1) - Xd(1))^2+(state.p(2) - Xd(2))^2+(state.p(3) - Xd(3))^2); %�ڕW�l�̃|�e���V�����֐�
                    end
                    wo = 1;
                    wd = 1;
                    for i = 2:Param{2}
                        P(:,i) = wo*sum(Po,2) + wd*Pd(:,i);
                    end
                    obj.result.state.p = [x;y;z]+obj.offset(:,obj.self.id);;%-diff(P(:,obj.self.id)); %���ӏd�S��ݒ肵�đ�����`��
                    
%                     obj.result.state.p = (state.p+(ni+1)*(obj.offset(:,obj.self.id))+sum(sensor.neighbor,2))/(ni+1); %�������ӏd�S���Z�o
                end
            end

            result = obj.result; %�Ԃ��l�i���̖ڕW�ʒu�j
        end
        
        function show(obj,param)
        end
    end
end