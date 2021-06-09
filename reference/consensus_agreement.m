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
        function obj = consensus_agreement(self,offset)
            obj.self = self;
            obj.offset = offset;
            obj.result.state = STATE_CLASS(struct('state_list',["p"],'num_list',[3]));
        end

            
       %% �ڕW�ʒu
        function  result= do(obj,param)
            % �yInput�zParam = {sensor,estimator,env,param}
            %  param = range, pos_range, d, void,
            % �yOutput�z result = �ڕW�l�i�O���[�o���ʒu�j
            %% ���ʐݒ�P�F�P���{���m�C�Z���m��
            sensor = obj.self.sensor.result;%Param{1}.result;�@%�@���̋@�̂̈ʒu
            state = obj.self.estimator.result.state;%Param{2}.state; % ���Ȉʒu
%             env = obj.self.env;%Param{3}.param;             % ���Ƃ��ė\����������
%             param = Param{4}; % �r���ŕς�����K�v�����邩�H
%             if isfield(param,'range'); obj.param.r = param.range;  end
%             if isfield(param,'pos_range'); obj.param.R = param.pos_range;  end
%             if isfield(param,'d'); obj.param.d = param.d;  end
%             if isfield(param,'void'); obj.param.void = param.void;  end
%             r = obj.param.r; % �d�v�x�𑪋��ł��郌���W
%             R = obj.param.R; % �ʐM�����W
%             d = obj.param.d; % �O���b�h�Ԋu
%             void = obj.param.void; % VOID��
            if isfield(sensor,'neighbor')
                neighbor=sensor.neighbor; % �ʐM�̈���̃G�[�W�F���g�ʒu ��΍��W
            elseif isfield(sensor,'rigid')
                neighbor=[sensor.rigid(1:size(sensor.rigid,2)~=obj.self.id).p];
            end
            if ~isempty(neighbor)% �ʐM�͈͂ɃG�[�W�F���g�����݂��邩�̔���
                neighbor_rpos=neighbor-state.p; % �ʐM�̈���̃G�[�W�F���g�̑��Έʒu
    %        if size(neighbor_rpos,2)>=1 % �אڃG�[�W�F���g�̈ʒu�_�d�ݍX�V
                % �ȉ��͌v�Z���ׂ��������邪�d�ݕt��voronoi�����ƃZ���`�󂪕����
                %     tri=delaunay([0,neighbor_rpos(1,:)],[0,neighbor_rpos(2,:)]); % ���@��(0,0)���������h���l�[�O�p�`����
                %     tmpid=tri(logical(sum(tri==1,2)),:); % 1 �܂莩�@�̂��܂ގO�p�`���������o���D
                %     tmpid=unique(tmpid(tmpid~=1))-1; % tmpid = �אڃG�[�W�F���g�̃C���f�b�N�X �ineighbor_rpos���̃C���f�b�N�X�ԍ��j
                %     neighbor_rpos=neighbor_rpos(:,tmpid); % �אڃG�[�W�F���g�̑��Έʒu
                %     neighbor.pos=neighbor.pos(:,tmpid); % �אڃG�[�W�F���g�̈ʒu
                %     neighbor.weight=sensor_obj.output.neighbor.weight(tmpid); % neighbor weight
                %     neighbor.mass=sensor_obj.output.neighbor.mass(tmpid); % neighbor mass
%                 Vn=voronoi_region([[0;0;0],(neighbor_rpos)],[R,R;-R,R;-R,-R;R,-R],1:size(neighbor,2)+1);% neighbors�Ƃ̂݃{���m�C�����i���΍��W�j
            else % �ʐM�͈͂ɃG�[�W�F���g�����Ȃ��ꍇ
%                 Vn=voronoi_region([0;0;0],[R,R;-R,R;-R,-R;R,-R],1);
            end
            
            obj.result.state.p = (state.p+sensor.neighbor(:,1)+sensor.neighbor(:,2)+sensor.neighbor(:,3))/4;%(state.p+sensor.neighbor(:,1)+sensor.neighbor(:,2)+sensor.neighbor(:,3))/N;%.*[1;1;0]; % �d�S�ʒu�i��΍��W�j
%             obj.result.state.p(3) = 1; % ���t�@�����X�����͂P��
            result = obj.result;
        end
        function show(obj,param)
        end
    end
end