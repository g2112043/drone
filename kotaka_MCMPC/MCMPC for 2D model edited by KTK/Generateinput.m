% Particle_num = 1000;
% x0 = [0.5; 0.; 0; 0];
xinit = [0.5; 0.; 0; 0];
% % sigma = repmat(0.2, 1, Particle_num);
% sigmav = repmat(0.1, 1,Particle_num); %���̕��U�l
% Csigma = 0.001;%�@���Ԃ��Ƃɕω����镪�U�l�̏㏸�萔

sigma_cnt = 1: Params.H;
if Count_sigma == 0 || Count_sigma ==1
    sigma = repmat(0.3+Csigma*(sigma_cnt-1), Particle_num, 1)';%���U�l�i�[
    
else
    
     sigma = repmat(sigmanext+Csigma*(sigma_cnt-1), Particle_num, 1)';

end
% ux_ten = repmat(0.05,Params.H, Particle_num);
uy_ten = repmat(0.05,Params.H, Particle_num); %���肵�����͂�u��
%%
testn = normrnd(zeros(Params.H,Particle_num),sigma);

%%
mu = zeros(Params.H, Particle_num);
mu_v = zeros(Params.H, Particle_num);

% ���U�ɂ��m�C�Y���i�[
n = normrnd(zeros(Params.H,Particle_num),sigma);

% �e�����̓��͗���i�[
ux = repmat(0.3, Params.H, Particle_num);
uy = uy_ten+n;
ux = reshape(ux, [1,size(ux)]);
uy = reshape(uy, [1,size(uy)]);
u1 = [ux;uy];

%% �f�[�^�i�[�ϐ�
x_data = zeros(Params.H, Particle_num);
x_data = reshape(x_data,[1,size(x_data)]);

y_data = zeros(Params.H, Particle_num);
y_data = reshape(y_data,[1,size(y_data)]);

vx_data = zeros(Params.H, Particle_num);
vx_data = reshape(vx_data,[1,size(vx_data)]);

vy_data = zeros(Params.H, Particle_num);
vy_data = reshape(vy_data,[1,size(vy_data)]);

state_data = [x_data; y_data; vx_data; vy_data];
%% ��ԍX�V�@�O���v�Z
for i=1:Particle_num
    x0 = [0.5; 0.; 0; 0];
    for j=1 : Params.H
        x1 = Params.A*x0 + Params.B * u1(:, j, i);
        y = Params.C*x1;
        x0 = y;
        state_data(:, j, i) = x0;
    end
    disp('finish trajectory generate');
end

%% �]���l�v�Z
%�ڕW�O������(�f�o�b�N�p)
xr = Reference2(Params.H, xinit, Params.dt);
Params.Xr = xr; 

%�]���l�v�Z
Evaluationtra = zeros(1, Particle_num);
for i=1:Particle_num
    eve = EvaluationFunction(state_data(:, :, i),u1(:, :, i),Params);
    Evaluationtra(1,i) = eve;
      
    disp('finish trajectory generate');
end

[Bestcost, BestcostID]=min(Evaluationtra); %�ŏ��]���l���Z�o
% Evaluationtra(BestcostID);
Normalize(Params,Evaluationtra)

%% �\���O���̓��͊i�[,�������̕��U����
unow = u1(:,:,BestcostID);  
sigmanext = sigma(1,1)*(Bestcost/(Bestcost*1.5));
%% Plot
figure(1)
fig = gcf;
fig.Color= [1., 1., 1.];
hold on;
for i=1:Particle_num
    plot(state_data(1,:,i),state_data(2,:,i),'-','LineWidth',1.75);
    % plot(data.state(:,6),data.state(:,7),'-','LineWidth',1.75);
    hold on;
end
grid on; axis equal; hold off; box on;
set(gca,'FontSize',16);
ylabel('$$Y$$ [m]', 'Interpreter', 'latex')
xlabel('$$X$$ [m]', 'Interpreter', 'latex')
xlim([0.5, 1.5]);

figure(2)
fig = gcf;
fig.Color= [1., 1., 1.];
hold on;
for i=1:10
    plot(state_data(1,:,i),state_data(2,:,i),'-','LineWidth',1.75);
    % plot(data.state(:,6),data.state(:,7),'-','LineWidth',1.75);
    hold on;
end
grid on; axis equal; hold off; box on;
set(gca,'FontSize',16);
ylabel('$$Y$$ [m]', 'Interpreter', 'latex')
xlabel('$$X$$ [m]', 'Interpreter', 'latex')
xlim([0.5, 1.5]);

figure(3)
fig = gcf;
fig.Color= [1., 1., 1.];
hold on;
plot(state_data(1,:,BestcostID),state_data(2,:,BestcostID),'-','LineWidth',1.75);
    % plot(data.state(:,6),data.state(:,7),'-','LineWidth',1.75);
hold off;
grid on; axis equal; hold off; box on;
set(gca,'FontSize',16);
ylabel('$$Y$$ [m]', 'Interpreter', 'latex')
xlabel('$$X$$ [m]', 'Interpreter', 'latex')
xlim([0.5, 1.5]);


%%







