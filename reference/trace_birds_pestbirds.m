classdef trace_birds_pestbirds < REFERENCE_CLASS
    %EXAMPLE_WAYPOINT ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q
    
    properties
        param
    end
    
    methods
        function obj = trace_birds_pestbirds(varargin)
            obj.result.state = STATE_CLASS(struct('state_list',["p","v","u"],'num_list',[3]));
        end
        
        function result= do(obj,Param)
            %METHOD1 ���̃��\�b�h�̊T�v�������ɋL�q
            %   �ڍא����������ɋL�q
            num = Param{4};
            state =  Param{1}.state.p;
            agent_v = Param{1}.state.v;
            other_state = Param{3};
            N = length(other_state);
            Nb = Param{9};
            pre_info = Param{6}.save.agent;
%             rs = Param{5}(1);ra = Param{5}(2);
            rc = Param{5}(3); 
            tarm1 = zeros(3,length(other_state));
            adjust =  zeros(3,length(other_state));
            keep = zeros(3,1);
            away = zeros(3,length(other_state));
            go_farm = zeros(3,1);
            fp = [Param{7};0];
            want_falm = Param{8};
            k1 = 0.5;%%�����
            k2 = 0.5;%%����
            k3 = 2.;%%�ێ�����
            k4 = 30.;%%������F���������œ����_�̌v�Z���狁�߂Ă���D
            k5 = 0;%%���Ɍ�����
            [~,count] = size(pre_info{1}.state);
            R=5;
            flont = zeros(1,Nb);
            %%%�߂Â��������u%%%%%%%%%%%%%%%5
            result = arrayfun(@(i) Cov_distance(state,other_state{i}.p,1),1:N);%���Ƃ��̑��i�h���[�����܂ށj�̋����v�Z
            tmp = struct2cell(result);
            distance = cell2mat(tmp);
            if count >1
%                keep = pre_info{num}.state(4:6,end)-agent_v;
               keep = ((fp-state)/norm((fp-state),2)) ;
                %���όv�Z
                AA = arrayfun(@(i) dot( pre_info{num}.state(4:5,end),distance(2:3,:,i)),1:Nb);
                %�O�ɂ����̔c��
                flont = AA>0;
                
                
               k5 = 0;%*distance{N}.result/(distance{N}.result + A.result);%%���֌�������

            end
            for i=1:N
                if i~=num&&i<=Nb&&flont(i)==1
                    if distance(1,:,i)<rc&&abs(distance(1,:,i))>0.
                        tarm1(:,i) = -(1-[R^3/distance(1,:,i)^3])*[distance(2:3,:,i);0];
                        adjust(:,i) = other_state{i}.v - agent_v;                       
                    end
                end
                if i>Nb%�h���[�����瓦�����
                    away(:,i) = [distance(2:3,:,i);0]/norm(distance(2:3,:,i))^2;
                end     
            end
            %%�ڕW�ʒu�Ɍ������p�̂��
            if rand(1)>0.5
                r= -0.1;
            else 
                r=0.1;
            end
            fp = fp + r * rand(1);
            if fp-state==0
                go_farm = (fp-state);
            else
                go_farm = (fp-state)/norm(fp-state);
            end
            %�����_�ɂ��Q�C���̂�������\
            vv = norm(agent_v);
            if count >1&&sum(agent_v)~=0
                input =k1*sum(tarm1,2)/Nb + k2*sum(adjust,2)/Nb + k3*keep + k4*sum(away,2);
%                 input_v = 6*(agent_v)/norm(agent_v,2);
%                 if vv>10
%                     agent_v =  10*(agent_v)/norm(agent_v,2);
%                 elseif vv<4&&norm((fp-state),2)>10
%                     agent_v =  4*(agent_v)/norm(agent_v,2);   
%                 else
%                 end
                
                input_v = agent_v;
            else
                k5 = 60;
                input = k5*go_farm;
                input_v = agent_v;
            end
%             if norm(input)<5.9
%                disp(norm(input)) 
%             end
            obj.result.state.u = [input_v;input];%
            result = obj.result;
            
        end
        function show(obj,param)
%             draw_voronoi({obj.result.region},1,[param.p(1:2),obj.result.p(1:2)]);
        end
    end
end

