function yh = H_18_2(in1,in2,dummy)
%H_18_2
%    YH = H_18_2(IN1,IN2,DUMMY)

%    This function was generated by the Symbolic Math Toolbox version 9.3.
%    2023/08/29 17:52:06

a = in2(:,1);
b = in2(:,2);
c = in2(:,3);
d = in2(:,4);
x1 = in1(1,:);
x2 = in1(2,:);
x3 = in1(3,:);
x4 = in1(4,:);
x5 = in1(5,:);
x6 = in1(6,:);
x13 = in1(13,:);
x14 = in1(14,:);
x15 = in1(15,:);
x16 = in1(16,:);
x17 = in1(17,:);
x18 = in1(18,:);
t2 = x4./2.0;
t3 = x5./2.0;
t4 = x6./2.0;
t5 = x16./2.0;
t6 = x17./2.0;
t7 = x18./2.0;
t8 = cos(t2);
t9 = cos(t3);
t10 = cos(t4);
t11 = cos(t5);
t12 = cos(t6);
t13 = cos(t7);
t14 = sin(t2);
t15 = sin(t3);
t16 = sin(t4);
t17 = sin(t5);
t18 = sin(t6);
t19 = sin(t7);
t20 = t8.*t9.*t10;
t21 = t11.*t12.*t13;
t22 = t8.*t9.*t16;
t23 = t8.*t10.*t15;
t24 = t9.*t10.*t14;
t25 = t11.*t12.*t19;
t26 = t11.*t13.*t18;
t27 = t12.*t13.*t17;
t28 = t8.*t15.*t16;
t29 = t9.*t14.*t16;
t30 = t10.*t14.*t15;
t31 = t11.*t18.*t19;
t32 = t12.*t17.*t19;
t33 = t13.*t17.*t18;
t34 = t14.*t15.*t16;
t35 = t17.*t18.*t19;
t36 = -t28;
t37 = -t30;
t38 = -t31;
t39 = -t33;
t40 = t20+t34;
t41 = t23+t29;
t42 = t21+t35;
t43 = t26+t32;
t44 = t40.^2;
t45 = t41.^2;
t46 = t42.^2;
t47 = t43.^2;
t48 = t22+t37;
t49 = t24+t36;
t50 = t25+t39;
t51 = t27+t38;
t52 = t48.^2;
t53 = t49.^2;
t54 = t50.^2;
t55 = t51.^2;
t56 = t44+t45+t52+t53;
t57 = t46+t47+t54+t55;
t58 = 1.0./t56;
t59 = 1.0./t57;
t60 = t44.*t58;
t61 = t45.*t58;
t62 = t46.*t59;
t63 = t47.*t59;
t64 = t52.*t58;
t65 = t53.*t58;
t67 = t54.*t59;
t68 = t55.*t59;
t74 = t40.*t41.*t58.*2.0;
t75 = t42.*t43.*t59.*2.0;
t76 = t40.*t48.*t58.*2.0;
t77 = t40.*t49.*t58.*2.0;
t78 = t41.*t48.*t58.*2.0;
t79 = t41.*t49.*t58.*2.0;
t80 = t42.*t50.*t59.*2.0;
t81 = t42.*t51.*t59.*2.0;
t82 = t43.*t50.*t59.*2.0;
t83 = t43.*t51.*t59.*2.0;
t87 = t48.*t49.*t58.*2.0;
t88 = t50.*t51.*t59.*2.0;
t66 = -t61;
t69 = -t63;
t70 = -t64;
t71 = -t65;
t72 = -t67;
t73 = -t68;
t84 = -t78;
t85 = -t79;
t86 = -t83;
t89 = -t87;
t90 = -t88;
t91 = t74+t87;
t92 = t76+t79;
t93 = t77+t78;
t94 = t80+t83;
t95 = t81+t82;
t96 = t74+t89;
t97 = t76+t85;
t98 = t77+t84;
t99 = t75+t90;
t100 = t80+t86;
t101 = t92.*x13;
t102 = t93.*x14;
t103 = t91.*x15;
t110 = t60+t61+t70+t71;
t111 = t60+t64+t66+t71;
t112 = t60+t65+t66+t70;
t113 = t62+t63+t72+t73;
t114 = t62+t68+t69+t72;
t104 = t96.*x13;
t105 = t97.*x14;
t106 = t98.*x15;
t115 = t112.*x13;
t116 = t110.*x14;
t117 = t111.*x15;
t107 = -t104;
t108 = -t105;
t109 = -t106;
t118 = t103+t108+t115+x1;
t119 = t101+t109+t116+x2;
t120 = t102+t107+t117+x3;
t121 = a.*t118;
t122 = b.*t119;
t123 = c.*t120;
t124 = d+t121+t122+t123;
et1 = t91.*t95.*(-3.489949670250097e-2)+t91.*t99.*9.993908270190958e-1+t94.*t97.*9.993908270190958e-1+t97.*t113.*3.489949670250097e-2+t100.*t112.*3.489949670250097e-2;
et2 = t112.*t114.*(-9.993908270190958e-1);
et3 = t92.*t100.*(-3.489949670250097e-2)-t95.*t98.*3.489949670250097e-2+t98.*t99.*9.993908270190958e-1+t94.*t110.*9.993908270190958e-1+t92.*t114.*9.993908270190958e-1;
et4 = t110.*t113.*3.489949670250097e-2;
et5 = t93.*t94.*9.993908270190958e-1+t96.*t100.*3.489949670250097e-2+t93.*t113.*3.489949670250097e-2+t95.*t111.*3.489949670250097e-2-t96.*t114.*9.993908270190958e-1;
et6 = t99.*t111.*(-9.993908270190958e-1);
yh = [x1;x2;x3;x4;x5;x6;t124./(a.*(t91.*t99+t94.*t97-t112.*t114)-b.*(t98.*t99+t94.*t110+t92.*t114)+c.*(-t93.*t94+t96.*t114+t99.*t111));-t124./(-a.*(et1+et2)+b.*(et3+et4)+c.*(et5+et6))];
end
