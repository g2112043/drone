function dx = roll_pitch_yaw_thrust_force_physical_parameter_model(in1,in2,in3)
%ROLL_PITCH_YAW_THRUST_FORCE_PHYSICAL_PARAMETER_MODEL
%    DX = ROLL_PITCH_YAW_THRUST_FORCE_PHYSICAL_PARAMETER_MODEL(IN1,IN2,IN3)

%    This function was generated by the Symbolic Math Toolbox version 9.1.
%    30-May-2022 21:26:34

Lx = in3(:,2);%
Ly = in3(:,3);%
dp1 = in1(7,:);%
dp2 = in1(8,:);%
dp3 = in1(9,:);%
gravity = in3(:,9);%
jx = in3(:,6);%
jy = in3(:,7);%
jz = in3(:,8);%
km1 = in3(:,10);%
km2 = in3(:,11);%
km3 = in3(:,12);%
km4 = in3(:,13);%
lx = in3(:,4);%
ly = in3(:,5);%
m = in3(:,1);%
o1 = in1(10,:);%
o2 = in1(11,:);%
o3 = in1(12,:);%
pitch = in1(5,:);%
roll = in1(4,:);%
u1 = in2(1,:);%
u2 = in2(2,:);%
u3 = in2(3,:);%
u4 = in2(4,:);%
yaw = in1(6,:);%
t2 = cos(pitch);%
t3 = cos(roll);%
t4 = sin(pitch);%
t5 = sin(roll);%
t6 = 1.0./jx;%
t7 = 1.0./jy;%
t8 = 1.0./jz;%
t9 = -lx;%
t10 = -ly;%
t11 = 1.0./m;%
t13 = pitch./2.0;%
t14 = roll./2.0;%
t15 = yaw./2.0;%
t12 = 1.0./t2;%
t16 = cos(t13);%
t17 = cos(t14);%
t18 = cos(t15);%
t19 = sin(t13);%
t20 = sin(t14);%
t21 = sin(t15);%
t22 = Lx+t9;%
t23 = Ly+t10;%
t24 = t16.*t17.*t18;
t25 = t16.*t17.*t21;
t26 = t16.*t18.*t20;
t27 = t17.*t18.*t19;
t28 = t16.*t20.*t21;
t29 = t17.*t19.*t21;
t30 = t18.*t19.*t20;
t31 = t19.*t20.*t21;
t32 = -t29;
t33 = -t30;
t34 = t24+t31;
t35 = t27+t28;
t36 = t25+t33;
t37 = t26+t32;
t38 = t34.*t35.*2.0;
t39 = t34.*t37.*2.0;
t40 = t35.*t36.*2.0;
t42 = t36.*t37.*2.0;
t41 = -t40;
t43 = t38+t42;
t44 = t39+t41;
mt1 = [dp1;dp2;dp3;t12.*(o1.*t2+o3.*t3.*t4+o2.*t4.*t5);o2.*t3-o3.*t5;t12.*(o3.*t3+o2.*t5);t11.*t43.*u1+t11.*t43.*u2+t11.*t43.*u3+t11.*t43.*u4;-t11.*t44.*u1-t11.*t44.*u2-t11.*t44.*u3-t11.*t44.*u4;-gravity+t2.*t3.*t11.*u1+t2.*t3.*t11.*u2+t2.*t3.*t11.*u3+t2.*t3.*t11.*u4;t6.*(jy.*o2.*o3-jz.*o2.*o3)+t6.*t10.*u1+t6.*t10.*u2+t6.*t23.*u3+t6.*t23.*u4;-t7.*(jx.*o1.*o3-jz.*o1.*o3)+lx.*t7.*u1+lx.*t7.*u3-t7.*t22.*u2-t7.*t22.*u4];
mt2 = t8.*(jx.*o1.*o2-jy.*o1.*o2)+km1.*t8.*u1-km2.*t8.*u2-km3.*t8.*u3+km4.*t8.*u4;
% subsIn1 = [0 0 1 0 0 0 0 0 0 0 0 0]';
% subsIn2 = [0.269 * 9.81 / 4 0.269 * 9.81 / 4 0.269 * 9.81 / 4 0.269 * 9.81 / 4]';

% taylor(f(1), 'Order', 3)

dx = [mt1; mt2];
%% 近似線形化
%-- 平衡点/ X = 0 0 0 0 0 0 0 0 0 0 0 0, u = 0＊４
%-- 状態：p   q   v   w
%--      123 456 789 10,11,12
%--       rollとか dp   o

    
