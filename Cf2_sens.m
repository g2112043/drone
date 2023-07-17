function Cf12 = Cf2_sens(in1,in2,y,y2,in5)
%Cf2_sens
%    Cf12 = Cf2_sens(IN1,IN2,Y,Y2,IN5)

%    This function was generated by the Symbolic Math Toolbox version 9.3.
%    2023/07/17 14:17:01

R_num1_1 = in5(1);
R_num2_1 = in5(2);
R_num3_1 = in5(3);
p1 = in1(1,:);
p2 = in1(2,:);
p3 = in1(3,:);
qb1 = in2(1,:);
qb2 = in2(2,:);
qb3 = in2(3,:);
qb4 = in2(4,:);
t2 = qb1.*qb2;
t3 = qb1.*qb3;
t4 = qb1.*qb4;
t5 = qb2.*qb3;
t6 = qb2.*qb4;
t7 = qb3.*qb4;
t8 = qb1.^2;
t9 = qb2.^2;
t10 = qb3.^2;
t11 = qb4.^2;
t12 = t2.*2.0;
t13 = t3.*2.0;
t14 = t4.*2.0;
t15 = t5.*2.0;
t16 = t6.*2.0;
t17 = t7.*2.0;
t20 = -t5;
t22 = -t6;
t23 = -t7;
t24 = -t9;
t25 = -t10;
t26 = -t11;
t27 = t2+t7;
t28 = t3+t6;
t29 = t4+t5;
t18 = -t12;
t19 = -t13;
t21 = -t14;
t30 = t2+t23;
t31 = t3+t22;
t32 = t4+t20;
t33 = t12+t17;
t34 = t13+t16;
t35 = t14+t15;
t39 = t8+t11+t24+t25;
t40 = t8+t10+t24+t26;
t41 = t8+t9+t25+t26;
t36 = t17+t18;
t37 = t16+t19;
t38 = t15+t21;
mt1 = [p1,p1,p2,p2,p3,p3,t41,t41,t38,t38,t34,t34,t35,t35,t40,t40,t36,t36,t37,t37,t33,t33,t39,t39,t41.*y,R_num1_1.*t41.*y2,t32.*y.*-2.0,R_num1_1.*t32.*y2.*-2.0,t28.*y.*2.0,R_num1_1.*t28.*y2.*2.0,0.0,R_num2_1.*t41.*y2,0.0,R_num2_1.*t32.*y2.*-2.0,0.0,R_num2_1.*t28.*y2.*2.0,0.0,R_num3_1.*t41.*y2,0.0,R_num3_1.*t32.*y2.*-2.0,0.0,R_num3_1.*t28.*y2.*2.0,t29.*y.*2.0,R_num1_1.*t29.*y2.*2.0,t40.*y,R_num1_1.*t40.*y2,t30.*y.*-2.0,R_num1_1.*t30.*y2.*-2.0,0.0,R_num2_1.*t29.*y2.*2.0,0.0,R_num2_1.*t40.*y2,0.0,R_num2_1.*t30.*y2.*-2.0,0.0,R_num3_1.*t29.*y2.*2.0,0.0,R_num3_1.*t40.*y2,0.0,R_num3_1.*t30.*y2.*-2.0,t31.*y.*-2.0,R_num1_1.*t31.*y2.*-2.0,t27.*y.*2.0,R_num1_1.*t27.*y2.*2.0,t39.*y,R_num1_1.*t39.*y2,0.0,R_num2_1.*t31.*y2.*-2.0,0.0,R_num2_1.*t27.*y2.*2.0,0.0,R_num2_1.*t39.*y2,0.0];
mt2 = [R_num3_1.*t31.*y2.*-2.0,0.0,R_num3_1.*t27.*y2.*2.0,0.0,R_num3_1.*t39.*y2];
Cf12 = reshape([mt1,mt2],2,39);
end
