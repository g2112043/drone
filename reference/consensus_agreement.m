function [tc2,xc2,uc2] = consensus_agreement(t0,t1,x0)
    disp("NowSimulating");
    tc2 = t0;
    xc2 = x0;
    uc2 = situation.u_hold;
    
    %------------------------�v�Z-------------------------
    for t = t0 : +situation.h : t1
        %���͒l�̌v�Z
%   �e�G�[�W�F���g�ւ̓��͒l���v�Z

    %-------�V�~�����[�V�����̐i�݋��\��--------
    if rem(t,1) < 1.e-3  
        disp('.') 
    end	
   
    %�I�t�Z�b�g������ꍇ�̓R�����g�A�E�g���O��
%     X = X+situation.offset;
    
    %---------------���͂̎Z�o------------------
    %���Ӑ���:ui=-k((xi-oi)-(xj-oj))
    k=0.3;
    Ux = -k * situation.L * X(1:4:4*situation.AgentNumber) - X(2:4:4*situation.AgentNumber);
    Uy = -k * situation.L * X(3:4:4*situation.AgentNumber) - X(4:4:4*situation.AgentNumber);
%     Ux(1)=-k*(X(1)-7);
%     Uy(1)=-k*(X(3)-8);
    U = [Ux,Uy];

         U = link_eqs(t,x0);
         sol = ode45(@(t,X) diff_eqs(t,X,U),[t,t+situation.h],x0);

         tc = linspace(t,t+situation.h,100);
         xc = deval(tc,sol);
         uc = repmat(U,1,100);


    %--------------TC,XC,UC�̍s����\��--------------
         tc2 = [tc2,tc(:,end)];
         xc2 = [xc2,xc(:,end)];
         uc2 = [uc2,uc(:,end)];
     
    %--------------�G�[�W�F���g�̏�Ԃ̍X�V-------------
         x0 = xc(:,end);

    end
end