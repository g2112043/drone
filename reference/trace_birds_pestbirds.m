classdef trace_birds_pestbirds < REFERENCE_CLASS
    % ���̃N���X�̊T�v�������ɋL�q
    % ���x�����̓��̓��f��
    
    properties
        self
        param
    end
    
    methods
        function obj = trace_birds_pestbirds(self,param)
            obj.self = self;
            obj.param = param;
            obj.result.state = STATE_CLASS(struct('state_list',["p","v","u"],'num_list',[3]));
        end
        
        function result = do(obj,Param)
            %METHOD1 ���̃��\�b�h�̊T�v�������ɋL�q
            %   �ڍא����������ɋL�q
            num = obj.self.id;%���v�Z���Ă��钹�̔ԍ�
            state =  obj.self.estimator.result.state.p;%num�Ԗڂ̒��̈ʒu
            N = Param{3};%main��N
            Nb = Param{4};%���̐�
            for i=Nb+1:N
                drone_state(:,i) = [Param{1,1}(1,i).plant.state.p];%�h���[���̏��
            end
            for i=1:N
                other_state(:,i) = [Param{1,1}(1,i).plant.state.p];%���ׂĂ̒��ƃh���[���̏��
            end
            pre_info = Param{2};%1�����O�̏��
%             rs = Param{5}(1);ra = Param{5}(2);
            rc = Param{6}(3); %�Q��鋗��
            tarm1 = zeros(3,length(other_state));%���̌Q��鍀
            adjust =  zeros(3,length(other_state));%�����ق��̒����痣���
            keep = zeros(3,1);%���ւ̐i�s
            away = zeros(3,length(drone_state));%�h���[�����痣���
            fp = Param{5};%���G���A
            k1 = 1;%%�����
            k2 = 1;%%����
            k3 = 3;%���Ɍ�����%1�@�̂Ƃ�1�ɂ��Ă��D
            k4 = 1;%�h���[�����瓦����
            [~,count] = size(pre_info.Data.t');
            R=5;
            flont = zeros(1,Nb);
            %%%�߂Â��������u%%%%%%%%%%%%%%%5
            result = arrayfun(@(i) Cov_distance(state,other_state(:,i),1),1:N);%���Ƃ��̑��i�h���[�����܂ށj�̋����v�Z
            tmp = struct2cell(result);
            distance = cell2mat(tmp);%[distance;dx;dy;dz];
            if count >1
%                keep = pre_info{num}.state(4:6,end)-agent_v;
                for i=1:numel(fp)
                    d(:,i)=norm(state-fp{i});
                end
                [~,farm] = min(d);
                fp = fp{farm};
               keep = (fp-state)/norm(fp-state) ;
                %���όv�Z
                if pre_info.i==1
                    agent_v = arrayfun(@(AAA) (state-[0;0;0])/0.1,1:N,'UniformOutput',false);
                else
                    agent_v = arrayfun(@(AAA) (state-pre_info.Data.agent{pre_info.i-1,4,AAA}.state.p)/0.1,1:N,'UniformOutput',false);
                end
                result = arrayfun(@(i) Cov_distance(other_state(:,i),state,1),1:N);
                tmp = struct2cell(result);
                dis = cell2mat(tmp);
                AA = arrayfun(@(i) dot(agent_v{num}(1:2),dis(2:3,:,i)),1:Nb);
                %�O�ɂ����̔c��
                flont = AA;
                
%                k5 = 0;%*distance{N}.result/(distance{N}.result + A.result);%%���֌�������

            end
            % �ÏW����
            if i~=num&&i<=Nb&&flont(i)==1
                if distance(1,:,i)<rc&&distance(1,:,i)>0.
                    tarm1(:,i) = -(1-[R^3/distance(1,:,i)^3])*[distance(1,:,i)];
                    adjust(:,i) = agent_v{i} - agent_v{num};                       
                end
            end
            for i=Nb+1:N%�h���[�����瓦�����
                away(:,i) = (distance(2:4,:,i))/norm(distance(2:4,:,i));
            end     
            %%�ڕW�ʒu�Ɍ������p�̂��
            if rand(1)>0.5
                r= -0.1;
            else 
                r=0.1;
            end
            fp = fp(1:2) + r * rand(1);
            fp = [fp;1];
            if fp-state==0
                go_farm = (fp-state);
            else
                go_farm = (fp-state)/norm(fp-state);
            end
            
            %�ڕW�ʒu�쐬
            if count >1&&norm(agent_v{num})~=0
                input =k1*sum(tarm1,2)/Nb + k2*sum(adjust,2)/Nb + k3*keep + k4*sum(away,2);
            else
                k5 = 6;
                input = k5*go_farm;
            end
%             if norm(input)<5.9
%                disp(norm(input)) 
%             end
%             kind_speed = 82 * 10/36;%���̕��ϔ�s���x
%             ref_point = fp;
%             th_xd = atan2(ref_point(2)-state(2),ref_point(1)-state(1));%�p���x
%             figure;
%             scatter(ref_point(1),ref_point(2),'r')
%             hold on;
%             scatter(state(1),state(2),'b')
%             xlim([state(1)-norm(ref_point-state)-3,state(1)+norm(ref_point-state)+3])
%             ylim([state(2)-3-norm(ref_point-state),state(2)+3+norm(ref_point-state)])
%             qtrans = quat2eul(q');
%             q3 = qtrans(3);
%             th_dd = th_xd-q3;
%             if th_dd>pi
%                 q3=q3+2*pi;
%             elseif th_dd<=-pi
%                 q3= q3-2*pi;
%             end
%                         th_dd = th_xd-q3;
%             eul = [0,0,th_dd];
%             quat = eul2quat(eul);
            obj.result.state.u = input;
            result = obj.result;
        end
        function show(obj,param)
        end
    end
end

