% initialize 
    clc; close all; clear;
    tmp = matlab.desktop.editor.getActive;
    cd(fileparts(tmp.Filename));
    DATAdir = cd(fileparts(tmp.Filename));
    
%%  �f�B���N�g������
    mkdir(DATAdir,'/simdata');
    Outputdir = strcat(DATAdir,'/simdata/2020_11_16_soft_constraint2');
    mkdir(Outputdir,'eps/Animation1');
    mkdir(Outputdir,'eps/Animation_omega');
    mkdir(Outputdir,'fig');
    mkdir(Outputdir,'data');
    mkdir(Outputdir,'png/Animation1');
    mkdir(Outputdir,'png/Animation_omega');
    mkdir(Outputdir,'video');

%% Setup
    %-- �p�����[�^
        dt = 0.05;          % - ���U���ԕ��i�`���[�j���O�K�v�����j
        Te = 2;	            % - �V�~�����[�V��������
        x0 = [0.0; 0.0];    % - �������
        u0 = [0.0; 0.0];    % - �������
        ur = [0.0; 0.0];    % - �ڕW���x
        Particle_num = 10; % - ���q���i�v�`���[�j���O�j
        Csigma = 0.001;     % - �\���X�e�b�v���Ƃɕω����镪�U�l�̏㏸�萔(�����͐�ɍs���قǕs�m�肾����\���X�e�b�v���i�ޓx�ɕW���΍���傫�����Ă����A�H�v��������Ȃ��Ă����Ȃ��Ǝv��)
        Count_sigma = 0;
        Initux = 0.05;      % - ���������
        Inituy = 0.00;      % - ���������
        umax = 1.0;         % - ���͂̍ő�l�A���͐���ƍő���̗͂}�����̂Ƃ��Ɏg��
        InitSigma_x = 0.03; % - �����̕��U�i�v�`���[�j���O�j
        InitSigma_y = 0.01; % - �����̕��U�i�v�`���[�j���O�j

    %-- MPC�֘A
        Params.H = 26;                         % - �z���C�]���i�`���[�j���O�j
        Params.dt = 0.1;                       % - �\���X�e�b�v���i�`���[�j���O�j
        Params.Weight.Qf = diag([1.0; 1.0]);   % - ���f���\������̏�Ԃɑ΂���I�[�R�X�g�d�݁i�v�`���[�j���O�j
        Params.Weight.Q  = diag([1.0; 1.0]);   % - ���f���\������̏�Ԃɑ΂���X�e�[�W�R�X�g�d�݁i�v�`���[�j���O�j
        Params.Weight.R  = diag([0.01; 0.01]); % - ���f���\������̓��͂ɑ΂���X�e�[�W�R�X�g�d�݁i�v�`���[�j���O�j
        %%- ���f���\������̍ő���͂𒴉߂��Ȃ��悤�}�����鍀�ɑ΂���X�e�[�W�R�X�g�d�݁i�v�`���[�j���O�j
        %%- �����y�̏C�_�ɍڂ��Ă�A����͏d��0�ɂ��č��̖������Ȃ�����
            Params.Weight.Rs = 0.0;                
        
    %-- �\���̂֊i�[
        Params.x0 = x0;
        Params.Particle_num = Particle_num;
        Params.Csigma = Csigma;
        Params.reset_flag = 0;
        Params.PredStep = repmat(dt*3, Params.H, 1); % - �z���C�Y���̔����㔼�̗\���X�e�b�v����傫��(�����͐�ɍs���قǕs�m�肾����\���X�e�b�v����傫�����Ă����A�H�v��������Ȃ��Ă����Ȃ��Ǝv��)
        Params.PredStep(1:Params.H/2, 1) = dt;
        Params.umax = umax;
    
    %-- ����Ώۂ̃V�X�e���s��
        [Ad, Bd, Cd, Dd] = MassModel(dt);
            Params.Ad = Ad;
            Params.Bd = Bd;
            Params.Cd = Cd;
            Params.Dd = Dd;
            [~, state_size] = size(Ad);
        [~, input_size] = size(Bd);
%         total_size = state_size + input_size;
 
    %-- �\�����f���̃V�X�e���s��
        [MPC_Ad, MPC_Bd, MPC_Cd, MPC_Dd] = MassModel(Params.dt);
            Params.A = MPC_Ad;
            Params.B = MPC_Bd;
            Params.C = MPC_Cd;
            Params.D = MPC_Dd;
               
    %-- �f�[�^�z�񏉊���
        x = x0;
        u = u0;

        idx = 0;
        dataNum = 8;
        data.state           = zeros(round(Te/dt + 1), dataNum);
%         data.state(idx+1, 1) = idx * dt; % - ���ݎ���
%         data.state(idx+1, 2) = x(1);     % - ��� x
%         data.state(idx+1, 3) = x(2);     % - ��� y
%         data.state(idx+1, 4) = 0;        % - ���� ux  
%         data.state(idx+1, 5) = 0;        % - ���� uy
%         data.state(idx+1, 6) = 0;        % - ux,uy�̃m����
%         data.state(idx+1, 7) = 0;        % - �ڕW��� xr
%         data.state(idx+1, 8) = 0;        % - �ڕW��� yr        
        data.path{idx+1}  = {}; % - �S�T���v���S�z���C�Y���̒l
        data.pathJ{idx+1} = {}; % - �S�T���v���̕]���l
        data.state(idx+1, 1) = idx * dt; % - ���ݎ���
        data.state(idx+1, 2) = x(1);     % - ��� x
        data.state(idx+1, 3) = x(2);     % - ��� y
        data.state(idx+1, 4) = 0;        % - ���� ux  
        data.state(idx+1, 5) = 0;        % - ���� uy
        data.state(idx+1, 6) = 0;        % - ux,uy�̃m����
        data.state(idx+1, 7) = 0;        % - �ڕW��� xr
        data.state(idx+1, 8) = 0;        % - �ڕW��� yr
        data.bestcost(idx+1) = 0;        % - �����Ƃ��悢�]���l
        data.bestx(idx+1, :) = repelem(x(1), Params.H); % - �����Ƃ��悢�]���̋O��x����
        data.besty(idx+1, :) = repelem(x(2), Params.H); % - �����Ƃ��悢�]���̋O��y����
        data.sigmax(idx+1, :) = 0; % - x�̕W���΍��̒l
        data.sigmay(idx+1, :) = 0; % - y�̕W���΍��̒l  
        
        sigma_cnt = 1:Params.H; % - �W���΍��̏㏸�Ɏg���Ă�
    
%% main-loop
while idx * dt < Te + dt
    %-- 1��������ɂ����鎞�Ԃ�tictoc�Ōv��
        tic
        
    %-- ����ڂ̃��[�v��
        idx = idx + 1;
        
	%-- ���s��Ԃ̕\��
%         disp(['Time: ', num2str(idx * Td, '%.2f'), ' s, state: ', num2str(x','[%.2f\t]'), ', input: ', num2str(u','[%.2f\t]')]);       
    
    %-- �ϑ�������
        y = Cd * x;

	%-- �ڕW�O������
        xr = Reference(idx * dt, Params);
        
    %-- MPC�Ńp�����[�^��z��Ɋi�[
        Params.Ur = ur;
        Params.Xr = xr;
        Params.X0 = x;
        Params.input_size = input_size;
        Params.state_size = state_size;
   
%-- �����e�J�������f���\������
    %-- MPC�̃z���C�Y���Ԃ̕��U
        if Count_sigma == 0 || Count_sigma ==1
            sigmax = repmat(InitSigma_x + Csigma * (sigma_cnt - 1), Particle_num, 1)'; % - ��������
            sigmay = repmat(InitSigma_y + Csigma * (sigma_cnt - 1), Particle_num, 1)';
        else
            sigmax = repmat(sigmanext_x + Csigma * (sigma_cnt - 1), Particle_num, 1)'; % - ���������ȍ~
            sigmay = repmat(sigmanext_y + Csigma * (sigma_cnt - 1), Particle_num, 1)';
        end

    %-- ���œK�����͂��i�[
        if Count_sigma == 0 
            ux_ten = repmat(Initux, Params.H, Particle_num);
            uy_ten = repmat(Inituy, Params.H, Particle_num);
            %-- fmincon�ŎZ�o�����l�����A����������������z�@��p���ĎZ�o����p�^�[��������
            %-- ����������Ⴊ���邱�Ƃ�m���ė~��������c���Ă�����
                % ux_ten = repmat(u_previous_opt(1,:)', 1, Particle_num);
                % uy_ten = repmat(u_previous_opt(1,:)', 1, Particle_num);
        else
            ux_ten = reshape(u_x, size(nx)); % - ���������ȍ~�C���œK�����͂��i�[
            uy_ten = reshape(u_y, size(ny));
        end
    
    %-- ���U�ɂ��m�C�Y���i�[�C���͂̍L���������
        nx = normrnd(zeros(Params.H,Particle_num), sigmax);
        ny = normrnd(zeros(Params.H,Particle_num), sigmay);

    %-- �e�����̓��͗���i�[
        ux = ux_ten + nx;   % ux_ten : ���ϒl�Ƃ��Ĉ���
        uy = uy_ten + ny;
        ux = reshape(ux, [1, size(ux)]);
        uy = reshape(uy, [1, size(uy)]);
        u1 = [ux; uy];

    %-- ���͐���̊m�F (Checking Input Constraint)�A���͂̐�����s���ꍇ��Input_Const���R�����g�C��
    %-- ���͐�����g���ۂɂ͏�Ԑ���(State_Const)�̃t�@�C�����̓��͐�������p���镔��(Input_Const)���R�����g�A�E�g���O��    
        remove_flagI = 1;
        remove_data = 0;
%         [u1, remove_flagI, remove_ID, remove_data] = Input_Const(Params, u1); % ���͐��� ���̃v���O�����͏�Ԃɓ��͓����ĂȂ�����R�����g�A�E�g���Ă�
%         data.remove_data(idx) = remove_data;
%         Params.remove_ID = remove_ID;

    if remove_flagI == 0
        uOpt = repmat(unow(:, 1), 1,Params.H);
        u_x = repmat(unow(1, :), Params.H, Params.Particle_num);
        u_y = repmat(unow(2, :), Params.H, Params.Particle_num);
    %     u_x = repmat(uOpt.u(1).u(1,:)',1,Params.Particle_num);
    %     u_y = repmat(uOpt.u(1).u(2,:)',1,Params.Particle_num);
        sigmanext_x = 0.5;
        sigmanext_y = 0.5;
        sigma_reset_flag = 1;

        data.path{idx} = state_data;
        data.pathJ{idx} = Evaluationtra;
        data.state(idx, 1) = idx * dt;  % ���ݎ���
        data.state(idx, 2) = x(1);      % ��� x
        data.state(idx, 3) = x(2);      % ��� y
    %     data.state(idx,4) = x(3);      % ���x vx
    %     data.state(idx,5) = x(4);      % ���x vx
    %     data.state(idx,6) = x(5);      % �d�� E
        data.state(idx, 4) = unow(1, 1); % ���� u  
        data.state(idx, 5) = unow(2, 1);
        data.state(idx, 6) = norm(unow(:, 1));
        data.state(idx, 7) = xr(1, 1);  % �ڕW��� xr
        data.state(idx, 8) = xr(2, 1);
    %     data.state(idx,11) = xr(3,1);  
    %     data.state(idx,12) = xr(4,1);
        data.bestcost(idx) = Bestcost; %�����Ƃ��悢�]���l
        data.bestx(idx, :) = state_data(1, :, BestcostID); %�����Ƃ��悢�]���̎��̋O��
        data.besty(idx, :) = state_data(2, :, BestcostID);
        data.sigmax(idx, :) = sigmax(1, 1);
        data.sigmay(idx, :) = sigmay(1, 1);

    %     x = Ad*x + Bd*unow(:,1) + [0; 0; 0; 0; (Winnow - Woutnow)*Td];
        x = Ad * x + Bd * unow(:,1) + [0; 0];
        Count_sigma = Count_sigma + 1;

        disp(['Time: ', num2str(idx * dt, '%.2f')]); %, num2str(unow(:,1)','[%.2f\t]')
        disp('Input reset')
        continue
    end

    u1_size = size(u1, 3);

    %-- �S�\���O���̃p�����[�^�̊i�[�ϐ����`
        x_data = zeros(Params.H, Particle_num);
        x_data = reshape(x_data, [1, size(x_data)]);
        y_data = zeros(Params.H, Particle_num);
        y_data = reshape(y_data, [1, size(y_data)]);

        state_data = [x_data; y_data];

    %-- ��ԕ������ɂ��\���O���v�Z
        for i = 1:u1_size
            x0 = x;
            state_data(:, 1, i) = x0;
            for j = 1 : Params.H-1
                x1 = Params.A * x0 + Params.B * u1(:, j, i);
                y = Params.C * x1;
                x0 = y;
                state_data(:, j+1, i) = x0;
            end 
        end
        % disp('finish trajectory generate');

    %-- �]���l�v�Z
        Evaluationtra = zeros(1, u1_size);
        for i = 1:u1_size
            eve = EvaluationFunction(state_data(:, :, i), u1(:, :, i), Params);
            Evaluationtra(1, i) = eve;
        end
        % disp('Finish Calculating Evaluation Cost ');
        [Bestcost, BestcostID] = min(Evaluationtra); %�ŏ��]���l���Z�o

    %-- ��Ԑ���(�s��������)�̊m�F�A��Ԃ̐�����s���ꍇ��Input_Const���R�����g�C��
    %-- �����y�̏[�d�ʂ������񂪂Ȃ����߁A����R�����g�C�����Ă��Ӗ����Ȃ��A���㐧�������ۂɎQ�l�ɂ���
        remove_flag = 1;
%         [remove_flag, Evaluation_update, s_update, u_update] = State_Const(Params, Evaluationtra, state_data, u1);

    %-- �N���X�^�����O
        if remove_flag ~= 0
            [uOpt, ~] = clustering(Params, Evaluationtra, u1, state_data);
        end
        
    %-- �ŏ��]���l�̓��͂����T���v�����O�C�i�[,�������̕��U����
        if remove_flag ~= 0
            [Params, L_norm] = Normalize(Params, Evaluationtra);
            [u_y, ~, u_x] = Resampling(Params, u1, L_norm);
        end

    if remove_flag(1) == 0 % - �S�T���v������Ԑ���Ŋ��p���ꂽ�ꍇ
        uOpt = repmat(unow(:, 1), 1, Params.H);
        u_x = repmat(unow(1, :), Params.H, Params.Particle_num);
        u_y = repmat(unow(2, :), Params.H, Params.Particle_num);
        sigmamext_x = 0.5;
        sigmanext_y = 0.5;
        sigma_reset_flag = 1;
    else
        unow = uOpt.u(1).u(:, 1);

        %-- �v�����g���f�����Ő���𒴂�����͂�␳
            unormnow = norm(unow(:, 1));
            if unormnow > Params.umax
                unow(:, 1) = (Params.umax/unormnow) * unow(:, 1);   
            end

        %-- �������̕��U�̌���
        %-- �O�����ƌ������̕]���l���r���āC�]���������Ȃ�����W���΍����L���āC�]�����ǂ��Ȃ�����W���΍������߂�悤�ɂ��Ă���
            if Count_sigma == 0 || sigma_reset_flag == 1 % - �ŏ��͑S�����̕]���l���Ȃ����猻����/�������ɂ��Ă�
                Bestcost_pre = Bestcost;
                Bestcost_now = Bestcost;
                sigma_reset_flag = 0;
            else
                Bestcost_pre = Bestcost_now;
                Bestcost_now = Bestcost;
            end
            sigmanext_x = sigmax(1,1) * (Bestcost_now/Bestcost_pre);
            sigmanext_y = sigmay(1,1) * (Bestcost_now/Bestcost_pre);
%             sigmanext_x = sigmax(1,1);
%             sigmanext_y = sigmay(1,1);
    end

    %-- �f�[�^�ۑ�
        data.path{idx+1}  = state_data;    % - �S�T���v���S�z���C�Y���̒l
        data.pathJ{idx+1} = Evaluationtra; % - �S�T���v���̕]���l
        data.state(idx+1, 1) = idx * dt;         % - ���ݎ���
        data.state(idx+1, 2) = x(1);             % - ��� x
        data.state(idx+1, 3) = x(2);             % - ��� y
        data.state(idx+1, 4) = unow(1, 1);       % - ���� ux  
        data.state(idx+1, 5) = unow(2, 1);       % - ���� uy
        data.state(idx+1, 6) = norm(unow(:, 1)); % - ux,uy�̃m����
        data.state(idx+1, 7) = xr(1, 1);         % - �ڕW��� xr
        data.state(idx+1, 8) = xr(2, 1);         % - �ڕW��� yr
        data.bestcost(idx+1) = Bestcost; % - �����Ƃ��悢�]���l
        data.bestx(idx+1, :) = state_data(1, :, BestcostID); % - �����Ƃ��悢�]���̋O��x����
        data.besty(idx+1, :) = state_data(2, :, BestcostID); % - �����Ƃ��悢�]���̋O��y����
        data.sigmax(idx+1, :) = sigmax(1, 1); % - x�̕W���΍��̒l
        data.sigmay(idx+1, :) = sigmay(1, 1); % - y�̕W���΍��̒l        

    %-- ��ԍX�V
        x = Ad * x + Bd * unow(:, 1);
        Count_sigma = Count_sigma + 1;
        
    %-- tic�̑΁A����������O���t�ɂ�����������toc�̍��ӂɕϐ������āA������v���b�g����΂ł���Ǝv��
        toc
        
        disp(['Time: ', num2str(idx * dt, '%.2f')]); %, num2str(unow(:,1)','[%.2f\t]')
end

%% Save data
    cd(strcat(Outputdir, '/data'));
    writematrix(data.state, 'result.csv');
    writematrix([data.state(:, 1), data.bestcost'], 'result_bestcost.csv');
    writematrix(data.bestx, 'result_bestx.csv');
    writematrix(data.besty, 'result_besty.csv');
    save('Parameter.mat', '-struct', 'Params', '-v7.3'); % - 2GB�𒴂���.mat��ۑ�����ꍇ'-v7.3'�̒ǋL���K�v�A����h���[���ɓK�p������2GB������Ǝv��
    cd(fileparts(tmp.Filename))
    
%% Plot
    %-- �摜����
        PlotFig

    %-- ���搶��
        PlotMov

%% Model
    function [Ad, Bd, Cd, Dd]  = MassModel(Td)
        %-- �A���n�V�X�e��
                Ac = [1.0, 0.0;
                      0.0, 1.0];
                Bc = [1.0, 0.0;
                      0.0, 1.0];
                Cc = diag([1, 1]);
                Dc = 0;
                sys = ss(Ac, Bc, Cc, Dc);

        %-- ���U�n�V�X�e��
                dsys = c2d(sys, Td); % - �A���n���痣�U�n�ւ̕ϊ�
                [Ad, Bd, Cd, Dd] = ssdata(dsys);

    end

