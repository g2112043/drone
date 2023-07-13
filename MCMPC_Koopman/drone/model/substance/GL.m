function dxg = GL(in1,in2)
%GL
%    DXG = GL(IN1,IN2)

%    This function was generated by the Symbolic Math Toolbox version 8.3.
%    22-Jul-2020 16:31:44

Length = in2(:,16);
jx = in2(:,3);
jy = in2(:,4);
jz = in2(:,5);
m = in2(:,1);
mL = in2(:,15);
ol1 = in1(17,:);
ol2 = in1(18,:);
ol3 = in1(19,:);
pT1 = in1(14,:);
pT2 = in1(15,:);
pT3 = in1(16,:);
q0 = in1(1,:);
q1 = in1(2,:);
q2 = in1(3,:);
q3 = in1(4,:);
t2 = m+mL;
t3 = ol1.*pT2;
t4 = ol2.*pT1;
t5 = ol1.*pT3;
t6 = ol3.*pT1;
t7 = ol2.*pT3;
t8 = ol3.*pT2;
t9 = q0.^2;
t10 = q1.^2;
t11 = q2.^2;
t12 = q3.^2;
t13 = q0.*q1.*2.0;
t14 = q0.*q2.*2.0;
t15 = q1.*q3.*2.0;
t16 = q2.*q3.*2.0;
t17 = 1.0./Length;
t18 = 1.0./m;
t19 = -t4;
t20 = -t6;
t21 = -t8;
t22 = -t16;
t23 = -t10;
t24 = -t11;
t25 = 1.0./t2;
t29 = t14+t15;
t26 = t3+t19;
t27 = t5+t20;
t28 = t7+t21;
t30 = t13+t22;
t34 = pT1.*t29;
t37 = t9+t12+t23+t24;
t31 = t26.^2;
t32 = t27.^2;
t33 = t28.^2;
t35 = pT2.*t30;
t38 = pT3.*t37;
t36 = -t35;
t39 = t31+t32+t33;
t40 = Length.*m.*t39;
t41 = -t40;
t42 = t34+t36+t38+t41;
dxg = reshape([0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,pT1.*t25.*t40+pT1.*t25.*t42,pT2.*t25.*t40+pT2.*t25.*t42,pT3.*t25.*t40+pT3.*t25.*t42,0.0,0.0,0.0,-t17.*t18.*(pT3.*t30+pT2.*t37),-t17.*t18.*(pT3.*t29-pT1.*t37),t17.*t18.*(pT1.*t30+pT2.*t29),0.0,0.0,0.0,0.0,1.0./jx,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0./jy,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0./jz,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0],[19,4]);
