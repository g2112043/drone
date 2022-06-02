function Controller  = Controller_FT(dt)
%% controller class demo (1) : construct
% controller property ��Controller class�̃C���X�^���X�z��Ƃ��Ē�`
% % Controller_param.F1=lqrd([0 1;0 0],[0;1],diag([10,1]),[1],dt);                                % z 
% Controller_param.F2=lqrd([0 1 0 0;0 0 1 0;0 0 0 1; 0 0 0 0],[0;0;0;1],diag([1000,10,10,1]),[1],dt); % xdiag([100,10,10,1])
% Controller_param.F3=lqrd([0 1 0 0;0 0 1 0;0 0 0 1; 0 0 0 0],[0;0;0;1],diag([1000,10,10,1]),[1],dt); % ydiag([100,10,10,1])
% % Controller_param.F4=lqrd([0 1;0 0],[0;1],diag([100,1]),[1],dt);                       % ���[�p 
% Controller_param.F1=lqrd([0 1;0 0],[0;1],diag([10,1]),[1],dt);                                % z 
% Controller_param.F2=lqrd([0 1 0 0;0 0 1 0;0 0 0 1; 0 0 0 0],[0;0;0;1],diag([1000,10,10,1]),[0.8],dt); % xdiag([100,10,10,1])
% Controller_param.F3=lqrd([0 1 0 0;0 0 1 0;0 0 0 1; 0 0 0 0],[0;0;0;1],diag([1000,10,10,1]),[0.8],dt); % ydiag([100,10,10,1])
% Controller_param.F4=lqrd([0 1;0 0],[0;1],diag([100,1]),[1],dt);% ���[�p 
%% �Č�����
Controller_param.F1=lqrd([0 1;0 0],[0;1],diag([10,1]),[0.1],dt);                                % z 
Controller_param.F2=lqrd([0 1 0 0;0 0 1 0;0 0 0 1; 0 0 0 0],[0;0;0;1],diag([100,10,10,10]),[0.1],dt); % xdiag([100,10,10,1])
Controller_param.F3=lqrd([0 1 0 0;0 0 1 0;0 0 0 1; 0 0 0 0],[0;0;0;1],diag([100,10,10,10]),[0.1],dt); % ydiag([100,10,10,1])
Controller_param.F4=lqrd([0 1;0 0],[0;1],diag([10,10]),[0.1],dt); 
% �ɔz�u
Eig=[-3.2,-2,-2.5,-2.1];
% Controller_param.F1=lqrd([0 1;0 0],[0;1],diag([10,1]),[1],dt);                                % z 
% % Controller_param.F2=place(diag([1,1,1],1),[0;0;0;1],Eig);
% % Controller_param.F3=place(diag([1,1,1],1),[0;0;0;1],Eig);
% Controller_param.F4=lqrd([0 1;0 0],[0;1],diag([100,1]),[1],dt);                       % ���[�p 

% ���͂�alpha���v�Z

anum=4;%�ϐ��̐�
alpha=zeros(anum+1,1);
alpha(anum+1)=1;
alpha(anum)=0.7;%alpha�̏����l

for a=anum-1:-1:1
    alpha(a)=(alpha(a+2)*alpha(a+1))/(2*alpha(a+2)-alpha(a+1));
end

Controller_param.ax=alpha;
Controller_param.ay=alpha;
% Controller_param.az=alpha(anum-1:anum,1);
% Controller_param.apsi=alpha(anum-1:anum,1);
%masui
Controller_param.az=alpha(1:2,1);
Controller_param.apsi=alpha(1:2,1);

Controller_param.dt = dt;
 eig(diag([1,1,1],1)-[0;0;0;1]*Controller_param.F2)
Controller.type="FTController_quadcopter";
Controller.name="ftcontroller";
Controller.param=Controller_param;

%assignin('base',"Controller_param",Controller_param);

end
