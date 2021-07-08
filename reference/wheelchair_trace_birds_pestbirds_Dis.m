classdef wheelchair_trace_birds_pestbirds_Dis < REFERENCE_CLASS
    %EXAMPLE_WAYPOINT ���̃N���X�̊T�v�������ɋL�q
    % ���x�����̓��̓��f��
    
    properties
        param
    end
    
    methods
        function obj = wheelchair_trace_birds_pestbirds_Dis(varargin)
            obj.result.state = STATE_CLASS(struct('state_list',["p","v","u"],'num_list',[3]));
        end
        
        function result= do(obj,Param)
            %METHOD1 ���̃��\�b�h�̊T�v�������ɋL�q
            %   �ڍא����������ɋL�q
            num = Param{4};%���v�Z���Ă��钹�̔ԍ�
            state =  Param{1}.state.p;%num�Ԗڂ̒��̈ʒu
            q = Param{1}.state.q;%num�Ԗڂ̒��̎p���p
%             agent_v = Param{1}.state.v;
            other_state = Param{3};%���ׂĂ̒��ƃh���[���̏��
            N = length(other_state);%main��N
            Nb = Param{9};%���̐�
            pre_info = Param{6}.save.agent;%1�����O�̏��
%             rs = Param{5}(1);ra = Param{5}(2);
            rc = Param{5}(3); %�Q��鋗��
            tarm1 = zeros(2,length(other_state));%���̌Q��鍀
            adjust =  zeros(2,length(other_state));%�����ق��̒����痣���
            keep = zeros(2,1);%���ւ̐i�s
            away = zeros(2,length(other_state));
            go_farm = zeros(2,1);
            fp = [Param{7}];
            want_falm = Param{8};
            k1 = .2;%%�����
            k2 = 0.1;%%����
            k3 = 3.;%���Ɍ�����%1�@�̂Ƃ�1�ɂ��Ă��D
            k4 = 23.0;%%������F���������œ����_�̌v�Z���狁�߂Ă���D
            k5 = 2;%%���Ɍ�����
            [~,count] = size(pre_info{1}.state);
            R=5;
            flont = zeros(1,Nb);
            %%%�߂Â��������u%%%%%%%%%%%%%%%5
            result = arrayfun(@(i) Cov_distance(state,other_state{1,i}.p,1),1:N);%���Ƃ��̑��i�h���[�����܂ށj�̋����v�Z
            tmp = struct2cell(result);
            distance = cell2mat(tmp);
            if count >1
%                keep = pre_info{num}.state(4:6,end)-agent_v;
               keep = ((fp-state)/norm((fp-state),2)) ;
                %���όv�Z
                agent_v = arrayfun(@(AAA) (pre_info{AAA}.state(1:2,end)-pre_info{AAA}.state(1:2,end-1))/0.1,1:N,'UniformOutput',false);
                
                result = arrayfun(@(i) Cov_distance(other_state{i}.p,state,1),1:N);
                tmp = struct2cell(result);
                dis = cell2mat(tmp);
                AA = arrayfun(@(i) dot( agent_v{num}(1:2),dis(2:3,:,i)),1:Nb);
                %�O�ɂ����̔c��
                flont = AA>0;
                
                
%                k5 = 0;%*distance{N}.result/(distance{N}.result + A.result);%%���֌�������

            end
            for i=1:N
                if i~=num&&i<=Nb&&flont(i)==1
                    if distance(1,:,i)<rc&&abs(distance(1,:,i))>0.
                        tarm1(:,i) = -(1-[R^3/distance(1,:,i)^3])*[distance(2:3,:,i)];
                        adjust(:,i) = agent_v{i} - agent_v{num};                       
                    end
                end
                if i>Nb%�h���[�����瓦�����
                    away(:,i) = [distance(2:3,:,i)]/norm(distance(2:3,:,i))^2;
                end     
            end
            %%�ڕW�ʒu�Ɍ������p�̂��
            if rand(1)>0.5
                r= -0.1;
            else 
                r=0.1;
            end
            fp = fp + r * rand(1);
            if fp-state(1:2,1)==0
                go_farm = (fp-state);
            else
                go_farm = (fp-state(1:2,1))/norm(fp-state(1:2,1));
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
            kind_speed = 82 * 10/36;
            ref_point = eye(2)*state(1:2,1) + eye(2)*(kind_speed * (input/norm(input,2)));
            th_xd = atan2(ref_point(2)-state(2),ref_point(1)-state(1));%�p���x
%             figure;
%             scatter(ref_point(1),ref_point(2),'r')
%             hold on;
%             scatter(state(1),state(2),'b')
%             xlim([state(1)-norm(ref_point-state)-3,state(1)+norm(ref_point-state)+3])
%             ylim([state(2)-3-norm(ref_point-state),state(2)+3+norm(ref_point-state)])
            th_dd =th_xd-q;
            if th_dd>pi
                q=q+2*pi;
            elseif th_dd<=-pi
                q= q-2*pi;
            end
                        th_dd =th_xd-q;

            v_xd = kind_speed ;
            obj.result.state.u = [v_xd;0;th_dd];%[(x,y),z,omega]
            result = obj.result;
        end
        function show(obj,param)
%             draw_voronoi({obj.result.region},1,[param.p(1:2),obj.result.p(1:2)]);
        end
    end
end

