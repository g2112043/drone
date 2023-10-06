% -------------------------------------------------------------------------
% File : mpcMain.m
% Discription : Program for demonstration of model predctive control
% Author : Ryuichi Maki
% Editor : Shunsuke Irisawa (2022-10-13)
% -------------------------------------------------------------------------
%% Setup
    % ������
        tmp = matlab.desktop.editor.getActive;
        cd(fileparts(tmp.Filename));
        clc;disp('Setup for simulation...');
        tmp = matlab.desktop.editor.getActive;warning('off','all');
        cd(fileparts(tmp.Filename)); close all; userpath('clear');addpath(genpath('./src'));

    % �����ۑ��p�t�H���_�쐬
        ntime = char(datetime('now', 'Format', 'MMdd_HHmmSS'));
        Name = 'test';                         % �����Ŗ��O��ύX���邱�� 
        saveFolderName = [Name, '_',ntime ];
        pathname = '/Plot_data/';
        currentfolder = pwd;
        folderName = strcat(currentfolder,pathname,saveFolderName);
        mkdir(folderName);
        mkdir('.fig')
        mkdir('.pdf')
        mkdir('.eps')
        movefile('.fig', folderName);
        movefile('.pdf', folderName);
        movefile('.eps', folderName);

    % �p�����[�^
%         Td = 0.05;                              % ���U���ԕ�,�z���C�]���̕�,�V�X�e���Ɉ�����鎞�ԕ�
        Td = 0.1;                               % ���U���ԕ�,�z���C�]���̕�,�V�X�e���Ɉ�����鎞�ԕ�
        Te = 5;	                            % �V�~�����[�V��������
        x0 = [0.; 1.];                          % �������
        u0 = [0.; 0.];                          % ������ԁC����
        ur = [0.5;0.];                          % �ڕW���x
        Xo = [3;1];                             % ��Q�̈ʒu�@(�Î~��Q��)

    % ����Ώۂ̃V�X�e���s��
        [Ad, Bd, Cd, Dd] = MassModel(Td);
        Params.Ad = Ad;
        Params.Bd = Bd;
        Params.Cd = Cd;
        Params.Dd = Dd;

        [~, state_size] = size(Ad);
        [~, input_size] = size(Bd);
        total_size = state_size + input_size;

    % MPC ��`
        options.Algorithm = 'sqp';
        options.Display = 'iter';
        problem.solver = 'fmincon';
        problem.options = options;              % �\���o�[

    % �p�����[�^�ݒ�
        MPC_H  = 25;                            % ���f���\������̃z���C�]��
        Params.H= MPC_H + 1;
        Params.dt = 0.05;                       % ���f���\������̍��ݎ��ԁC�������
        Params.Xo = Xo*ones(1, Params.H);       % ��Q���̍��W���z���C�]����
        
    % �]���֐��d��
        Params.Weight.Qf = diag([1.; 1.]);      % ���f���\������̏�Ԃɑ΂���I�[�R�X�g�d�݁Cdiag�͑Ίp�s���\��
        Params.Weight.Q  = diag([1.; 1.]);      % ���f���\������̏�Ԃɑ΂���X�e�[�W�R�X�g�d��
        Params.Weight.R  = diag([1.; 1.]);      % ���f���\������̓��͂ɑ΂���X�e�[�W�R�X�g�d��
        Params.Weight.Qapf = 0.4;               % �l�H�|�e���V������@�ɑ΂���d��
        
% �d�݂̃`���[�j���O %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        Params.Weight.Q(2,2) = 1;       % y�̒Ǐ]�ɑ΂���d��

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % �\�����f���̃V�X�e���s��
        [MPC_Ad, MPC_Bd, MPC_Cd, MPC_Dd] = MassModel(Params.dt);
        Params.A = MPC_Ad;
        Params.B = MPC_Bd;
        Params.C = MPC_Cd;
        Params.D = MPC_Dd;

dataNum= 10; 
%% main
    %- �f�[�^�z�񏉊���
    x = x0;
    u = u0;
    previous_state  = zeros(state_size + input_size, Params.H);
    data.state      = zeros(round(Te / Td + 1), dataNum); 
    data.state(1,1) = 0.;       % ��������
    data.state(1,2) = x(1);     % ������� x(1) = x
    data.state(1,3) = x(2);     % ������� x(2) = y
    data.state(1,4) = 0.;       % �������� u(1) = v_x
    data.state(1,5) = 0.;       % �������� u(2) = v_y
    data.state(1,6) = x(1);     % �����ڕW��� xr(1)
    data.state(1,7) = x(2);     % �����ڕW��� xr(2)
    data.state(1,8) = 0.;       % �����ڕW���� ur(1)
    data.state(1,9) = 0.;       % �����ڕW���� ur(2)
    idx = 1;                    % roop index
%- main ���[�v %�X���C�h�̃u���b�N���}
while x(1)<5
    idx = idx + 1;
%% �O����
	% ���s��Ԃ̕\��
        disp(['Time: ', num2str(idx * Td, '%.2f'), ' s, state: ', num2str(x','[%.2f\t]'), ', input: ', num2str(u','[%.2f\t]')]);
        % time:t state:x y input:v_x v_y
    
    % �ϑ�������
        y = Cd*x;
    
	% �ڕW�O������
%        [xr,flag] = Reference(Params.H, ur, y, Params.dt,x0);             % �ڕW�o�H 1
       [xr,flag] = Reference2(Params.H, ur, y, Params.dt,x0);            % �ڕW�o�H 2
     
       if flag ==1
           data.state(1,7) = 0.5;
       else
           data.state(1,7) = 1.0;
       end
    
    % MPC�Ńp�����[�^��z��Ɋi�[
        Params.Ur= ur;
        Params.Xr= xr;
        Params.X0= x;
        Params.input_size = input_size;
        Params.state_size = state_size;
   
%% ���f���\������
        % MPC�ݒ�
            problem.x0		  = previous_state;                         % ���ݏ��
            problem.objective = @(x) Objective(x, Params);              % �]���֐�
%             problem.objective = @(x) Objective2(x, Params);             % �]���֐� �l�H�|�e���V��������
%             problem.nonlcon   = @(x) Constraints(x, Params);            % �������
            problem.nonlcon   = @(x) Constraints2(x, Params);           % ������� �ʒu���񂠂�
                
        % �œK���v�Z
            [var, fval, exitflag, output, lambda, grad, hessian] = fmincon(problem);
            
        % ������͂̌���
            previous_state    = var;                                    % �œK���������ʂ��ꎞ�I�ɕۑ�
            u = var(state_size + 1:total_size, 1);                      % �œK���v�Z�ł̌��ݎ����̓��͂𐧌�ΏۂɈ������͂Ƃ��č̗p
        
%% �㏈��
    % �f�[�^�ۑ�
        data.state(idx,1) = idx * Td;   % ���ݎ���
        data.state(idx,2) = x(1);       % ��� x(1)
        data.state(idx,3) = x(2);       % ��� x(2)
        data.state(idx,4) = u(1);       % ���� u(1)
        data.state(idx,5) = u(2);       % ���� u(2)
        data.state(idx,6) = xr(1,1);    % �ڕW��� xr(1)
        data.state(idx,7) = xr(2,1);    % �ڕW��� xr(2)
        data.state(idx,8) = ur(1,1);    % �ڕW���� ur(1)
        data.state(idx,9) = ur(2,1);    % �ڕW���� ur(2)
        data.state(idx,10)= fval;       % �]���l
        data.exitflag(idx)= exitflag;   % �œK���v�Z��������
        data.output(idx)  = output;     % �œK���v���Z�X�Ɋւ�����
        data.lambda(idx)  = lambda;     % ���ɂ����郉�O�����W���搔
        data.grad(idx)	  = {grad};     % �œK���v�Z�ɂ�������z
        data.hessian(idx) = {hessian};  % �œK���v�Z�ɂ�����w�b�Z�s��
        data.var(idx)     = {var};      % �œK���v�Z�ɂ����錈��ϐ�
        data.Xopt(idx,:)    = var(1,:); % �œK���v�Z�ŎZ�o���ꂽx�̉�
        data.Yopt(idx,:)    = var(2,:); % �œK���v�Z�ŎZ�o���ꂽy�̉�
        
    % ����Ώ� ��ԍX�V
        x = Ad*x + Bd*u;
        
end

%% PLOT
figNum = 0;
% X-Y����
figNum = figNum + 1;
figure(figNum)
figName = 'Time_change_of_position';
fig = gcf;
fig.Color= [1., 1., 1.];
hold on;
% plot(data.state(:,2),data.state(:,3),'-','LineWidth',1.75);
% plot(data.state(:,6),data.state(:,7),'-','LineWidth',1.75);
plot(data.state(:,1),data.state(:,2),'-','LineWidth',1.75);
plot(data.state(:,1),data.state(:,3),'-','LineWidth',1.75);
% plot(data.state(:,1),data.state(:,6),'-','LineWidth',1.75);
% plot(data.state(:,1),data.state(:,7),'-','LineWidth',1.75);
grid on; axis equal; hold off; box on;
set(gca,'FontSize',16);
% ylabel('$$Y$$ [m]', 'Interpreter', 'latex')
% xlabel('$$X$$ [m]', 'Interpreter', 'latex')
ylabel('$$X, Y$$ [m]', 'Interpreter', 'latex')
xlabel('$$t$$ [s]', 'Interpreter', 'latex')
lgd = legend("X", "Y");
lgd.NumColumns = 2;
xlim([min(data.state(:,1)), max(data.state(:,1))]);
save_n_move(figNum,figName,folderName)
%% ���Ԃɑ΂����ԕω�
figNum = figNum + 1;
figure(figNum)
figName = 'Trajectoryt&Reference';
fig = gcf;
fig.Color= [1., 1., 1.];
hold on;
plot(data.state(:,1),data.state(:,2),'-','LineWidth',1.75);
plot(data.state(:,1),data.state(:,3),'-','LineWidth',1.75);
plot(data.state(:,1),data.state(:,6),'--','LineWidth',1.75);
plot(data.state(:,1),data.state(:,7),'--','LineWidth',1.75);
plot(Xo(1), Xo(2), '.', 'MarkerSize', 50);
grid on; hold off; box on;
set(gca,'FontSize',16);
ylabel('$$X, Y$$ [m]', 'Interpreter', 'latex')
xlabel('$$t$$ [s]', 'Interpreter', 'latex')
xlim([0.,Te]);
lgd = legend('$$x$$','$$y$$','$$x_{ref}$$','$$y_{ref}$$', 'Interpreter', 'latex','Location','southoutside');
lgd.NumColumns = 4;% ���Ԃɑ΂�����͕ω�
save_n_move(figNum,figName,folderName)

figNum = figNum + 1;
figure(figNum)
figName = 'Velocity';
fig = gcf;
fig.Color= [1., 1., 1.];
hold on;
plot(data.state(:,1),data.state(:,4),'-','LineWidth',1.75);
plot(data.state(:,1),data.state(:,5),'-','LineWidth',1.75);
grid on; hold off; box on;
set(gca,'FontSize',16);
ylabel('$$U_1, U_2$$ [m/s]', 'Interpreter', 'latex')
xlabel('$$t$$ [s]', 'Interpreter', 'latex')
xlim([0.,Te]);
lgd = legend('$$v_x$$','$$v_y$$', 'Interpreter', 'latex','Location','southoutside');
lgd.NumColumns = 2;
save_n_move(figNum,figName,folderName)

% ���Ԃɑ΂���]���l�ω�
figNum = figNum + 1;
figure(figNum)
figName = 'Evaluation_value';
fig = gcf;
fig.Color= [1., 1., 1.];
hold on;
plot(data.state(:,1),data.state(:,10),'-','LineWidth',1.75);
grid on; hold off; box on;
set(gca,'FontSize',16);
ylabel('$$J$$ [-]', 'Interpreter', 'latex')
xlabel('$$t$$ [s]', 'Interpreter', 'latex')
xlim([0.,Te]);
legend('Evaluation value','Location','southoutside')
save_n_move(figNum,figName,folderName)

%% ����
figure(6)
timestamp= datestr(now,'yyyymmdd_HHMM_ss');
v=VideoWriter(timestamp,'MPEG-4');
v.FrameRate=20;
open(v);
    fig = gcf;
    fig.Color= [1., 1., 1.];
    for k=1:size(data.state-1,1)
        % �ڕW�o�H
            p1=plot(data.state(3:end,6),data.state(3:end,7),'-','LineWidth',1.75);
            hold on;
        % ���
            p2=plot(data.state(k,2),data.state(k,3),'s','LineWidth',1.75);
        % �\���_
            plot(data.Xopt(k,:),data.Yopt(k,:),'.','LineWidth',1.75);
        %�ʒu����
%             plot(Xo(1), Xo(2), '.', 'MarkerSize', 20);
    %    p3=yline(0.4,'--','LineWidth',1.7);
          
        % set Params
            grid on; axis equal; hold off;
            set(gca,'FontSize',16);
            legend([p2 p1],{'State','Target'},'Location','best','Interpreter', 'Latex','FontSize',12);
%             legend([p2 p1 p3],{'State','Target','Constraint'},'Location','best','Interpreter', 'Latex','FontSize',12);
            xlabel('X [m]','Interpreter', 'Latex');ylabel('Y [m]','Interpreter', 'Latex');
            xlim([0.,5]);ylim([-0.5 2]);
            
        drawnow
        frame=getframe(gcf);
        writeVideo(v,frame)
        pause(0.1)
    end
    close(v);
    movefile([timestamp,'.mp4'], folderName);
    
    

%% ���f���̋L�q
    function [Ad, Bd, Cd, Dd]  = MassModel(Td)          % ��ԁF[x,y],�@������� [vx,vy]
    %% �A���n�V�X�e��
            Ac = [0.0, 0.0;
                     0.0, 0.0];
            Bc = [1.0, 0.0;
                     0.0, 1.0];
            Cc = diag([1,1]);
            Dc = 0;
            sys =ss(Ac,Bc,Cc,Dc);

    %% ���U�n�V�X�e��
            dsys=c2d(sys,Td); % �A���n���痣�U�n�ւ̕ϊ�
            [Ad,Bd,Cd,Dd]=ssdata(dsys);

    end
    

%% �ڕW�o�H
    function [xr,Flag1] = Reference(H, Ur, Y, dT, X_ref)
        % �Q�ƋO�����v�Z����v���O����
        % ���͈���: �z���C�]�� H, �ڕW���� Ur, ���ݎ����œ���ꂽ�ϑ��l Y, ���f���\������̍��ݕ� dT
        xr = ones(2, H).*X_ref;
        Flag1 = 1;
        % �\������X���W��2.5 m�ȏ�ł���Ƃ�Y���W��1 m�ɐݒ�
            for L = 1:H
                xr(:, L) = [Y(1) + Ur(1)*(L-1)*dT; 0.5];
            end
    end
    
    function [xr,Flag2] = Reference2(H, Ur, Y, dT, X_ref)
        % �Q�ƋO�����v�Z����v���O����
        % ���͈���: �z���C�]�� H:Params.H, �ڕW���� Ur:ur, ���ݎ����œ���ꂽ�ϑ��l Y:y, ���f���\������̍��ݕ�
        % dT:Params.dt �����l: X_ref:x0
        xr = ones(2, H).*X_ref;
        Flag2 = 2;
        % �\������X���W��2.5 m�ȏ�ł���Ƃ�Y���W��0 m�ɐݒ�
            for L = 1:H
                if Y(1) + Ur(1)*(L-1)*dT >= 2.5
                    xr(:, L) = [Y(1) + Ur(1)*(L-1)*dT; 0.];
                else
                    xr(:, L) = [Y(1) + Ur(1)*(L-1)*dT; 1.];
                end
            end
    end
    
    
