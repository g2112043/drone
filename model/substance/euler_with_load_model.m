function dx = euler_with_load_model(in1,in2,in3)
%EULER_WITH_LOAD_MODEL
%    DX = EULER_WITH_LOAD_MODEL(IN1,IN2,IN3)

%    This function was generated by the Symbolic Math Toolbox version 8.6.
%    08-Mar-2021 19:14:37

Length = in3(:,16);
dp1 = in1(7,:);
dp2 = in1(8,:);
dp3 = in1(9,:);
dpl1 = in1(16,:);
dpl2 = in1(17,:);
dpl3 = in1(18,:);
ex = in3(:,17);
ey = in3(:,18);
ez = in3(:,19);
gravity = in3(:,6);
jx = in3(:,3);
jy = in3(:,4);
jz = in3(:,5);
m = in3(:,1);
mL = in3(:,15);
o1 = in1(10,:);
o2 = in1(11,:);
o3 = in1(12,:);
ol1 = in1(22,:);
ol2 = in1(23,:);
ol3 = in1(24,:);
pT1 = in1(19,:);
pT2 = in1(20,:);
pT3 = in1(21,:);
pitch = in1(5,:);
roll = in1(4,:);
u1 = in2(1,:);
u2 = in2(2,:);
u3 = in2(3,:);
u4 = in2(4,:);
yaw = in1(6,:);
t2 = cos(pitch);
t3 = cos(roll);
t4 = sin(pitch);
t5 = sin(roll);
t6 = m+mL;
t7 = ol1.*pT2;
t8 = ol2.*pT1;
t9 = ol1.*pT3;
t10 = ol3.*pT1;
t11 = ol2.*pT3;
t12 = ol3.*pT2;
t13 = 1.0./Length;
t14 = -gravity;
t15 = 1.0./jx;
t16 = 1.0./jy;
t17 = 1.0./jz;
t18 = 1.0./m;
t23 = pitch./2.0;
t24 = roll./2.0;
t25 = yaw./2.0;
t19 = 1.0./t2;
t20 = -t8;
t21 = -t10;
t22 = -t12;
t26 = cos(t23);
t27 = cos(t24);
t28 = cos(t25);
t29 = sin(t23);
t30 = sin(t24);
t31 = sin(t25);
t32 = 1.0./t6;
t33 = t7+t20;
t34 = t9+t21;
t35 = t11+t22;
t39 = t26.*t27.*t28;
t40 = t26.*t27.*t31;
t41 = t26.*t28.*t30;
t42 = t27.*t28.*t29;
t43 = t26.*t30.*t31;
t44 = t27.*t29.*t31;
t45 = t28.*t29.*t30;
t46 = t29.*t30.*t31;
t36 = t33.^2;
t37 = t34.^2;
t38 = t35.^2;
t47 = -t44;
t48 = -t45;
t51 = t39+t46;
t52 = t42+t43;
t49 = t36+t37+t38;
t53 = t40+t48;
t54 = t41+t47;
t55 = t51.^2;
t56 = t52.^2;
t62 = t51.*t52.*2.0;
t50 = Length.*m.*t49;
t57 = t53.^2;
t58 = t54.^2;
t59 = -t56;
t63 = t51.*t53.*2.0;
t64 = t51.*t54.*2.0;
t65 = t52.*t53.*2.0;
t66 = t52.*t54.*2.0;
t69 = t53.*t54.*2.0;
t60 = -t57;
t61 = -t58;
t67 = -t65;
t68 = -t66;
t70 = -t69;
t71 = t62+t69;
t72 = t63+t66;
t73 = t64+t65;
t74 = t62+t70;
t75 = t63+t68;
t76 = t64+t67;
t77 = ex.*t72;
t78 = ey.*t73;
t79 = ez.*t71;
t83 = pT1.*t71.*u1;
t84 = pT2.*t71.*u1;
t85 = pT3.*t71.*u1;
t92 = t55+t58+t59+t60;
t93 = t55+t57+t59+t61;
t94 = t55+t56+t60+t61;
t80 = ex.*t74;
t81 = ey.*t75;
t82 = ez.*t76;
t86 = -t78;
t87 = pT1.*t76.*u1;
t88 = pT2.*t76.*u1;
t89 = pT3.*t76.*u1;
t90 = -t83;
t91 = -t85;
t95 = ex.*t92;
t96 = ey.*t94;
t97 = ez.*t93;
t98 = pT1.*t93.*u1;
t99 = pT2.*t93.*u1;
t100 = pT3.*t93.*u1;
t101 = -t95;
t102 = -t100;
t103 = t84+t87;
t104 = t89+t99;
t105 = t91+t98;
t106 = t77+t82+t96;
t107 = t80+t86+t97;
t108 = t79+t81+t101;
t109 = t50+t88+t90+t102;
t110 = pT1.*t32.*t109;
t111 = pT2.*t32.*t109;
t112 = pT3.*t32.*t109;
t113 = -t110;
t114 = -t111;
t115 = -t112;
dx = [dp1;dp2;dp3;t19.*(o1.*t2+o3.*t3.*t4+o2.*t4.*t5);o2.*t3-o3.*t5;t19.*(o3.*t3+o2.*t5);t113-Length.*(ol2.*t33+ol3.*t34-pT2.*t13.*t18.*t103-pT3.*t13.*t18.*(t85-t98));t114-Length.*(-ol1.*t33+ol3.*t35+pT1.*t13.*t18.*t103+pT3.*t13.*t18.*t104);t14+t115+Length.*(ol1.*t34+ol2.*t35+pT2.*t13.*t18.*t104-pT1.*t13.*t18.*(t85-t98));t15.*u2+t15.*(jy.*o2.*o3-jz.*o2.*o3)+t15.*(mL.*t106.*t112+mL.*t107.*t111);t16.*u3-t16.*(jx.*o1.*o3-jz.*o1.*o3)-t16.*(mL.*t107.*t110+mL.*t108.*t115);t17.*u4+t17.*(jx.*o1.*o2-jy.*o1.*o2)-t17.*(mL.*t106.*t110+mL.*t108.*t111);dpl1;dpl2;dpl3;t113;t114;t14+t115;t35;-t9+t10;t33;-t13.*t18.*t104;-t13.*t18.*(t85-t98);t13.*t18.*t103];
