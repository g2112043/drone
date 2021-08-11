classdef slope_input < REFERENCE_CLASS
    %EXAMPLE_WAYPOINT ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q
    
    properties
        param
        xd
        areas
        coef
        ret
        num_slope
        random
        self
        BV
        separateu
    end
    
    methods
        function obj = slope_input(varargin)
            refP = varargin{2}{1};
            select_probability = varargin{2}{2};
            obj.param = {[refP],[select_probability]};
            obj.xd = human_plobable_refarence(refP,select_probability);%���̖ڕW�ʒu���烉���_���ɑI��
            numberofagent = varargin{2}{3};
%             if numberofagent==1
%                 obj.xd = [0.5;10]; 
%             elseif numberofagent==3
%                 obj.xd = [0.5;9]; 
%             elseif numberofagent==2
%                 obj.xd = [0.5;0];
%             else
%                 obj.xd = [0.5;1];
%             end
            obj.result.state = STATE_CLASS(struct('state_list',["p","v","u"],'num_list',[3]));
            obj.areas = varargin{2}{4}.vertices;%���s�����Z���Ŋi�[
            [Pw,Coef] = create_slope_potential(obj.areas,obj.xd');
            obj.coef = Coef;%�e�̈�̌X�����Z�o
            obj.ret = Pw;
            obj.num_slope = length(obj.areas);
            obj.random = randn;
            obj.BV = [0 0 1 0 0 0;0 0 0 1 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0];
        end
        
        function result= do(obj,Param)
            %METHOD1 ���̃��\�b�h�̊T�v�������ɋL�q
            %   �ڍא����������ɋL�q
            num = Param{4};
            state =  Param{1}.state;
            %             agent_v = Param{1}.state.v;
            N = Param{3};
            gather = zeros(2,length(N));%����
            pre_info = Param{5}.save.agent;
            count = Param{5}.main_roop_count;
            %���s���x�Q�C��
            v_k = 1.0;
            dt = Param{5}.dt;
            xxd = cell(1,N);
            other_state = cell(1,N);
            for i=1:N
                xxd{i} = Param{6}(i).reference.slope.xd;
                other_state{1,i}=[Param{6}(i).plant.state.p;Param{6}(i).plant.state.v;Param{6}(i).plant.state.a];
            end
            %�ʘH�̍ő�ŏ�
            env = Param{2}.huma_load.param;
            pre_input = cell(1,N);
            if count~=1
                parfor i=1:N
                    pre_input{i} = pre_info{i}.u;
                end
            end
            
            %%%%%%�����܂łŏ�����%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            result = arrayfun(@(i) Cov_distance(state.p(1:2),other_state{i}(1:2),1),1:N);%Calclate distance between human and other one.
            tmp = struct2cell(result);
            %�l�{�̊Ԃ̋����v�Z
            disi2j = cell2mat(tmp);
            %% �ŏ��ˉe�@
            % Genelate of refalance
            A = Param{6}(num).model.param.A;
            B = Param{6}(num).model.param.B;
            %%%%%%%  Start to algorithm %%%%%%%%%%%%
            x = state.p(1);
            y = state.p(2);
            

            %%�������d����,�ŏ��ˉe�̌v�Z
            env.coeficient = obj.coef;
            id = minimum_slope(env,x,y,obj);
            u = -1*[Cov_diffx_slope(x,y,obj.coef{id}(1),obj.coef{id}(2),obj.coef{id}(3),obj.ret{id}(1,1),obj.ret{id}(3,1),obj.ret{id}(1,2),obj.ret{id}(3,2));...
                    Cov_diffy_slope(x,y,obj.coef{id}(1),obj.coef{id}(2),obj.coef{id}(3),obj.ret{id}(1,1),obj.ret{id}(3,1),obj.ret{id}(1,2),obj.ret{id}(3,2))];
            %slope�̔����l����͂Ƃ��ĎZ�o
            input = u;
            
            % �����Ƒ��҂̋����v�Z
            result = arrayfun(@(i) Cov_distance(other_state{i}(1:2),state.p(1:2),1),1:N);
            tmp = struct2cell(result);
            dis = cell2mat(tmp);
            %�l�����x�̌v�Z
            density = 0;
            %����p���Z�o\%���̂Ƃ��낤�܂������Ă��̂͒����P�T�ŁC�x45���炢�H�搶�ɑ������p���|�ɐ��m�Ȓl������D
            ViewLength = 10;
            ViewWidthTheta = 60;
            AvoidWidthTheta = 10;
            [Avoid_range,LAvoid_range,LViewRange,ViewRange] = Cov_view_range(state.p,input,AvoidWidthTheta,env,ViewLength,num,other_state,ViewWidthTheta);
            in_flontAvoid = zeros(1,N);
            in_frontViewRange = zeros(1,N);
            parfor i= 1:N
                %�O�ɂ��ē���̋����ȓ��̌̂��J�E���g
                if isinterior(Avoid_range,other_state{i}(1),other_state{i}(2))&&i~=num
                    in_flontAvoid(i) = isinterior(Avoid_range,other_state{i}(1),other_state{i}(2));
                end
                if isinterior(ViewRange,other_state{i}(1),other_state{i}(2))&&i~=num
                    in_frontViewRange(i) = isinterior(Avoid_range,other_state{i}(1),other_state{i}(2));
                end
            end
            if area(LViewRange)==0
                density = 10;
            else
                density = sum(in_frontViewRange,2)/area(LViewRange);
            end
            if density >5
                v_k = 0.1;
            else
                v_k = 0.0013*density^3+0.025*density^2-0.3143*density+0.9;
            end
%             v_k=0.5;
            %���Α��x�̌v�Z
            Rerativevi2vj = cell2mat(arrayfun(@(i) other_state{i}(3:4)-state.v(1:2),1:N,'uniformoutput',false));
            tmppp = cell2mat(arrayfun(@(i) disi2j(2:3,:,i),1:N,'uniformoutput',false));
            Vdotdis = dot(Rerativevi2vj,tmppp);
            FT_Avoid = zeros(1,N);
            parfor i=1:N
                %����p�������Α��x���������x�����̂�I��
                if in_flontAvoid(i)==1&&num~=i&&Vdotdis(i)>0
                    FT_Avoid(i) = 1;
                else
                    FT_Avoid(i) = 0;
                end
                if in_flontViewRange(i)==1&&num~=i&&Vdotdis(i)>0
                    FT_InView(i) = 1;
                else
                    FT_InView(i) = 0;
                end
            end
            %���Α��x�C�O�ɂ��邩�������x������C�̊ԋ����̍��Z
            RerativeFT_AvoidDis = [Rerativevi2vj;FT_Avoid;reshape(dis,[3,N])];
            DisMinAgentRerative = [num;inf;inf];
            for i=1:N
                %����p�������Α��x���������x�����̂�I��
                if (RerativeFT_AvoidDis(3,i)==1&&i~=num)&&DisMinAgentRerative(2,1)>RerativeFT_AvoidDis(2,1)
                    DisMinAgentRerative = [i;RerativeFT_AvoidDis(1:2,i)];
                else
                    DisMinAgentRerative = [num;inf;inf];
                end
            end
            %�����_�̋�����ω������邽�߂̊֐�
            VP = 1.;
            %��_�����X�̏������C�Ƃ肠�������Ȉʒu�ɍ쐬�D
            viewpoint = cell(1,N);
            F = zeros(3,N);
            colectV = zeros(1,N);
            %�����_
            ref_point = arrayfun(@(i) eye(length(other_state{i}))*other_state{i},1:N,'uniformoutput',false);
            if count~=1
                parfor i=1:N
                    %���S�͂̌v�Z
                    if i~=num
                        F(:,i) = cross([0;0;1],[dis(2,:,i);dis(3,:,i);0]);
                        F(:,i) = F(:,i)/norm(F(:,i));
                        colectV(:,i) = norm(other_state{i}(3:4));
                    end
                    if i==num
                        %i�Ԗڂ̌̂̉������_��VP�����炢�O�ɍ쐬�D
                    viewpoint{i} = other_state{i}+v_k*eye(length(other_state{i}))*[input/norm(input);0;0;0;0];
                    ref_point{i} = viewpoint{i}(1:2);
                    else
                        %���̑��̂̒����_���쐬
                    viewpoint{i} = other_state{i}+VP*obj.BV*pre_input{i}(:,end)/norm(pre_input{i}(:,end));
                    ref_point{i} = viewpoint{i}(1:2);
                    end
                end
                
                %%�����_��ōēx���͂̌v�Z
                id = minimum_slope(env,viewpoint{num}(1),viewpoint{num}(2),obj);
                u = -1*[Cov_diffx_slope(viewpoint{num}(1),viewpoint{num}(2),obj.coef{id}(1),obj.coef{id}(2),obj.coef{id}(3),obj.ret{id}(1,1),obj.ret{id}(3,1),obj.ret{id}(1,2),obj.ret{id}(3,2));...
                        Cov_diffy_slope(viewpoint{num}(1),viewpoint{num}(2),obj.coef{id}(1),obj.coef{id}(2),obj.coef{id}(3),obj.ret{id}(1,1),obj.ret{id}(3,1),obj.ret{id}(1,2),obj.ret{id}(3,2))];
                %slope�̔����l����͂Ƃ��ĎZ�o���Ē����_�̈ʒu���ēx�Z�o
                input = u;
%                 viewpoint{num} = A*viewpoint{num}+B*[0;0;input/norm(input);0;0];
%                 ref_point{num} = viewpoint{num}(1:2);
                %�e�����_��i�Ԗڂ̌̂̋����v�Z
                result = arrayfun(@(i) Cov_distance(state.p,viewpoint{i}(1:2),1),1:N);%Calclate distance between human and other one.
                tmp = struct2cell(result);
                disV2i = cell2mat(tmp);
                %�����_�̊Ԃ̋������Z�o
                result = arrayfun(@(i) Cov_distance(viewpoint{num}(1:2),viewpoint{i}(1:2),1),1:N);%Calclate distance between human and other one.
                tmp = struct2cell(result);
                disVi2V = cell2mat(tmp);
                %�����_�Ƃ��̑��̂̋������Z�o
                result = arrayfun(@(i) Cov_distance(viewpoint{num}(1:2),other_state{i}(1:2),1),1:N);%Calclate distance between human and other one.
                tmp = struct2cell(result);
                disVi2other = cell2mat(tmp);
                %�ȉ~�|�e���V�����̍쐬
                Elliptical_potential = cell(1,N);
                for i=1:N
                    Elliptical_potential{i} = -Cov_Elliptical_potential(viewpoint{num}(1,1),viewpoint{num}(2,1),viewpoint{i}(1,1)',viewpoint{i}(2,1)',other_state{i}(1),other_state{i}(2));
                end
                Elliptical_potential= cell2mat(Elliptical_potential);
                %                 Elliptical_potential= sum(cell2mat(potential),2,'omitnan');
                %i�Ԗڂ̌̂Ɗe�����_�̔��̓|�e���V����
            agent_separate_view_point = cell2mat(arrayfun(@(i) [disV2i(2:3,:,i)]/(norm(disV2i(2:3,:,i),3)),1:N,'UniformOutput',false));
            %i�Ԗڂ̒����_�ƒ����_�̔��̓|�e���V����
            ithViewPoint_separate_ViewPoint = cell2mat(arrayfun(@(i) [disVi2V(2:3,:,i)]/(norm(disVi2V(2:3,:,i),3)),1:N,'UniformOutput',false));
            ithViewPoint_separate_ViewPointVal = cell2mat(arrayfun(@(i) 1/(norm(disVi2V(2:3,:,i),3)),1:N,'UniformOutput',false));
            %i�Ԗڂ̒����_�Ƃ��̑��̂̔��̓|�e���V����
            ithViewPoint_separate_OtherAgent = cell2mat(arrayfun(@(i) [disVi2other(2:3,:,i)]/(norm(disVi2other(2:3,:,i),3)),1:N,'UniformOutput',false));
            ithViewPoint_separate_OtherAgentVal = cell2mat(arrayfun(@(i) 1/(norm(disVi2other(2:3,:,i),3)),1:N,'UniformOutput',false));
            %i�Ԗڂ̌̂Ƃ��̑��̂̔��̓|�e���V����
            agent_separate = -cell2mat(arrayfun(@(i) [dis(2:3,:,i)]/(norm(dis(2:3,:,i),3)),1:N,'UniformOutput',false));
                
            else
                Elliptical_potential = zeros(2,N);
                agent_separate_view_point = zeros(2,N);
                agent_separate = zeros(2,N);
                ithViewPoint_separate_ViewPoint = zeros(2,N);
                ithViewPoint_separate_ViewPointVal = zeros(1,N);
                ithViewPoint_separate_OtherAgent = zeros(2,N);
                ithViewPoint_separate_OtherAgentVal = zeros(1,N);
            end
            %�ڕW�ʒu����ޕ����D
%             for i=1:N
%                 if i~=num&&in_flont(i)==1
%                     %�O�ɂ���̂ɏW�����͍쐬
%                     gather(:,i) = -[disi2j(2:3,:,i)]/norm(disi2j(2:3,:,i),2);
%                 end
%             end

            %��Ōv�Z�������͂���������p�ɓ����Ă邩i=num���Ci�̖@���x���ꍇ�ɂ͉���s����0
            AverageVelocity=0;
            sumcount = 0;
            AvoidRerativeNum = [];
            AvoidRerativeAgentdistance = [];
            parfor i = 1:N
                if in_flontAvoid(i)==0||num==i||Vdotdis(i)<=0

                F(:,i) = zeros(3,1);
                end
                if in_flontViewRange(i)==0||num==i||Vdotdis(i)<=0
                                    ithViewPoint_separate_ViewPoint(:,i) = zeros(2,1);
                ithViewPoint_separate_ViewPointVal(:,i) = zeros(1,1);
                ithViewPoint_separate_OtherAgent(:,i) = zeros(2,1);
                ithViewPoint_separate_OtherAgentVal(:,i) = zeros(1,1);
                end
%                 if in_flont(i)==1&&Vdotdis(i)<0
%                     AverageVelocity = AverageVelocity+colectV(i);
%                     sumcount = sumcount+1;
%                 end
                RerativeVerocityDot = dot(other_state{i}(3:4),state.v(1:2));
                %�����]�̈���ɓ����Ă���Ό��҂̐���c��
                if in_flontAvoid(i)==1&&RerativeVerocityDot<0&&num~=i
                    AvoidRerativeNum = [AvoidRerativeNum,i];
                    AvoidRerativeAgentdistance = [AvoidRerativeAgentdistance,Cov_distance(viewpoint{num}(1:2),other_state{i}(1:2),2)];
                end
                %����̈���̑Ό��Ԃ�c��
                if in_flontViewRange(i)==1&&RerativeVerocityDot<0&&num~=i
                    ViewRerativeNum = [ViewRerativeNum,i];
                    ViewRerativeAgentdistance = [ViewRerativeAgentdistance,Cov_distance(viewpoint{num}(1:2),other_state{i}(1:2),2)];
                end
            end
            if ~isempty(AvoidRerativeAgentdistance)
            tmpLabels = Cov_MinLabel(AvoidRerativeAgentdistance,2);
            k3 = (20)*(length(AvoidRerativeNum)/area(LAvoid_range))/AvoidRerativeAgentdistance(tmpLabels);
            k2 = 1*length(AvoidRerativeNum)^2*AvoidRerativeAgentdistance(tmpLabels);%*sign(obj.random);%��ʃ��[��
            k1 = 100;%�����]��


            RerativeNearestAgentLabels = AvoidRerativeNum(tmpLabels);
            else
                k3=0;
                k2 = 50;%*sign(obj.random);%��ʃ��[��
                k1 = 100;%�����]��
                RerativeNearestAgentLabels = num;
            end
            [~,col] = find(FT_Avoid);
            tmp = [reshape(disi2j,[3,N]);1:N];
            tmp2 = sortrows(tmp(:,col)',1);
            if ~isempty(tmp2)
                AvoidTarget = tmp2(1,4);
            else
                AvoidTarget = 0;
            end
            

            %�ŏI�I�ɖ{�̂ɂ��������
            if count ==1
                walk = input;
                a= [0;0];
                b = a;
                c=a;
            else
                %����ȑO�ł͊��ɂ�钍���_���Z�o�����ŁC�l�Ȃǂ̊O�I�v������ɂ��������_���Z�o
%                 k1 = 80*length(RerativeNum)/RerativeAgentdistance(tmpLabels);%�����_��
                AAAA = Cov_MaxLabel(ithViewPoint_separate_OtherAgentVal,2);
                BBBB = Cov_MaxLabel(ithViewPoint_separate_ViewPointVal,2);
%                 k2 = 1000*(sum((ithViewPoint_separate_OtherAgentVal),2))+sum(ithViewPoint_separate_ViewPointVal,2);
%                 k2 = 1000*((ithViewPoint_separate_OtherAgentVal(AAAA))+(ithViewPoint_separate_ViewPointVal(BBBB)));
%                 if num ==2
%                     k1=0;k2=0;k3=0;
%                 end
                a = k1*(sum((ithViewPoint_separate_ViewPoint),2));
                MaxLabela = Cov_MaxLabel(ithViewPoint_separate_ViewPoint,2);
                a = k1*((ithViewPoint_separate_ViewPoint(:,MaxLabela)));
                if norm(a)>300
                  a = a/norm(a)*300;
                end
                b = k2*sum(F(1:2,:),2);
%                 MaxLabelb = Cov_MaxLabel(F,2);
%                 b = k2*(F(1:2,MaxLabelb));
                if norm(b)>300
                    b = b/norm(b)*300;
                end
                c = k3*sum(ithViewPoint_separate_OtherAgent,2);
%                 MaxLabelc = Cov_MaxLabel(ithViewPoint_separate_OtherAgent,2);
%                 c = k3*(ithViewPoint_separate_OtherAgent(:,MaxLabelc));                
                if norm(c)>300
                    c = c/norm(c)*300;
                end
                ref_input = a+b+c+1*u;
                viewpoint{num} = A*viewpoint{num}+B*[0;0;ref_input;0;0];
                ref_point{num} = viewpoint{num}(1:2);
                walk = (ref_point{num}(1:2) - state.p(1:2))/norm(ref_point{num}(1:2) - state.p(1:2),2);
            end
            %�ڕW���x�ւƌ������悤�ȉ����x����
            if norm(walk)~=0
                acceleration = (walk/norm(walk)*v_k - other_state{num}(3:4))/dt;
            else
                acceleration = zeros(2,1);
            end
            %             agent_input = (0.0004*sum((agent_separate_view_point),2))/Relative_N + 0.4*walk+0.1*Elliptical_potential+ 0.05*sum(F(1:2,:),2);
            %             agent_input = (0.0005*sum((agent_separate_view_point),2))/Relative_N + 0.4*walk+(0.0005*sum((agent_separate),2))+ 0.05*sum(F(1:2,:),2);
            %             agent_input = (0.0003*sum((agent_separate_view_point),2))/Relative_N + 0.3*input+0.1*Elliptical_potential+ 0.05*sum(F(1:2,:),2);
            agent_input = 0.5*walk+1*acceleration;
            obj.result.ref_point = ref_point{num};
            %%
%             make_map(0,obj,other_state,num)
            %%
            if isnan(agent_input)
                disp('a');
            end
            agent_input = [0;0;agent_input;0;0];
            obj.self.input = agent_input;
            obj.result.state.u = [agent_input];
            obj.result.separateu = [a;b;c];
            obj.result.rerativepotential = [ ];
            obj.result.View_range = LViewRange;
            obj.result.OPV = v_k;
            result = obj.result;
            
        end
        function show(obj,param)
            %             draw_voronoi({obj.result.region},1,[param.p(1:2),obj.result.p(1:2)]);
        end
        function make_map(flag,obj,other_state,num)
            grid_x =-1:0.5:20;
            grid_y =  -2:0.5:15;
            [GX,GY] = meshgrid(grid_x,grid_y);%%��
            [sizeX,~]=size(GX);
            [~,sizeY]=size(GY);
            map = zeros(sizeX,sizeY);
            Vp = zeros(1,obj.num_slope);
            N = length(other_state);
            if flag%�}�b�v�ۑ��p
                for k=1:sizeX
                    for j=1:sizeY
                        xm = GX(k,j);
                        ym = GY(k,j);
                        Vp = zeros(1,obj.num_slope);
                        aaa=0;
                        for i=1:N
                            if i~=num
                                aaa =aaa +1/norm([xm;ym]-other_state{i}(1:2));
                            end
                        end
                        for i = 1:obj.num_slope
                            Vp(i) = 0.05*Cov_slope(xm,ym,obj.coef{i}(1),obj.coef{i}(2),obj.coef{i}(3),obj.areas{i}(1,1),obj.areas{i}(3,1),obj.areas{i}(1,2),obj.areas{i}(3,2));
                        end
                        
                        min_Vp = min(Vp);
                        if min_Vp >15
                            min_Vp =15;
                        end
                        map(k,j) = min_Vp;
                    end
                end
%                                         figure;  surf(GX,GY,map,'EdgeColor','none');
                mapmax =max(max(map));
                obj.result.map = map./mapmax;
                if num==1
%                     figure
%                     hold on
%                     contour(GX,GY,obj.result.map)
% %                     scatter(node.point(1,:),node.point(2,:))
%                     hold off
                end
            end
        end
    end
end

