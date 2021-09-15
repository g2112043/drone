classdef trace_birds_drone < REFERENCE_CLASS
    %EXAMPLE_WAYPOINT ����ǂ��o�����߂̓���p�N���X�D
    %   �ڍא����������ɋL�q
    
    properties
        self
        param
    end
    
    methods
        function obj = trace_birds_drone(self,param)
            obj.self = self;
            obj.param = param;
            obj.result.state = STATE_CLASS(struct('state_list',["p","v","u"],'num_list',[3]));
        end
        
        function result= do(obj,Param)
            %METHOD1 ���̃��\�b�h�̊T�v�������ɋL�q
            %   �ڍא����������ɋL�q
            fp=Param{4};%���̈ʒu�ۑ�
            N = Param{2};
            Na = N - Param{3};
            num = obj.self.id;
            state = obj.self.plant.state;
            position_birds = obj.self.sensor.result.neighbor(:,1:Param{3});
            for i=1:numel(fp)
                    d(:,i)=norm(state.p-fp{i});
            end
            [~,farm] = min(d);
            fp = fp{farm};
            for i=1:Na
                position_agents(:,i) = [Param{1,1}(1,Param{3}+i).plant.state.p];
            end
            tmp = cell(1,N-Na);
            tmp2 = cell(1,Na);
%             birds_speed = cell(1,N-1);
            for i=1:N-Na
                tmp{:,i} = position_birds(:,i);
            end
%                 birds_speed{:,i} = Param{3}{i}.v;
            sheep_state = cell2mat(tmp);
            if length(sheep_state(:,1))<3
            sheep_state = vertcat(sheep_state,zeros(1,N-Na));
            end
            for c=1:Na
                tmp2{:,c} = position_agents(:,c);
            end
            agent_state = cell2mat(tmp2);
            tmp= arrayfun(@(i) isequal(agent_state(:,i),state.p),1:Na);                            % Find row number with minimum distance
            col = tmp == 1;
            tmp = agent_state;
            tmp(:,col) = [];
            other_agent = tmp;%���@�̂̈ʒu
            [~,m] = size(other_agent);
            if m >0
                %�]���֐�
                tmp = arrayfun(@(j) arrayfun(@(i) Cov_distance(fp,sheep_state(:,i),2)+Cov_distance(state.p,sheep_state(:,i),2)-Cov_distance(other_agent(:,j),sheep_state(:,i),2)',1:N-Na),1:m,'uniform',false)';
                if length(tmp)<2&&m>0
                    result = cell2mat(tmp);
                else
                    result = sum(cell2mat(tmp)) ;%�]���֐��̘a�̌v�Z
                end
            else
                tmp = arrayfun(@(i) Cov_distance(fp,sheep_state(1:2,i),2)+Cov_distance(state.p(1:2),sheep_state(1:2,i),2),1:N-Na);
                result = tmp;
            end

            tmp = (result);
            tmp2 = (arrayfun(@(i) {vertcat((tmp(i)),i)},1:N-Na,'UniformOutput',false));%���̔ԍ��ƒ��̋�����R�Â�
            tmp2 = (arrayfun(@(i) vertcat(cell2mat(tmp2{i})),1:N-Na,'UniformOutput',false));%

            AAA = cell2mat(tmp2);%1�s�ڂ��]���֐��C2�s�ڂ����̔ԍ�
            [~,I] = sort(AAA(1,:));
            A=AAA(:,I);
            sort_point = A;%�]���֐������������ɒ��̔ԍ�������ł���
            %�Q��̃N���X�^�����O
            AA=pointCloud(sheep_state');
            [labels,numClusters]  = pcsegdist(AA,9);
%             Y = pdist(sheep_state');%�e�_�̋����R���r�l�[�V�����ł��Ԃ����Ă�
%             A = squareform(Y);%���������C�Ώۍs��ɍ��ւ��Ă���D�Ă��C�g�ݍ��킹�ɂȂ��Ă���D
%             Z = linkage(Y);
%             AAA = inconsistent(Z);
%             labels = cluster(Z,'cutoff',2)';%%�C�ӂ̃N���X�^�[�I���C�e�_���ǂ̃N���X�Ȃ̂����[�N���b�h�����Ō��߂���
%             labels = cluster(Z,'maxclust',2)';%%�C�ӂ̃N���X�^�[�I���C�e�_���ǂ̃N���X�Ȃ̂����[�N���b�h�����Ō��߂���

%             numClusters = unique(labels);
            for i=1:length(numClusters)%numClusters=�Z�O�����g���I�������̌Q��̐�
                text = num2str(i);
                CC = labels == i;
                if sum(CC)>=3
                    class_num = find(labels==i);%�N���X�����ɂ��s��̒��o
                    flock{i} = sheep_state(:,class_num);%�N���X���������Q���ۑ�
                    K = convhull(flock{i}(1:2,1:length(flock{i}))');%�O�����\�����Ă���_���Z�o
                    polyin = polyshape(flock{i}(1:2,K)');
                    [x,y] = centroid(polyin);%�d�S�̌v�Z
                    Cog{i} = [x;y];
                    P{i} = Cov_calc_cov(flock{i},Cog{i});%%���̈ʒu����ɂ������U�����U�s����v�Z
                else
                    Cog{i} = sheep_state(1:2,min(find(labels==str2double(text))));
                    P{i} = eye(3);
                end
           end
            
            i=N-num+1;
            xd = sheep_state(1:2,sort_point(2,i));
%             xd = [10;10];
            tmp = dog_input(state,fp,P,sheep_state,Cog,xd,agent_state,(num-N+Na),Na);
%             tmp = dog_input(state,fp,P,sheep_state,Cog,xd);
            obj.result.state.u = tmp.result;
            Target = xd;
%             Target = [x;y];
%             Target = Param{4};
            obj.result.state.p = [Target;0];
            obj.result.state.v = [0;0;0];
%             obj.result.state.u = [0;0;0];
            obj.result.CoG = Cog;
            obj.result.P=P;
            obj.result.tmp1 = labels;
            obj.result.tmp2 = tmp.tmp2;
            obj.result.tmp3 = numClusters;
            obj.result.tmp4 = tmp.tmp1;
            result = obj.result;
           
        end
        function show(obj,param)
%             draw_voronoi({obj.result.region},1,[param.p(1:2),obj.result.p(1:2)]);
        end
    end
end

