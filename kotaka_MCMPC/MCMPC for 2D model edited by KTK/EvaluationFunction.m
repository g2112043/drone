function[MCeval] = EvaluationFunction(x, u, params)

     %-- ���f���\������̕]���l���v�Z����v���O����
        %-- MPC�ŗp����\����� X�Ɨ\������ U��ݒ�
            Unorm = zeros(1,params.H);
            X = x;
            U = u;
            H = 1:params.H;
            
        for j = 1:params.H            
            Unorm(1, j) = norm(U(:, j));            
        end

        %-- ��ԋy�ѓ��͂ɑ΂���ڕW��Ԃ�ڕW���͂Ƃ̌덷���v�Z
            tildeX = X - params.Xr;
            tildeU = U - params.Ur;
            
        %-- ��ԋy�ѓ��͂̃X�e�[�W�R�X�g���v�Z
            stageState = arrayfun(@(L) tildeX(:, L)' * params.Weight.Q * tildeX(:, L), 1:params.H-1);
            stageInput = arrayfun(@(L) tildeU(:, L)' * params.Weight.R * tildeU(:, L), 1:params.H-1);
            
        %-- �����y�̏[�d�ʂ̍��̖��c�A
            %�w���֐��ŋ}���ȕω�
            %stageElectric = arrayfun(@(L) params.Weight.Re*exp(-(X(5, L) - 75)), 1:params.H-1);
            %�\�t�g�v���X�֐�
            
%             �� �[�d�� ��
%             stageElectric = arrayfun(@(L) params.Weight.Re*log(1+exp(-(X(5, L) - 75)))^2, 1:params.H-1);
%             stageInput2 = arrayfun(@(L) params.Weight.Rs*log(1+exp(-(-Unorm(1, L) + 4)))^2, 1:params.H-1);
            
            stageInput2 = arrayfun(@(L) Unorm(1, L) - params.umax, 1:params.H-1);
            
            for i = 1:params.H-1
                if stageInput2(i) <= 0
                    stageInput2(i) = 0;                    
                else
                    stageInput2(i) = params.Weight.Rs * stageInput2(i)^2;                    
                end
            end
            
        %-- ��Ԃ̏I�[�R�X�g���v�Z
            terminalState = tildeX(:, end)' * params.Weight.Qf * tildeX(:, end);
            
        %-- �]���l�v�Z
            MCeval = sum(stageState + stageInput + stageInput2) + terminalState;
%             MCeval = sum(stageState + stageInput + stageElectric) + terminalState;

end