%% �]���֐�
    function [eval] = Objective(x, params) % �l�H�|�e���V������Ȃ�
        % ���f���\������̕]���l���v�Z����v���O����
            total_size = params.state_size + params.input_size;
        %-- MPC�ŗp����\����� X�Ɨ\������ U��ݒ�
            X = x(1:params.state_size, :);
            U = x(params.state_size+1:total_size, :);
            Qapf = params.Weight.Qapf;
        %-- ��ԋy�ѓ��͂ɑ΂���ڕW��Ԃ�ڕW���͂Ƃ̌덷���v�Z
            tildeX = X - params.Xr;
            tildeU = U - params.Ur;
            tildeXo = X - params.Xo;
        %-- ��ԋy�ѓ��͂̃X�e�[�W�R�X�g���v�Z
            stageState = arrayfun(@(L) tildeX(:, L)' * params.Weight.Q * tildeX(:, L), 1:params.H-1);
            stageInput = arrayfun(@(L) tildeU(:, L)' * params.Weight.R * tildeU(:, L), 1:params.H-1);
        %-- ��Ԃ̏I�[�R�X�g���v�Z
            terminalState = tildeX(:, end)' * params.Weight.Qf * tildeX(:, end);
        %-- �]���l�v�Z
            eval = sum(stageState + stageInput) + terminalState;
    end
    
    function [eval] = Objective2(x, params) % �l�H�|�e���V�����ꂠ��
    % ���f���\������̕]���l���v�Z����v���O����
        total_size = params.state_size + params.input_size;
    %-- MPC�ŗp����\����� X�Ɨ\������ U��ݒ�
        X = x(1:params.state_size, :);
        U = x(params.state_size+1:total_size, :);
    %-- ��ԋy�ѓ��͂ɑ΂���ڕW��Ԃ�ڕW���͂Ƃ̌덷���v�Z
        tildeX = X - params.Xr;
        tildeU = U - params.Ur;
        tildeXo = X - params.Xo;
    %-- ��ԋy�ѓ��͂̃X�e�[�W�R�X�g���v�Z
        stageState = arrayfun(@(L) tildeX(:, L)' * params.Weight.Q * tildeX(:, L), 1:params.H-1);
        stageInput = arrayfun(@(L) tildeU(:, L)' * params.Weight.R * tildeU(:, L), 1:params.H-1);
    %-- ��Ԃ̏I�[�R�X�g���v�Z
        terminalState = tildeX(:, end)' * params.Weight.Qf * tildeX(:, end);
    %-- �l�H�|�e���V������
        APF = arrayfun(@(L) params.Weight.Qapf /((tildeXo(1, L))^2+(tildeXo(2, L))^2) , 1:params.H-1);
    %-- �]���l�v�Z
        eval = sum(stageState + stageInput + APF) + terminalState;
end




%% �������
    function [c, ceq] = Constraints(x, params)
        % ���f���\������̐���������v�Z����v���O����
            total_size = params.state_size + params.input_size;
            c  = zeros(params.state_size, 1*params.H);

        %-- MPC�ŗp����\����� X�Ɨ\������ U��ݒ�
            X = x(1:params.state_size, :);
            U = x(params.state_size+1:total_size, :);

        %-- ������Ԃ����ݎ����ƈ�v���邱�ƂƏ�ԕ������ɏ]�����Ƃ�ݒ�@����`�������v�Z���܂��D
            ceq = [X(:, 1) - params.X0, cell2mat(arrayfun(@(L) X(:, L)  - (params.A * X(:, L-1) + params.B * U(:, L-1)), 2:params.H, 'UniformOutput', false))];
            c(1,:) = [];
    end
    
    function [c, ceq] = Constraints2(x, params)
        % ���f���\������̐���������v�Z����v���O����
            total_size = params.state_size + params.input_size;
            c  = zeros(params.state_size, 1*params.H);

        %-- MPC�ŗp����\����� X�Ɨ\������ U��ݒ�
            X = x(1:params.state_size, :);
            U = x(params.state_size+1:total_size, :);

        %-- ������Ԃ����ݎ����ƈ�v���邱�ƂƏ�ԕ������ɏ]�����Ƃ�ݒ�@����`�������v�Z���܂��D
            ceq = [X(:, 1) - params.X0, cell2mat(arrayfun(@(L) X(:, L)  - (params.A * X(:, L-1) + params.B * U(:, L-1)), 2:params.H, 'UniformOutput', false))];
            c(1,:) = arrayfun(@(L) -x(2,L)+0.4, 1:params.H);
    end
%% �����ۑ�
function saveFig(fig,figname)
    set(gca,'Fontsize',14);
    % Black out 
    fig.PaperPositionMode = 'auto';
    fig_pos = fig.PaperPosition;
    fig.PaperSize = [fig_pos(3) fig_pos(4)];
    % save
    print(fig,figname,'-dpdf','-r300','-bestfit');
    exportgraphics(fig,[figname,'.pdf'],'ContentType','vector');
end
function saveFig2eps(fig,figname)
    set(gca,'Fontsize',14);
    % Black out 
    fig = gcf;
    fig.PaperPositionMode = 'auto';
    fig_pos = fig.PaperPosition;
    fig.PaperSize = [fig_pos(3) fig_pos(4)];
    % save
    exportgraphics(fig,[figname,'.eps'],'ContentType','vector');
end
function save_n_move(figNum,figName,folderName)
    %.fig�̕ۑ�
    savefig(figure(figNum),figName); 
    movefile([figName,'.fig'], [folderName, '/.fig']);
    %.pdf�̕ۑ�
    saveFig(figure(figNum),figName); 
    movefile([figName,'.pdf'], [folderName, '/.pdf']);
    % eps�̕ۑ�
    saveFig2eps(figure(figNum),figName);
    movefile([figName,'.eps'], [folderName, '/.eps']); 
end
    