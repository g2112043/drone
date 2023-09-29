function out1 = Jacobian_Suspended_Load_Fujii(in1,in2)
%Jacobian_Suspended_Load_Fujii
%    OUT1 = Jacobian_Suspended_Load_Fujii(IN1,IN2)

%    This function was generated by the Symbolic Math Toolbox version 9.1.
%    29-Sep-2023 17:37:50

p1 = in2(:,1);
p3 = in2(:,3);
p4 = in2(:,4);
p5 = in2(:,5);
p15 = in2(:,15);
p16 = in2(:,16);
p17 = in2(:,17);
p18 = in2(:,18);
p19 = in2(:,19);
x4 = in1(4,:);
x5 = in1(5,:);
x6 = in1(6,:);
x10 = in1(10,:);
x11 = in1(11,:);
x12 = in1(12,:);
x19 = in1(19,:);
x20 = in1(20,:);
x21 = in1(21,:);
x22 = in1(22,:);
x23 = in1(23,:);
x24 = in1(24,:);
t2 = cos(x4);
t3 = cos(x5);
t4 = sin(x4);
t5 = sin(x5);
t6 = p1+p15;
t7 = p3.*x10;
t8 = p4.*x11;
t9 = p5.*x12;
t10 = x19.*x22;
t11 = x19.*x23;
t12 = x20.*x22;
t13 = x19.*x24;
t14 = x20.*x23;
t15 = x21.*x22;
t16 = x20.*x24;
t17 = x21.*x23;
t18 = x21.*x24;
t19 = x22.^2;
t20 = x23.^2;
t21 = x24.^2;
t23 = p16.*x22.*x23;
t24 = p16.*x22.*x24;
t25 = p16.*x23.*x24;
t27 = 1.0./p3;
t28 = 1.0./p4;
t29 = 1.0./p5;
t36 = x4./2.0;
t37 = x5./2.0;
t38 = x6./2.0;
t22 = t2.*x12;
t26 = t4.*x11;
t30 = 1.0./t3;
t32 = -t9;
t33 = -t12;
t34 = -t15;
t35 = -t17;
t39 = cos(t36);
t40 = cos(t37);
t41 = cos(t38);
t42 = sin(t36);
t43 = sin(t37);
t44 = sin(t38);
t45 = 1.0./t6;
t46 = -t23;
t47 = -t24;
t48 = -t25;
t31 = t30.^2;
t49 = t11+t33;
t50 = t13+t34;
t51 = t16+t35;
t69 = t39.*t40.*t41;
t70 = t39.*t40.*t44;
t71 = t39.*t41.*t43;
t72 = t40.*t41.*t42;
t73 = t39.*t43.*t44;
t74 = t40.*t42.*t44;
t75 = t41.*t42.*t43;
t76 = t42.*t43.*t44;
t52 = t49.^2;
t53 = t50.^2;
t54 = t51.^2;
t55 = t49.*x19.*2.0;
t56 = t49.*x20.*2.0;
t57 = t50.*x19.*2.0;
t58 = t49.*x22.*2.0;
t59 = t50.*x21.*2.0;
t60 = t49.*x23.*2.0;
t61 = t51.*x20.*2.0;
t62 = t50.*x22.*2.0;
t63 = t51.*x21.*2.0;
t64 = t50.*x24.*2.0;
t65 = t51.*x23.*2.0;
t66 = t51.*x24.*2.0;
t77 = -t73;
t78 = -t75;
t79 = t69./2.0;
t80 = t70./2.0;
t81 = t71./2.0;
t82 = t72./2.0;
t83 = t73./2.0;
t84 = t74./2.0;
t85 = t75./2.0;
t86 = t76./2.0;
t125 = t69+t76;
t126 = t71+t74;
t67 = -t63;
t68 = -t66;
t87 = -t83;
t88 = -t84;
t89 = -t85;
t90 = -t86;
t91 = t56+t59;
t92 = t57+t61;
t93 = t60+t64;
t94 = t62+t65;
t97 = t52+t53+t54;
t127 = t125.^2;
t128 = t126.^2;
t129 = t70+t78;
t130 = t72+t77;
t136 = t79+t86;
t137 = t80+t85;
t138 = t81+t84;
t139 = t82+t83;
t146 = t125.*t126.*2.0;
t95 = t55+t67;
t96 = t58+t68;
t98 = p1.*p16.*t45.*t91.*x19;
t99 = p1.*p16.*t45.*t91.*x20;
t100 = p1.*p16.*t45.*t92.*x19;
t101 = p1.*p16.*t45.*t91.*x21;
t102 = p1.*p16.*t45.*t92.*x20;
t103 = p1.*p16.*t45.*t92.*x21;
t104 = p1.*p16.*t45.*t93.*x19;
t105 = p1.*p16.*t45.*t93.*x20;
t106 = p1.*p16.*t45.*t94.*x19;
t107 = p1.*p16.*t45.*t93.*x21;
t108 = p1.*p16.*t45.*t94.*x20;
t109 = p1.*p16.*t45.*t94.*x21;
t131 = t129.^2;
t132 = t130.^2;
t133 = p1.*p16.*t45.*t97;
t134 = -t128;
t142 = t79+t90;
t143 = t80+t89;
t144 = t81+t88;
t145 = t82+t87;
t147 = t125.*t129.*2.0;
t148 = t125.*t130.*2.0;
t149 = t126.*t129.*2.0;
t150 = t126.*t130.*2.0;
t153 = t129.*t130.*2.0;
t155 = t125.*t136.*2.0;
t156 = t125.*t137.*2.0;
t157 = t125.*t138.*2.0;
t158 = t125.*t139.*2.0;
t159 = t126.*t136.*2.0;
t160 = t126.*t137.*2.0;
t161 = t126.*t138.*2.0;
t162 = t126.*t139.*2.0;
t180 = t129.*t136.*2.0;
t181 = t129.*t137.*2.0;
t182 = t129.*t138.*2.0;
t183 = t129.*t139.*2.0;
t184 = t130.*t136.*2.0;
t185 = t130.*t137.*2.0;
t186 = t130.*t138.*2.0;
t187 = t130.*t139.*2.0;
t110 = p1.*p16.*t45.*t95.*x19;
t111 = p1.*p16.*t45.*t95.*x20;
t112 = p1.*p16.*t45.*t95.*x21;
t113 = p1.*p16.*t45.*t96.*x19;
t114 = p1.*p16.*t45.*t96.*x20;
t115 = p1.*p16.*t45.*t96.*x21;
t116 = -t100;
t117 = -t102;
t118 = -t103;
t119 = -t104;
t120 = -t105;
t121 = -t107;
t135 = -t133;
t140 = -t131;
t141 = -t132;
t151 = -t149;
t152 = -t150;
t154 = -t153;
t163 = t125.*t142.*2.0;
t164 = t125.*t143.*2.0;
t165 = t125.*t144.*2.0;
t166 = t125.*t145.*2.0;
t167 = t126.*t142.*2.0;
t168 = -t159;
t169 = t126.*t143.*2.0;
t170 = -t160;
t171 = t126.*t144.*2.0;
t172 = -t161;
t173 = t126.*t145.*2.0;
t174 = -t162;
t188 = t129.*t142.*2.0;
t189 = -t180;
t190 = t129.*t143.*2.0;
t191 = t129.*t144.*2.0;
t192 = -t182;
t193 = t129.*t145.*2.0;
t194 = -t183;
t195 = t130.*t142.*2.0;
t196 = -t184;
t197 = t130.*t143.*2.0;
t198 = -t185;
t199 = t130.*t144.*2.0;
t200 = -t186;
t201 = t130.*t145.*2.0;
t208 = t146+t153;
t209 = t147+t150;
t210 = t148+t149;
t122 = -t110;
t123 = -t111;
t124 = -t112;
t175 = -t163;
t176 = -t165;
t177 = -t169;
t178 = -t171;
t179 = -t173;
t202 = -t188;
t203 = -t190;
t204 = -t193;
t205 = -t195;
t206 = -t197;
t207 = -t201;
t211 = t146+t154;
t212 = t147+t152;
t213 = t148+t151;
t214 = p17.*t209;
t215 = p18.*t210;
t216 = p19.*t208;
t221 = t127+t128+t140+t141;
t222 = t127+t131+t134+t141;
t223 = t127+t132+t134+t140;
t228 = t164+t173+t180+t186;
t229 = t157+t159+t193+t197;
t230 = t166+t169+t182+t184;
t233 = t156+t174+t188+t199;
t236 = t165+t167+t185+t194;
t237 = t165+t167+t183+t198;
t238 = t158+t170+t191+t195;
t249 = t164+t173+t189+t200;
t254 = t166+t169+t192+t196;
t217 = p17.*t211;
t218 = p18.*t212;
t219 = p19.*t213;
t220 = -t215;
t224 = p17.*t223;
t225 = p18.*t221;
t226 = p19.*t222;
t231 = t171+t175+t181+t187;
t232 = t163+t178+t181+t187;
t234 = t156+t162+t199+t202;
t235 = t167+t176+t183+t185;
t239 = t158+t160+t191+t205;
t240 = p17.*t228;
t241 = p18.*t229;
t242 = p19.*t229;
t243 = p19.*t230;
t244 = t155+t172+t201+t203;
t245 = t155+t172+t190+t207;
t246 = t155+t161+t203+t207;
t247 = t164+t179+t186+t189;
t248 = t164+t179+t180+t200;
t250 = t157+t168+t197+t204;
t251 = t157+t168+t193+t206;
t252 = t166+t177+t184+t192;
t253 = t166+t177+t182+t196;
t256 = p17.*t236;
t260 = p18.*t238;
t262 = p19.*t233;
t263 = p19.*t237;
t268 = p17.*t254;
t276 = p19.*t249;
t227 = -t224;
t255 = p17.*t232;
t257 = p17.*t239;
t258 = p18.*t234;
t259 = p18.*t235;
t261 = p19.*t231;
t264 = p17.*t244;
t265 = p17.*t247;
t266 = p17.*t251;
t267 = p17.*t253;
t269 = p18.*t245;
t270 = p18.*t246;
t271 = p18.*t248;
t272 = p18.*t250;
t273 = p18.*t252;
t274 = p19.*t246;
t275 = p19.*t248;
t277 = p19.*t252;
t278 = -t241;
t279 = -t256;
t281 = -t263;
t285 = -t276;
t286 = t214+t219+t225;
t287 = t217+t220+t226;
t280 = -t259;
t282 = -t264;
t283 = -t265;
t284 = -t274;
t288 = t216+t218+t227;
t289 = p15.*t133.*t286;
t290 = p15.*t133.*t287;
t292 = t240+t270+t277;
t293 = t255+t258+t281;
t295 = t260+t261+t279;
t296 = t268+t275+t278;
t300 = t267+t272+t285;
t291 = p15.*t133.*t288;
t294 = t257+t262+t280;
t297 = t242+t271+t282;
t298 = t243+t269+t283;
t299 = t266+t273+t284;
mt1 = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,t30.*(t2.*t5.*x11-t4.*t5.*x12),-t22-t26,t30.*(t2.*x11-t4.*x12),0.0,0.0,0.0,-t27.*(p15.*t133.*t298.*x20+p15.*t133.*t299.*x21),t28.*(p15.*t133.*t296.*x21+p15.*t133.*t298.*x19),t29.*(p15.*t133.*t299.*x19+p15.*t135.*t296.*x20),0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,t30.*(t3.*t22+t3.*t26-t5.*x10)+t5.*t31.*(t5.*t22+t5.*t26+t3.*x10),0.0];
mt2 = [t5.*t31.*(t22+t26),0.0,0.0,0.0,t27.*(p15.*t133.*t293.*x20+p15.*t135.*t294.*x21),-t28.*(p15.*t133.*t293.*x19+p15.*t133.*t295.*x21),t29.*(p15.*t133.*t294.*x19+p15.*t133.*t295.*x20),0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,t27.*(p15.*t133.*t300.*x20+p15.*t135.*t297.*x21),-t28.*(p15.*t135.*t292.*x21+p15.*t133.*t300.*x19),t29.*(p15.*t135.*t292.*x20+p15.*t133.*t297.*x19),0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0];
mt3 = [0.0,0.0,0.0,0.0,0.0,0.0,t28.*(t9-p3.*x12),-t29.*(t8-p3.*x11),0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,t4.*t5.*t30,t2,t4.*t30,0.0,0.0,0.0,-t27.*(t9-p4.*x12),0.0,t29.*(t7-p4.*x10),0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,t2.*t5.*t30,-t4,t2.*t30,0.0,0.0,0.0,t27.*(t8-p5.*x11),-t28.*(t7-p5.*x10),0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0];
mt4 = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,t119+t135+p16.*(t20+t21),t46+t120,t47+t121,t27.*(p15.*t105.*t287+p15.*t107.*t286),-t28.*(t290+p15.*t104.*t287+p15.*t121.*t288),-t29.*(t289+p15.*t104.*t286+p15.*t105.*t288),0.0,0.0,0.0,t119+t135,t120,t121,0.0,x24,-x23,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,t46+t113,t114+t135+p16.*(t19+t21),t48+t115,-t27.*(p15.*t114.*t287+p15.*t115.*t286+p15.*t135.*t287)];
mt5 = [t28.*(p15.*t113.*t287-p15.*t115.*t288),t29.*(p15.*t113.*t286+p15.*t114.*t288+p15.*t135.*t288),0.0,0.0,0.0,t113,t114+t135,t115,-x24,0.0,x22,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,t47+t106,t48+t108,t109+t135+p16.*(t19+t20),-t27.*(p15.*t108.*t287+p15.*t109.*t286+p15.*t135.*t286),t28.*(t291+p15.*t106.*t287-p15.*t109.*t288),t29.*(p15.*t106.*t286+p15.*t108.*t288),0.0,0.0,0.0,t106,t108,t109+t135,x23,-x22,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,t98-p16.*(t14+t18),t99-p16.*(t11-t12.*2.0),t101-p16.*(t13-t15.*2.0),-t27.*(p15.*t99.*t287+p15.*t101.*t286),t28.*(p15.*t98.*t287-p15.*t101.*t288),t29.*(p15.*t98.*t286+p15.*t99.*t288)];
mt6 = [0.0,0.0,0.0,t98,t99,t101,0.0,-x21,x20,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,t122+p16.*(t11+t49),t123-p16.*(t10+t18),t124-p16.*(t16-t17.*2.0),t27.*(p15.*t111.*t287+p15.*t112.*t286),-t28.*(p15.*t110.*t287+p15.*t124.*t288),-t29.*(p15.*t110.*t286+p15.*t111.*t288),0.0,0.0,0.0,t122,t123,t124,x21,0.0,-x19,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,t116+p16.*(t13+t50),t117+p16.*(t16+t51),t118-p16.*(t10+t14),t27.*(p15.*t102.*t287+p15.*t103.*t286),-t28.*(p15.*t100.*t287+p15.*t118.*t288),-t29.*(p15.*t100.*t286+p15.*t102.*t288),0.0,0.0,0.0,t116,t117,t118,-x20,x19,0.0,0.0,0.0,0.0];
out1 = reshape([mt1,mt2,mt3,mt4,mt5,mt6],24,24);
