function [pu, remove_flag, removeX, remove_check_data] = Input_Const(Params, pu)
    %�p�����[�^�ݒ�
    unorm = zeros(1, Params.H, Params.Particle_num);
    H = Params.H;
    umax = Params.umax;
    
    %���͂̃��[�N���b�h�m�������v�Z
    for i = 1:Params.Particle_num 
        for j = 1:H
            
            unorm(1, j, i) = norm(pu(:, j, i));
 
        end
    end
    
    %��ł�max�𒴂����炻�̃T���v�������p
    removeI = (unorm(1,:,:) >= umax);
    removeI_check = fix(find(removeI)/Params.H)+1; %���p����T���v���ԍ����Z�o
    
    %�Ō�̗��q������Ɉ������������ꍇ�C�z�肵�Ă���ő�ȃT���v���ԍ��𒴂��邱�Ƃ�����̂ł��̕������C��
    I_size = size(removeI_check); 
    if I_size(1) ~=0
        if removeI_check(end,1) == (Params.Particle_num + 1)
            removeI_check(end,1) = Params.Particle_num;
        end
    end
    
    %�T���v���ԍ��̏d�Ȃ���Ȃ���
    removeX = unique(removeI_check);
    
    %����ᔽ�̓��̓T���v��(���͗�)�����p
    pu(:,:,removeX)=[];
    
    remove_flag = size(pu,3); %�S����ᔽ�ɂ�镪�U���Z�b�g���m�F����t���O 
    
    %�T���v�������p�������ǂ����m�F(�f�o�b�O�p)
    remove_check_data = 0;
    if size(removeX,1) ~=0
        disp('Input Constraint Violation!')
        remove_check_data = size(removeX,1);
    end
    
%% max�𒴂����Ƃ���max�ɖ߂��v���O����
%     for i = 1:Params.Particle_num 
%         for j = 1:H
%             if unorm(1, j, i) > umax
%                 
%                 udis = umax/unorm(1, j, i);
%                 pu(:, j, i) = pu(:, j, i)*udis;
%                 
%             end
%         end
%     end

end