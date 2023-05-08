function [uOpt, fval] = clustering(obj, pw, pu, px)
    % ���񂩂�O��Ă�����̂̓T���v�������菜��
    % �T���v���������邽�߃��T���v�����O���ɑ��₷(���������킹�鏈�����ʂɕK�v�H)
    % �����ȍ~�ł�px��pu,pw�ƃC���f�b�N�X�I�ɑΉ����Ȃ��Ȃ邱�Ƃɒ���
	DT = obj.dt;
	
    k_sigma = 10.0;
    thr = k_sigma; 
    
    % �œK���̎Z�o(���T���v�����O�O�ɕ]���֐��̒l�Ɋ�Â��Ĕ����o���C���͗�Ԃ̋����ɉ����ăN���X�^�����O������@)
    [sortFval, sortIdx] = sort(pw);
    % ���T���v�����O�O�ɕ]���l�̗ǂ����̂�����בւ��C�g�b�v����x%�𔲂��o��
    sortIdxT = sortIdx(1:ceil(0.05 * length(pw)));
    pwT = pw(sortIdxT);
    puT = pu(:, :, sortIdxT);
    pxT = px(:, :, sortIdxT);
    
%     figure
%     for i = 1:length(sortIdxT)
%         plot(pxT(1,:,i),pxT(2,:,i));hold on
%     end
%     axis equal
    % 1�Ԃ������̂�1�ڂ̃N���X�^�Ƃ���
    pcT = zeros(1,length(pwT));
    pcT(1) = 1;
    cNum = 1;
    
    % 2�Ԗڈȍ~�𑶍݂���N���X�^(2�Ԗڂɂ����Ă�1�ڂ̃N���X�^�̂�)�S�ĂƋ�����r
    % ������臒l�ȉ��Ȃ瓯���N���X�^�ɒǉ��C臒l���傫���Ȃ�V�����N���X�^�ɂ���@�����𔲂��o�����T���v�����J��Ԃ�
    for i = 2:length(pwT)
        for j = 1:cNum
%             dist(j) = norm(puT(:,:,i) - mean(puT(:,:,pcT==j),3)); % i�Ԗڂ̃T���v����j�Ԗڂ̃N���X�^�̋��������߂�
            dist(j) = sum((pxT(:, :, i) - mean(pxT(:, :, pcT == j), 3)).^2,'all');
        end
        [minDist, minIdx] = min(dist);
        if minDist < thr(minIdx)
            pcT(i) = minIdx;
%             thr(minIdx) = minDist;
        else
            cNum=cNum+1;
            pcT(i) = cNum;
            thr(cNum) = k_sigma;
        end
    end
    % �N���X�^���Ƃɏd�ݕt�����ς��Ƃ�C���͗�ƕ]���l���N���X�^���������o�͂���
%     if isempty(puT)
%         fval = [];
%     else
% �����̏�ԕ������ɒ����D
        for j=1:cNum
            uOpt.u(j).u = mean(puT(:, :, pcT == j), 3);
            fval.f(j).f = mean(pwT(pcT == j));
        end
        for j = 1:cNum
            uOpt.u(j).x = px(:, 1, 1);
            for i = 1:length(DT)
                uOpt.u(j).x(1, i + 1) = uOpt.u(j).x(1, i) + uOpt.u(j).u(1, i) * DT;
                uOpt.u(j).x(2, i + 1) = uOpt.u(j).x(2, i) + uOpt.u(j).u(1, i) * DT;
            end
        end
%     end
    uOpt.cNum = cNum;
    uOpt.pcT = pcT;
    uOpt.puT = puT;
    uOpt.pxT = pxT;
%     cNum
end