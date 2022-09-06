classdef FTC < CONTROLLER_CLASS
    % �N�A�b�h�R�v�^�[�p�K�w�^���`�����g�������͎Z�o
    properties
        self
        result
        param
        Q
        parameter_name = ["mass","Lx","Ly","lx","ly","jx","jy","jz","gravity","km1","km2","km3","km4","k1","k2","k3","k4"];
        Vf
        Vs
        VfFT
        gain1
        gain2
    end
    
    methods
        function obj = FTC(self,param)
            obj.self = self;
            obj.param = param;
            obj.param.P = self.parameter.get(obj.parameter_name);            
            obj.Q = STATE_CLASS(struct('state_list',["q"],'num_list',[4]));
            obj.Vf = param.Vf; % �K�w�P�̓��͂𐶐�����֐��n���h��
            obj.Vs = param.Vs; % �K�w�Q�̓��͂𐶐�����֐��n���h�� 
            obj.VfFT = param.VfFT;% �K�w�P�̓��͂𐶐�����֐��n���h��FT�p
            obj.gain1 = param.gain1;%tanh1
            obj.gain2 = param.gain2;%tanh2
        end
        
        function result = do(obj,param,~)
            % param (optional) : �\���́F�����p�����[�^P�C�Q�C��F1-F4 
            t = param{1};
            model = obj.self.estimator.result;
            ref = obj.self.reference.result; 
            x = [model.state.getq('compact');model.state.p;model.state.v;model.state.w]; % [q, p, v, w]�ɕ��בւ�
            xd = ref.state.get();
             
            Param= obj.param;
            P = Param.P;
            F1 = Param.F1;
            F2 = Param.F2;
            F3 = Param.F3;
            F4 = Param.F4;
%             kx=[3.16,6.79,40.54,12.27];%�Q�C��
            kx=F2;
%             ky=[3.16,6.79,40.54,12.27];%���param�Ɋi�[
            ky=F3;
%             kz=[2.23,2.28];
            %kz=F1;
%             kpsi=[1.41,1.35];
            kpsi=F4;
%             ax=[0.692,0.75,0.818,0.9];%alpha
%             ay=[0.692,0.75,0.818,0.9];
%             az=[0.692,0.75];
%             apsi=[0.692,0.75];
            ax = Param.ax;
            ay = Param.ay;
            az = Param.az;
            apsi = Param.apsi;
            
            xd=[xd;zeros(20-size(xd,1),1)];% ����Ȃ����͂O�Ŗ��߂�D

            Rb0 = RodriguesQuaternion(Eul2Quat([0;0;xd(4)]));
            x = [R2q(Rb0'*model.state.getq("rotmat"));Rb0'*model.state.p;Rb0'*model.state.v;model.state.w]; % [q, p, v, w]�ɕ��בւ�
            xd(1:3)=Rb0'*xd(1:3);
            xd(4) = 0;
            xd(5:7)=Rb0'*xd(5:7);
            xd(9:11)=Rb0'*xd(9:11);
            xd(13:15)=Rb0'*xd(13:15);
            xd(17:19)=Rb0'*xd(17:19);

            
%% calc Z
            z1 = Z1(x,xd',P);
          %z����:FB
%             vf = obj.Vf(z1,F1);%%%%%%%%%%%%%%%%%%%
          %z����:FT
%             f1=obj.gain2(:,1); 
%             a1=obj.gain2(:,2);
%             f2=obj.gain2(:,3);
%             a2=obj.gain2(:,4);
%             vf = obj.VfFT(f1,a1,f2,a2,,F1,z1);%%%%%%%%%%%%%%%%%%

            f1=obj.gain1(1:2,1)';
            a1=obj.gain1(1:2,2)';
            vf = obj.VfFT(f1,a1,F1,z1);%%%%%%%%%%%%%%%%%%
            %x,y,psi�̏�ԕϐ��̒l
            z2=Z2(x,xd',vf,P);%x����
            z3=Z3(x,xd',vf,P);%y����
            z4=Z4(x,xd',vf,P);%yaw
            %vs = obj.Vs(z2,z3,z4,F2,F3,F4);%%%%%%%%%%%%%%%%%%%
            
%% x,y,psi�̓���
n =1;% 1:�L������ 4:tanh1 5:tanh2
switch n
        case 1
%�L������
% 
            ux=-kx(1)*sign(z2(1))*abs(z2(1))^ax(1)-(kx(2)*sign(z2(2))*abs(z2(2))^ax(2))-(kx(3)*sign(z2(3))*abs(z2(3))^ax(3))-(kx(4)*sign(z2(4))*abs(z2(4))^ax(4));%�i17�j��
            uy=-ky(1)*sign(z3(1))*abs(z3(1))^ay(1)-(ky(2)*sign(z3(2))*abs(z3(2))^ay(2))-(ky(3)*sign(z3(3))*abs(z3(3))^ay(3))-(ky(4)*sign(z3(4))*abs(z3(4))^ay(4));%(19)��       
%             ux=1*ux;
%             uy=1*uy;
%             
            ux=-1*F2*z2;
            uy=-1*F3*z3;
            %���p
%             ux=1*(-kx(1)*sign(z2(1))*abs(z2(1))^ax(1)-(kx(2)*sign(z2(2))*abs(z2(2))^ax(2))-(kx(3)*sign(z2(3))*abs(z2(3))^ax(3))-(kx(4)*sign(z2(4))*abs(z2(4))^ax(4))-F2(1)*z2(1));%�i17�j��
%             uy=1*(-ky(1)*sign(z3(1))*abs(z3(1))^ay(1)-(ky(2)*sign(z3(2))*abs(z3(2))^ay(2))-(ky(3)*sign(z3(3))*abs(z3(3))^ay(3))-(ky(4)*sign(z3(4))*abs(z3(4))^ay(4))-F3(1)*z3(1));%(19)��  
            %�O���_��
%             ux=ux+8*sin(2*pi*t/0.2);%30�ȉ��Ȃ�L�����肪����
%             uy=uy+10*cos(2*pi*t/1);
%             ux=ux+2;
%             if t>=2 && t<=2.1�@
%                     ux=ux+1/0.025;
%             end
        case 2
%�ߎ�1(sgn���ߎ�)
          %           a=6;%a>2,alpha=0.9,a=6�̎����������ɂȂ�.�U���̕񍐉�
%             ux=-kx(1)*tanh(a*z2(1))*abs(z2(1))^ax(1)-(kx(2)*tanh(a*z2(2))*abs(z2(2))^ax(2))-(kx(3)*tanh(a*z2(3))*abs(z2(3))^ax(3))-(kx(4)*tanh(a*z2(4))*abs(z2(4))^ax(4))-F2(1)*z2(1);%-F2*z2;%�i17�j��
%             uy=-ky(1)*tanh(a*z3(1))*abs(z3(1))^ay(1)-(ky(2)*tanh(a*z3(2))*abs(z3(2))^ay(2))-(ky(3)*tanh(a*z3(3))*abs(z3(3))^ay(3))-(ky(4)*tanh(a*z3(4))*abs(z3(4))^ay(4))-F3(1)*z3(1);%-F3*z3;%(19)��          
        case 3
%�ߎ�2(|x|^alpha���ߎ��{���p)
%           a=1.2;%a>1(1����0�̋߂���fb�Ɠ����ɂȂ�)
%             ux=-kx(1)*tanh(a*z2(1))-kx(2)*tanh(a*z2(2))-kx(3)*tanh(a*z2(3))-kx(4)*tanh(a*z2(4))-F2*z2;%F2(1)*z2(1);%�i17�j��
%             uy=-ky(1)*tanh(a*z3(1))-ky(2)*tanh(a*z3(2))-ky(3)*tanh(a*z3(3))-ky(4)*tanh(a*z3(4))-F3*z3;%F3(1)*z3(1);%(19)��          
%             ux=-kx(1)*tanh(a*z2(1))-kx(2)*tanh(a*z2(2))-kx(3)*tanh(a*z2(3))-kx(4)*tanh(a*z2(4))-F2(1)*z2(1);%�i17�j��
%             uy=-ky(1)*tanh(a*z3(1))-ky(2)*tanh(a*z3(2))-ky(3)*tanh(a*z3(3))-ky(4)*tanh(a*z3(4))-F3(1)*z3(1);%(19)��   
        case 4
%�ߎ�3 tanh1
          %�ߎ����ʌ덷0.1x
%             g = [0.105, 0.08, 0.055, 0.028];
%             a = [20, 18, 16, 15];
%             f= F2.*g;%F3.*g�������l
          %�ߎ�Fb�Ƃ̓��͌덷����ԑ傫���Ȃ�Ƃ���[0.3, 0.3160, 0.3320, 0.3490]�ł̋ߎ�x
    %         g = [0.135, 0.105, 0.075, 0.035];
    %         a = [9.5, 9, 9.5, 9.5];
          %�ŏ����ŋ��߂�
            f=obj.gain1(:,1);
            a=obj.gain1(:,2);

            ux=-f(1)*tanh(a(1)*z2(1))-f(2)*tanh(a(2)*z2(2))-f(3)*tanh(a(3)*z2(3))-f(4)*tanh(a(4)*z2(4))-F2*z2;%-F2*z2;%�i17�j��
            uy=-f(1)*tanh(a(1)*z3(1))-f(2)*tanh(a(2)*z3(2))-f(3)*tanh(a(3)*z3(3))-f(4)*tanh(a(4)*z3(4))-F3*z3;%-F2*z2;%�i17�j��
            %-F3*z3;%(19)��
        case 5
% �ߎ�4tanh2
            f1=obj.gain2(:,1);
            a1=obj.gain2(:,2);
            f2=obj.gain2(:,3);
            a2=obj.gain2(:,4);
            ux= -f1(1)*tanh(a1(1)*z2(1))-f2(1)*tanh(a2(1)*z2(1)) -f1(2)*tanh(a1(2)*z2(2))-f2(2)*tanh(a2(2)*z2(2)) -f1(3)*tanh(a1(3)*z2(3))-f2(3)*tanh(a2(3)*z2(3)) -f1(4)*tanh(a1(4)*z2(4))-f2(4)*tanh(a2(4)*z2(4))-F2*z2;%-F2*z2;%�i17�j��
            uy= -f1(1)*tanh(a1(1)*z3(1))-f2(1)*tanh(a2(1)*z3(1)) -f1(2)*tanh(a1(2)*z3(2))-f2(2)*tanh(a2(2)*z3(2)) -f1(3)*tanh(a1(3)*z3(3))-f2(3)*tanh(a2(3)*z3(3)) -f1(4)*tanh(a1(4)*z3(4))-f2(4)*tanh(a2(4)*z3(4))-F3*z3;%-F3*z3;%�i17�j��
end
%upsi:HL or FT
            upsi=-F4*z4;%HL
%             upsi=-kpsi(1)*sign(z4(1))*abs(z4(1))^apsi(1)-kpsi(2)*sign(z4(1))*abs(z4(1))^apsi(2);%F4*Z4;%����͂����()%FT
%
%% �O��(�����x�ŗ^����)
            dst = 0.0;
%             dst_y = 0;
%             dst_z=0;
%             dst=0.5*sin(2*pi*t/0.5);%
%             dst=dst+10*cos(2*pi*t/1);
%             dst=2;
            if t>=5 && t<=5.025
                    dst=1/0.025;
            end
%%            
            vs =[ux,uy,upsi];
            tmp = Uf(x,xd',vf,P) + Us(x,xd',vf,vs',P);
            obj.result.input = [tmp(1);tmp(2);tmp(3);tmp(4);dst];
%             ob j.result.input = [tmp(1);tmp(2);tmp(3);tmp(4)];
            obj.self.input = obj.result.input;
            %�T�u�V�X�e���̓���
            obj.result.uHL = [vf(1);ux;uy;upsi];
            %�T�u�V�X�e���̏��
            obj.result.z1 = z1;
            obj.result.z2 = z2;
            obj.result.z3 = z3;
            obj.result.z4 = z4;
            result = obj.result;
        end
        function show(obj)
            obj.result
        end
    end
end

