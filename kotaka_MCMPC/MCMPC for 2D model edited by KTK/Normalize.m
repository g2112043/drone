function [obj,pw_new] = Normalize(obj,pw)
    %�d�݃x�N�g���𐳋K������֐�
	NP = obj.Particle_num;
% 	pwnotcollision = 1./pw(pw<10);
%     pwnotcollision = exp(-pw(pw<10));
%     pwnotcollisionID = pw < 10;
%     sumnotcollision = sum(pwnotcollision);
%     if sumnotcollision~=0
%         pw_new = exp(-pw)/sum(sumnotcollision);
%     else
%         pw_new=zeros(1,NP)+1/NP;
%     end
%     pw_new = pw_new.*pwnotcollisionID;
    if isempty(pw(pw<=49))
        obj.reset_flag = 1;
    end
    % �]���l��0�����ɂȂ炸�ŏ��l�𐳋K�������ۂ�1�ƍl�����ꍇ�C�w���֐���
    % �g���Đ��K�������邱�Ƃɂ���ď�肢���ƃ��T���v�����O�ł���D
    pw = exp(-pw);
    sumw = sum(pw);
    if sumw~=0
        pw = pw/sum(pw);%���K��
    else
        pw = zeros(1,NP)+1/NP;
    end
    pw_new = pw;
end
