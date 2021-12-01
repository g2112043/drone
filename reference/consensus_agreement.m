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
            sensor = obj.self.sensor.result;%Param{1}.result;�@%�@���̋@�̂̈ʒu
            state = obj.self.estimator.result.state;%Param{2}.state; % ���Ȉʒu

            ni = size(sensor.neighbor,2);%�Z���T�����W���ɂ��鑼�@�̂̈ʒu���
%             consensus_point = [0;0;0]; %���ӏd�S
            if obj.self.id == 1
                r=1;
                theta= linspace(0,2*pi,1000);
                obj.result.state.xd = [r*cos(theta(Param{1}.i));r*sin(theta(Param{1}.i));0.5];
            else
                if ni==0 %�߂��ɑ��̋@�̂����Ȃ�
                    obj.result.state.xd = [state.p(1:2);0];
                else
                    r=1;
                    Wo = 0.1;
                    Wd = 0.1;
                    theta= linspace(0,2*pi,1000);
                    round=zeros(2,1);
                    P = obj.offset(:,obj.self.id)+[r*cos(theta(Param{1}.i));r*sin(theta(Param{1}.i));0.5]; %�ڕW�ʒu
                    for i=1:ni
                        for j=1:2
                        Ao=-((state.p(1,1)-sensor.neighbor(1,i))^2+(state.p(2,1)-sensor.neighbor(2,i))^2)^(-3/2)*(state.p(j,1)-sensor.neighbor(j,i));
                        Ad=((state.p(1,1)-P(1,1))^2+(state.p(2,1)-P(2,1))^2)^(-3/2)*(state.p(j,1)-P(j,1));
                        round(j,1)=round(j,1)+Wo*Ao+Wd*Ad;
                        end
                    end
                    gradPx = 0;
                    gradPy = 0;
                    gradPz = 0;
                    for i=1:ni
                        gradPx = gradPx+Wd*(2*state.p(1)-2*P(1,1))/(2*((state.p(1) - P(1,1))^2 + (state.p(2) - P(2,1))^2 + (state.p(3) - P(3,1))^2)^(3/2)) - (Wo*(2*state.p(1) - 2*sensor.neighbor(1,i)))/(2*((state.p(1) - sensor.neighbor(1,i))^2 + (state.p(2) - sensor.neighbor(2,i))^2 + (state.p(3) - sensor.neighbor(3,i))^2)^(3/2));
                        gradPy = gradPy+Wd*(2*state.p(2)-2*P(2,1))/(2*((state.p(1) - P(1,1))^2 + (state.p(2) - P(2,1))^2 + (state.p(3) - P(3,1))^2)^(3/2)) - (Wo*(2*state.p(2) - 2*sensor.neighbor(2,i)))/(2*((state.p(1) - sensor.neighbor(1,i))^2 + (state.p(2) - sensor.neighbor(2,i))^2 + (state.p(3) - sensor.neighbor(3,i))^2)^(3/2));
                        gradPz = gradPz+Wd*(2*state.p(3)-2*P(3,1))/(2*((state.p(1) - P(1,1))^2 + (state.p(2) - P(2,1))^2 + (state.p(3) - P(3,1))^2)^(3/2)) - (Wo*(2*state.p(3) - 2*sensor.neighbor(3,i)))/(2*((state.p(1) - sensor.neighbor(1,i))^2 + (state.p(2) - sensor.neighbor(2,i))^2 + (state.p(3) - sensor.neighbor(3,i))^2)^(3/2));
                    end
                    obj.result.state.xd = [state.p(1)-gradPx;state.p(2)-gradPy;0.5];%[state.p(1)+round(1);state.p(2)+round(2);0.5]; %���ӏd�S��ݒ肵�đ�����`��
                end
            end
            
%             if obj.self.id == 1
%                 theta = linspace(0,2*pi,Param{3}/Param{4}+1);
%                 x = cos(theta(Param{1}.i));
%                 y = sin(theta(Param{1}.i));
%                 z = 1;
%                 round=zeros(2,1);
%                 for i=0:1:ni-1
%                     Ao=-((state.p(1,1)-sensor.neighbor(1,i))^2+(state.p(2,1)-sensor.neighbor(2,i))^2)^(-3/2);
%                     Ad=((state.p(1,1)-x)^2+(state.p(2,1)-y)^2)^(-3/2)*(state.p(1,1)-x);
%                 obj.result.state.xd = [x;y;z];
%             else
%                 if ni==0 %�߂��ɑ��̋@�̂����Ȃ�
%                     obj.result.state.xd = state.p;
%                 else
%                     theta = linspace(0,2*pi,Param{3}/Param{4}+1);
%                     x = cos(theta(Param{1}.i));
%                     y = sin(theta(Param{1}.i));
%                     z = 1;
% %                     for i=1:ni
% %                         Po(:,i) = 1/sqrt((state.p(1) - sensor.neighbor(1,i))^2+(state.p(3) - sensor.neighbor(3,i))^2+(state.p(3) - sensor.neighbor(3,i))^2); %��Q���i���@�́j�̃|�e���V�����֐�
% %                     end
% %                     Xd = [x;y;z]+obj.offset(:,obj.self.id); %�ڕW���W
% %                     for i=2:Param{2}
% %                         Pd(:,i) = -1/sqrt((state.p(1) - Xd(1))^2+(state.p(2) - Xd(2))^2+(state.p(3) - Xd(3))^2); %�ڕW�l�̃|�e���V�����֐�
% %                     end
% %                     wo = 1;
% %                     wd = 1;
% %                     for i = 2:Param{2}
% %                         P(:,i) = wo*sum(Po,2) + wd*Pd(:,i);
% %                     end
%                     obj.result.state.xd = [x;y;z]+obj.offset(:,obj.self.id); %���ӏd�S��ݒ肵�đ�����`��
%                     
% %                     obj.result.state.p = (state.p+(ni+1)*(obj.offset(:,obj.self.id))+sum(sensor.neighbor,2))/(ni+1); %�������ӏd�S���Z�o
%                 end
%             end
%                 theta = linspace(0,2*pi,Param{3}/Param{4}+1);
%                 x = cos(theta(Param{1}.i));
%                 y = sin(theta(Param{1}.i));
%                 z = 1;
%                 obj.result.state.xd = [x;y;z];
            result = obj.result; %�Ԃ��l�i���̖ڕW�ʒu�j
        end
        
        function show(obj,param)
        end
    end
end