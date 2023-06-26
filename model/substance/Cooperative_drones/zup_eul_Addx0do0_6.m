function A = zup_eul_Addx0do0_6(in1,in2,in3)
%zup_eul_Addx0do0_6
%    A = zup_eul_Addx0do0_6(IN1,IN2,IN3)

%    This function was generated by the Symbolic Math Toolbox version 9.3.
%    2023/06/26 23:20:15

X4 = in1(4,:);
X5 = in1(5,:);
X6 = in1(6,:);
X13 = in1(13,:);
X14 = in1(14,:);
X15 = in1(15,:);
X16 = in1(16,:);
X17 = in1(17,:);
X18 = in1(18,:);
X19 = in1(19,:);
X20 = in1(20,:);
X21 = in1(21,:);
X22 = in1(22,:);
X23 = in1(23,:);
X24 = in1(24,:);
X25 = in1(25,:);
X26 = in1(26,:);
X27 = in1(27,:);
X28 = in1(28,:);
X29 = in1(29,:);
X30 = in1(30,:);
j01 = in3(:,3);
j02 = in3(:,4);
j03 = in3(:,5);
m0 = in3(:,2);
mi1 = in3(:,30);
mi2 = in3(:,31);
mi3 = in3(:,32);
mi4 = in3(:,33);
mi5 = in3(:,34);
mi6 = in3(:,35);
rho1_1 = in3(:,6);
rho1_2 = in3(:,7);
rho1_3 = in3(:,8);
rho2_1 = in3(:,9);
rho2_2 = in3(:,10);
rho2_3 = in3(:,11);
rho3_1 = in3(:,12);
rho3_2 = in3(:,13);
rho3_3 = in3(:,14);
rho4_1 = in3(:,15);
rho4_2 = in3(:,16);
rho4_3 = in3(:,17);
rho5_1 = in3(:,18);
rho5_2 = in3(:,19);
rho5_3 = in3(:,20);
rho6_1 = in3(:,21);
rho6_2 = in3(:,22);
rho6_3 = in3(:,23);
t2 = X13.^2;
t3 = X14.^2;
t4 = X15.^2;
t5 = X16.^2;
t6 = X17.^2;
t7 = X18.^2;
t8 = X19.^2;
t9 = X20.^2;
t10 = X21.^2;
t11 = X22.^2;
t12 = X23.^2;
t13 = X24.^2;
t14 = X25.^2;
t15 = X26.^2;
t16 = X27.^2;
t17 = X28.^2;
t18 = X29.^2;
t19 = X30.^2;
t20 = X13.*X14.*mi1;
t21 = X13.*X15.*mi1;
t22 = X14.*X15.*mi1;
t23 = X16.*X17.*mi2;
t24 = X16.*X18.*mi2;
t25 = X17.*X18.*mi2;
t26 = X19.*X20.*mi3;
t27 = X19.*X21.*mi3;
t28 = X20.*X21.*mi3;
t29 = X22.*X23.*mi4;
t30 = X22.*X24.*mi4;
t31 = X23.*X24.*mi4;
t32 = X25.*X26.*mi5;
t33 = X25.*X27.*mi5;
t34 = X26.*X27.*mi5;
t35 = X28.*X29.*mi6;
t36 = X28.*X30.*mi6;
t37 = X29.*X30.*mi6;
t38 = X4./2.0;
t39 = X5./2.0;
t40 = X6./2.0;
t41 = cos(t38);
t42 = cos(t39);
t43 = cos(t40);
t44 = sin(t38);
t45 = sin(t39);
t46 = sin(t40);
t47 = -t20;
t48 = -t21;
t49 = -t23;
t50 = -t24;
t51 = -t26;
t52 = -t27;
t53 = -t29;
t54 = -t30;
t55 = -t32;
t56 = -t33;
t57 = -t35;
t58 = -t36;
t69 = t22+t25+t28+t31+t34+t37;
t59 = t41.*t42.*t43;
t60 = t41.*t42.*t46;
t61 = t41.*t43.*t45;
t62 = t42.*t43.*t44;
t63 = t41.*t45.*t46;
t64 = t42.*t44.*t46;
t65 = t43.*t44.*t45;
t66 = t44.*t45.*t46;
t70 = t47+t49+t51+t53+t55+t57;
t71 = t48+t50+t52+t54+t56+t58;
t67 = -t63;
t68 = -t65;
t72 = t59+t66;
t73 = t61+t64;
t74 = t72.^2;
t75 = t73.^2;
t76 = t60+t68;
t77 = t62+t67;
t83 = t72.*t73.*2.0;
t78 = t76.^2;
t79 = t77.^2;
t80 = -t75;
t84 = t72.*t76.*2.0;
t85 = t72.*t77.*2.0;
t86 = t73.*t76.*2.0;
t87 = t73.*t77.*2.0;
t90 = t76.*t77.*2.0;
t81 = -t78;
t82 = -t79;
t88 = -t86;
t89 = -t87;
t91 = -t90;
t92 = t83+t90;
t93 = t84+t87;
t94 = t85+t86;
t95 = t83+t91;
t96 = t84+t89;
t97 = t85+t88;
t98 = mi1.*rho1_1.*t92;
t99 = mi1.*rho1_1.*t94;
t100 = mi1.*rho1_2.*t92;
t101 = mi1.*rho1_2.*t93;
t102 = mi1.*rho1_3.*t93;
t103 = mi1.*rho1_3.*t94;
t104 = mi2.*rho2_1.*t92;
t105 = mi2.*rho2_1.*t94;
t106 = mi2.*rho2_2.*t92;
t107 = mi2.*rho2_2.*t93;
t108 = mi2.*rho2_3.*t93;
t109 = mi2.*rho2_3.*t94;
t110 = mi3.*rho3_1.*t92;
t111 = mi3.*rho3_1.*t94;
t112 = mi3.*rho3_2.*t92;
t113 = mi3.*rho3_2.*t93;
t114 = mi3.*rho3_3.*t93;
t115 = mi3.*rho3_3.*t94;
t116 = mi4.*rho4_1.*t92;
t117 = mi4.*rho4_1.*t94;
t118 = mi4.*rho4_2.*t92;
t119 = mi4.*rho4_2.*t93;
t120 = mi4.*rho4_3.*t93;
t121 = mi4.*rho4_3.*t94;
t122 = mi5.*rho5_1.*t92;
t123 = mi5.*rho5_1.*t94;
t124 = mi5.*rho5_2.*t92;
t125 = mi5.*rho5_2.*t93;
t126 = mi5.*rho5_3.*t93;
t127 = mi5.*rho5_3.*t94;
t128 = mi6.*rho6_1.*t92;
t129 = mi6.*rho6_1.*t94;
t130 = mi6.*rho6_2.*t92;
t131 = mi6.*rho6_2.*t93;
t132 = mi6.*rho6_3.*t93;
t133 = mi6.*rho6_3.*t94;
t170 = t20.*t92;
t171 = t20.*t93;
t172 = t21.*t92;
t173 = t21.*t94;
t174 = t22.*t93;
t175 = t22.*t94;
t176 = t23.*t92;
t177 = t23.*t93;
t178 = t24.*t92;
t179 = t24.*t94;
t180 = t25.*t93;
t181 = t25.*t94;
t182 = t26.*t92;
t183 = t26.*t93;
t184 = t27.*t92;
t185 = t27.*t94;
t186 = t28.*t93;
t187 = t28.*t94;
t188 = t29.*t92;
t189 = t29.*t93;
t190 = t30.*t92;
t191 = t30.*t94;
t192 = t31.*t93;
t193 = t31.*t94;
t194 = t32.*t92;
t195 = t32.*t93;
t196 = t33.*t92;
t197 = t33.*t94;
t198 = t34.*t93;
t199 = t34.*t94;
t200 = t35.*t92;
t201 = t35.*t93;
t202 = t36.*t92;
t203 = t36.*t94;
t204 = t37.*t93;
t205 = t37.*t94;
t248 = mi1.*t2.*t92;
t249 = mi1.*t3.*t93;
t250 = mi1.*t4.*t94;
t251 = mi2.*t5.*t92;
t252 = mi2.*t6.*t93;
t253 = mi2.*t7.*t94;
t254 = mi3.*t8.*t92;
t255 = mi3.*t9.*t93;
t256 = mi3.*t10.*t94;
t257 = mi4.*t11.*t92;
t258 = mi4.*t12.*t93;
t259 = mi4.*t13.*t94;
t260 = mi5.*t14.*t92;
t261 = mi5.*t15.*t93;
t262 = mi5.*t16.*t94;
t263 = mi6.*t17.*t92;
t264 = mi6.*t18.*t93;
t265 = mi6.*t19.*t94;
t344 = t74+t75+t81+t82;
t345 = t74+t78+t80+t82;
t346 = t74+t79+t80+t81;
t134 = mi1.*rho1_1.*t96;
t135 = mi1.*rho1_1.*t97;
t136 = mi1.*rho1_2.*t95;
t137 = mi1.*rho1_2.*t97;
t138 = mi1.*rho1_3.*t95;
t139 = mi1.*rho1_3.*t96;
t140 = mi2.*rho2_1.*t96;
t141 = mi2.*rho2_1.*t97;
t142 = mi2.*rho2_2.*t95;
t143 = mi2.*rho2_2.*t97;
t144 = mi2.*rho2_3.*t95;
t145 = mi2.*rho2_3.*t96;
t146 = mi3.*rho3_1.*t96;
t147 = mi3.*rho3_1.*t97;
t148 = mi3.*rho3_2.*t95;
t149 = mi3.*rho3_2.*t97;
t150 = mi3.*rho3_3.*t95;
t151 = mi3.*rho3_3.*t96;
t152 = mi4.*rho4_1.*t96;
t153 = mi4.*rho4_1.*t97;
t154 = mi4.*rho4_2.*t95;
t155 = mi4.*rho4_2.*t97;
t156 = mi4.*rho4_3.*t95;
t157 = mi4.*rho4_3.*t96;
t158 = mi5.*rho5_1.*t96;
t159 = mi5.*rho5_1.*t97;
t160 = mi5.*rho5_2.*t95;
t161 = mi5.*rho5_2.*t97;
t162 = mi5.*rho5_3.*t95;
t163 = mi5.*rho5_3.*t96;
t164 = mi6.*rho6_1.*t96;
t165 = mi6.*rho6_1.*t97;
t166 = mi6.*rho6_2.*t95;
t167 = mi6.*rho6_2.*t97;
t168 = mi6.*rho6_3.*t95;
t169 = mi6.*rho6_3.*t96;
t216 = t22.*t95;
t217 = t22.*t97;
t222 = t25.*t95;
t223 = t25.*t97;
t228 = t28.*t95;
t229 = t28.*t97;
t234 = t31.*t95;
t235 = t31.*t97;
t240 = t34.*t95;
t241 = t34.*t97;
t246 = t37.*t95;
t247 = t37.*t97;
t272 = mi1.*t2.*t96;
t273 = mi1.*t3.*t97;
t274 = mi1.*t4.*t95;
t275 = mi2.*t5.*t96;
t276 = mi2.*t6.*t97;
t277 = mi2.*t7.*t95;
t278 = mi3.*t8.*t96;
t279 = mi3.*t9.*t97;
t280 = mi3.*t10.*t95;
t281 = mi4.*t11.*t96;
t282 = mi4.*t12.*t97;
t283 = mi4.*t13.*t95;
t284 = mi5.*t14.*t96;
t285 = mi5.*t15.*t97;
t286 = mi5.*t16.*t95;
t287 = mi6.*t17.*t96;
t288 = mi6.*t18.*t97;
t289 = mi6.*t19.*t95;
t290 = t47.*t96;
t291 = t47.*t97;
t292 = t48.*t95;
t293 = t48.*t96;
t296 = t49.*t96;
t297 = t49.*t97;
t298 = t50.*t95;
t299 = t50.*t96;
t302 = t51.*t96;
t303 = t51.*t97;
t304 = t52.*t95;
t305 = t52.*t96;
t308 = t53.*t96;
t309 = t53.*t97;
t310 = t54.*t95;
t311 = t54.*t96;
t314 = t55.*t96;
t315 = t55.*t97;
t316 = t56.*t95;
t317 = t56.*t96;
t320 = t57.*t96;
t321 = t57.*t97;
t322 = t58.*t95;
t323 = t58.*t96;
t347 = mi1.*rho1_1.*t344;
t348 = mi1.*rho1_1.*t345;
t349 = mi1.*rho1_2.*t345;
t350 = mi1.*rho1_2.*t346;
t351 = mi1.*rho1_3.*t344;
t352 = mi1.*rho1_3.*t346;
t353 = mi2.*rho2_1.*t344;
t354 = mi2.*rho2_1.*t345;
t355 = mi2.*rho2_2.*t345;
t356 = mi2.*rho2_2.*t346;
t357 = mi2.*rho2_3.*t344;
t358 = mi2.*rho2_3.*t346;
t359 = mi3.*rho3_1.*t344;
t360 = mi3.*rho3_1.*t345;
t361 = mi3.*rho3_2.*t345;
t362 = mi3.*rho3_2.*t346;
t363 = mi3.*rho3_3.*t344;
t364 = mi3.*rho3_3.*t346;
t365 = mi4.*rho4_1.*t344;
t366 = mi4.*rho4_1.*t345;
t367 = mi4.*rho4_2.*t345;
t368 = mi4.*rho4_2.*t346;
t369 = mi4.*rho4_3.*t344;
t370 = mi4.*rho4_3.*t346;
t371 = mi5.*rho5_1.*t344;
t372 = mi5.*rho5_1.*t345;
t373 = mi5.*rho5_2.*t345;
t374 = mi5.*rho5_2.*t346;
t375 = mi5.*rho5_3.*t344;
t376 = mi5.*rho5_3.*t346;
t377 = mi6.*rho6_1.*t344;
t378 = mi6.*rho6_1.*t345;
t379 = mi6.*rho6_2.*t345;
t380 = mi6.*rho6_2.*t346;
t381 = mi6.*rho6_3.*t344;
t382 = mi6.*rho6_3.*t346;
t383 = t20.*t344;
t384 = t20.*t346;
t385 = t21.*t345;
t386 = t21.*t346;
t387 = t22.*t344;
t388 = t22.*t345;
t389 = t23.*t344;
t390 = t23.*t346;
t391 = t24.*t345;
t392 = t24.*t346;
t393 = t25.*t344;
t394 = t25.*t345;
t395 = t26.*t344;
t396 = t26.*t346;
t397 = t27.*t345;
t398 = t27.*t346;
t399 = t28.*t344;
t400 = t28.*t345;
t401 = t29.*t344;
t402 = t29.*t346;
t403 = t30.*t345;
t404 = t30.*t346;
t405 = t31.*t344;
t406 = t31.*t345;
t407 = t32.*t344;
t408 = t32.*t346;
t409 = t33.*t345;
t410 = t33.*t346;
t411 = t34.*t344;
t412 = t34.*t345;
t413 = t35.*t344;
t414 = t35.*t346;
t415 = t36.*t345;
t416 = t36.*t346;
t417 = t37.*t344;
t418 = t37.*t345;
t437 = mi1.*t2.*t346;
t438 = mi1.*t3.*t344;
t439 = mi1.*t4.*t345;
t440 = mi2.*t5.*t346;
t441 = mi2.*t6.*t344;
t442 = mi2.*t7.*t345;
t443 = mi3.*t8.*t346;
t444 = mi3.*t9.*t344;
t445 = mi3.*t10.*t345;
t446 = mi4.*t11.*t346;
t447 = mi4.*t12.*t344;
t448 = mi4.*t13.*t345;
t449 = mi5.*t14.*t346;
t450 = mi5.*t15.*t344;
t451 = mi5.*t16.*t345;
t452 = mi6.*t17.*t346;
t453 = mi6.*t18.*t344;
t454 = mi6.*t19.*t345;
t266 = -t136;
t267 = -t142;
t268 = -t148;
t269 = -t154;
t270 = -t160;
t271 = -t166;
t294 = -t216;
t295 = -t217;
t300 = -t222;
t301 = -t223;
t306 = -t228;
t307 = -t229;
t312 = -t234;
t313 = -t235;
t318 = -t240;
t319 = -t241;
t324 = -t246;
t325 = -t247;
t326 = -t272;
t327 = -t273;
t328 = -t274;
t329 = -t275;
t330 = -t276;
t331 = -t277;
t332 = -t278;
t333 = -t279;
t334 = -t280;
t335 = -t281;
t336 = -t282;
t337 = -t283;
t338 = -t284;
t339 = -t285;
t340 = -t286;
t341 = -t287;
t342 = -t288;
t343 = -t289;
t419 = -t348;
t420 = -t349;
t421 = -t350;
t422 = -t354;
t423 = -t355;
t424 = -t356;
t425 = -t360;
t426 = -t361;
t427 = -t362;
t428 = -t366;
t429 = -t367;
t430 = -t368;
t431 = -t372;
t432 = -t373;
t433 = -t374;
t434 = -t378;
t435 = -t379;
t436 = -t380;
t455 = t100+t139;
t456 = t106+t145;
t457 = t112+t151;
t458 = t118+t157;
t459 = t124+t163;
t460 = t130+t169;
t497 = t101+t347;
t498 = t98+t352;
t499 = t107+t353;
t500 = t104+t358;
t501 = t113+t359;
t502 = t110+t364;
t503 = t119+t365;
t504 = t116+t370;
t505 = t125+t371;
t506 = t122+t376;
t507 = t131+t377;
t508 = t128+t382;
t509 = t137+t351;
t510 = t143+t357;
t511 = t149+t363;
t512 = t155+t369;
t513 = t161+t375;
t514 = t167+t381;
t581 = t248+t291+t385;
t582 = t171+t292+t437;
t585 = t175+t290+t438;
t587 = t250+t293+t387;
A = ft_1({X13,X14,X15,X16,X17,X18,X19,X20,X21,X22,X23,X24,X25,X26,X27,X28,X29,X30,j01,j02,j03,m0,mi1,mi2,mi3,mi4,mi5,mi6,rho1_1,rho1_2,rho1_3,rho2_1,rho2_2,rho2_3,rho3_1,rho3_2,rho3_3,rho4_1,rho4_2,rho4_3,rho5_1,rho5_2,rho5_3,rho6_1,rho6_2,rho6_3,t10,t102,t103,t105,t108,t109,t11,t111,t114,t115,t117,t12,t120,t121,t123,t126,t127,t129,t13,t132,t133,t134,t135,t138,t14,t140,t141,t144,t146,t147,t15,t150,t152,t153,t156,t158,t159,t16,t162,t164,t165,t168,t17,t170,t172,t173,t174,t176,t177,t178,t179,t18,t180,t181,t182,t183,t184,t185,t186,t187,t188,t189,t19,t190,t191,t192,t193,t194,t195,t196,t197,t198,t199,t2,t200,t201,t202,t203,t204,t205,t249,t251,t252,t253,t254,t255,t256,t257,t258,t259,t260,t261,t262,t263,t264,t265,t266,t267,t268,t269,t270,t271,t294,t295,t296,t297,t298,t299,t3,t300,t301,t302,t303,t304,t305,t306,t307,t308,t309,t310,t311,t312,t313,t314,t315,t316,t317,t318,t319,t320,t321,t322,t323,t324,t325,t326,t327,t328,t329,t330,t331,t332,t333,t334,t335,t336,t337,t338,t339,t340,t341,t342,t343,t344,t345,t346,t383,t384,t386,t388,t389,t390,t391,t392,t393,t394,t395,t396,t397,t398,t399,t4,t400,t401,t402,t403,t404,t405,t406,t407,t408,t409,t410,t411,t412,t413,t414,t415,t416,t417,t418,t419,t420,t421,t422,t423,t424,t425,t426,t427,t428,t429,t430,t431,t432,t433,t434,t435,t436,t439,t440,t441,t442,t443,t444,t445,t446,t447,t448,t449,t450,t451,t452,t453,t454,t455,t456,t457,t458,t459,t460,t497,t498,t499,t5,t500,t501,t502,t503,t504,t505,t506,t507,t508,t509,t510,t511,t512,t513,t514,t581,t582,t585,t587,t6,t69,t7,t70,t71,t8,t9,t92,t93,t94,t95,t96,t97,t99});
end
function A = ft_1(ct)
[X13,X14,X15,X16,X17,X18,X19,X20,X21,X22,X23,X24,X25,X26,X27,X28,X29,X30,j01,j02,j03,m0,mi1,mi2,mi3,mi4,mi5,mi6,rho1_1,rho1_2,rho1_3,rho2_1,rho2_2,rho2_3,rho3_1,rho3_2,rho3_3,rho4_1,rho4_2,rho4_3,rho5_1,rho5_2,rho5_3,rho6_1,rho6_2,rho6_3,t10,t102,t103,t105,t108,t109,t11,t111,t114,t115,t117,t12,t120,t121,t123,t126,t127,t129,t13,t132,t133,t134,t135,t138,t14,t140,t141,t144,t146,t147,t15,t150,t152,t153,t156,t158,t159,t16,t162,t164,t165,t168,t17,t170,t172,t173,t174,t176,t177,t178,t179,t18,t180,t181,t182,t183,t184,t185,t186,t187,t188,t189,t19,t190,t191,t192,t193,t194,t195,t196,t197,t198,t199,t2,t200,t201,t202,t203,t204,t205,t249,t251,t252,t253,t254,t255,t256,t257,t258,t259,t260,t261,t262,t263,t264,t265,t266,t267,t268,t269,t270,t271,t294,t295,t296,t297,t298,t299,t3,t300,t301,t302,t303,t304,t305,t306,t307,t308,t309,t310,t311,t312,t313,t314,t315,t316,t317,t318,t319,t320,t321,t322,t323,t324,t325,t326,t327,t328,t329,t330,t331,t332,t333,t334,t335,t336,t337,t338,t339,t340,t341,t342,t343,t344,t345,t346,t383,t384,t386,t388,t389,t390,t391,t392,t393,t394,t395,t396,t397,t398,t399,t4,t400,t401,t402,t403,t404,t405,t406,t407,t408,t409,t410,t411,t412,t413,t414,t415,t416,t417,t418,t419,t420,t421,t422,t423,t424,t425,t426,t427,t428,t429,t430,t431,t432,t433,t434,t435,t436,t439,t440,t441,t442,t443,t444,t445,t446,t447,t448,t449,t450,t451,t452,t453,t454,t455,t456,t457,t458,t459,t460,t497,t498,t499,t5,t500,t501,t502,t503,t504,t505,t506,t507,t508,t509,t510,t511,t512,t513,t514,t581,t582,t585,t587,t6,t69,t7,t70,t71,t8,t9,t92,t93,t94,t95,t96,t97,t99] = ct{:};
t590 = t251+t297+t391;
t591 = t177+t298+t440;
t594 = t181+t296+t441;
t596 = t253+t299+t393;
t599 = t254+t303+t397;
t600 = t183+t304+t443;
t603 = t187+t302+t444;
t605 = t256+t305+t399;
t608 = t257+t309+t403;
t609 = t189+t310+t446;
t612 = t193+t308+t447;
t614 = t259+t311+t405;
t617 = t260+t315+t409;
t618 = t195+t316+t449;
t621 = t199+t314+t450;
t623 = t262+t317+t411;
t626 = t263+t321+t415;
t627 = t201+t322+t452;
t630 = t205+t320+t453;
t632 = t265+t323+t417;
t461 = X13.*t455;
t462 = X16.*t456;
t463 = X19.*t457;
t464 = X22.*t458;
t465 = X25.*t459;
t466 = X28.*t460;
t467 = t99+t266;
t469 = t105+t267;
t471 = t111+t268;
t473 = t117+t269;
t475 = t123+t270;
t477 = t129+t271;
t515 = t103+t420;
t516 = t109+t423;
t517 = t115+t426;
t518 = t121+t429;
t519 = t127+t432;
t520 = t133+t435;
t521 = X13.*t498;
t522 = X14.*t497;
t523 = X16.*t500;
t524 = X17.*t499;
t525 = X19.*t502;
t526 = X20.*t501;
t527 = X22.*t504;
t528 = X23.*t503;
t529 = X25.*t506;
t530 = X26.*t505;
t531 = X28.*t508;
t532 = X29.*t507;
t533 = t134+t421;
t534 = t138+t419;
t535 = t140+t424;
t536 = t144+t422;
t537 = t146+t427;
t538 = t150+t425;
t539 = t152+t430;
t540 = t156+t428;
t541 = t158+t433;
t542 = t162+t431;
t543 = t164+t436;
t544 = t168+t434;
t545 = X14.*t509;
t546 = X17.*t510;
t547 = X20.*t511;
t548 = X23.*t512;
t549 = X26.*t513;
t550 = X29.*t514;
t583 = t173+t326+t383;
t584 = t249+t294+t384;
t586 = t170+t327+t388;
t588 = t172+t295+t439;
t589 = t174+t328+t386;
t592 = t179+t329+t389;
t593 = t252+t300+t390;
t595 = t176+t330+t394;
t597 = t178+t301+t442;
t598 = t180+t331+t392;
t601 = t185+t332+t395;
t602 = t255+t306+t396;
t604 = t182+t333+t400;
t606 = t184+t307+t445;
t607 = t186+t334+t398;
t610 = t191+t335+t401;
t611 = t258+t312+t402;
t613 = t188+t336+t406;
t615 = t190+t313+t448;
t616 = t192+t337+t404;
t619 = t197+t338+t407;
t620 = t261+t318+t408;
t622 = t194+t339+t412;
t624 = t196+t319+t451;
t625 = t198+t340+t410;
t628 = t203+t341+t413;
t629 = t264+t324+t414;
t631 = t200+t342+t418;
t633 = t202+t325+t454;
t634 = t204+t343+t416;
t480 = X15.*t467;
t481 = -t461;
t483 = X18.*t469;
t484 = -t462;
t486 = X21.*t471;
t487 = -t463;
t489 = X24.*t473;
t490 = -t464;
t492 = X27.*t475;
t493 = -t465;
t495 = X30.*t477;
t496 = -t466;
t552 = X15.*t515;
t554 = X18.*t516;
t556 = X21.*t517;
t558 = X24.*t518;
t560 = X27.*t519;
t562 = X30.*t520;
t563 = X13.*t533;
t564 = X15.*t534;
t565 = X16.*t535;
t566 = X18.*t536;
t567 = X19.*t537;
t568 = X21.*t538;
t569 = X22.*t539;
t570 = X24.*t540;
t571 = X25.*t541;
t572 = X27.*t542;
t573 = X28.*t543;
t574 = X30.*t544;
t575 = -t563;
t576 = -t565;
t577 = -t567;
t578 = -t569;
t579 = -t571;
t580 = -t573;
t635 = t481+t545+t552;
t636 = t484+t546+t554;
t637 = t487+t547+t556;
t638 = t490+t548+t558;
t639 = t493+t549+t560;
t640 = t496+t550+t562;
t728 = -X13.*t96.*(t521-t564+X14.*(t102-t135));
t729 = -X14.*t97.*(t521-t564+X14.*(t102-t135));
t730 = -X15.*t95.*(t521-t564+X14.*(t102-t135));
t737 = -X16.*t96.*(t523-t566+X17.*(t108-t141));
t738 = -X17.*t97.*(t523-t566+X17.*(t108-t141));
t739 = -X18.*t95.*(t523-t566+X17.*(t108-t141));
t746 = -X19.*t96.*(t525-t568+X20.*(t114-t147));
t747 = -X20.*t97.*(t525-t568+X20.*(t114-t147));
t748 = -X21.*t95.*(t525-t568+X20.*(t114-t147));
t755 = -X22.*t96.*(t527-t570+X23.*(t120-t153));
t756 = -X23.*t97.*(t527-t570+X23.*(t120-t153));
t757 = -X24.*t95.*(t527-t570+X23.*(t120-t153));
t764 = -X25.*t96.*(t529-t572+X26.*(t126-t159));
t765 = -X26.*t97.*(t529-t572+X26.*(t126-t159));
t766 = -X27.*t95.*(t529-t572+X26.*(t126-t159));
t773 = -X28.*t96.*(t531-t574+X29.*(t132-t165));
t774 = -X29.*t97.*(t531-t574+X29.*(t132-t165));
t775 = -X30.*t95.*(t531-t574+X29.*(t132-t165));
t641 = t480+t522+t575;
t643 = t483+t524+t576;
t645 = t486+t526+t577;
t647 = t489+t528+t578;
t649 = t492+t530+t579;
t651 = t495+t532+t580;
t653 = X13.*t92.*t635;
t654 = X14.*t93.*t635;
t655 = X15.*t94.*t635;
t656 = X16.*t92.*t636;
t657 = X17.*t93.*t636;
t658 = X18.*t94.*t636;
t659 = X19.*t92.*t637;
t660 = X20.*t93.*t637;
t661 = X21.*t94.*t637;
t662 = X22.*t92.*t638;
t663 = X23.*t93.*t638;
t664 = X24.*t94.*t638;
t665 = X25.*t92.*t639;
t666 = X26.*t93.*t639;
t667 = X27.*t94.*t639;
t668 = X28.*t92.*t640;
t669 = X29.*t93.*t640;
t670 = X30.*t94.*t640;
t671 = X13.*t96.*t635;
t672 = X14.*t97.*t635;
t673 = X15.*t95.*t635;
t674 = X16.*t96.*t636;
t675 = X17.*t97.*t636;
t676 = X18.*t95.*t636;
t677 = X19.*t96.*t637;
t678 = X20.*t97.*t637;
t679 = X21.*t95.*t637;
t680 = X22.*t96.*t638;
t681 = X23.*t97.*t638;
t682 = X24.*t95.*t638;
t683 = X25.*t96.*t639;
t684 = X26.*t97.*t639;
t685 = X27.*t95.*t639;
t686 = X28.*t96.*t640;
t687 = X29.*t97.*t640;
t688 = X30.*t95.*t640;
t815 = X13.*t346.*t635;
t816 = X14.*t344.*t635;
t817 = X15.*t345.*t635;
t818 = X16.*t346.*t636;
t819 = X17.*t344.*t636;
t820 = X18.*t345.*t636;
t821 = X19.*t346.*t637;
t822 = X20.*t344.*t637;
t823 = X21.*t345.*t637;
t824 = X22.*t346.*t638;
t825 = X23.*t344.*t638;
t826 = X24.*t345.*t638;
t827 = X25.*t346.*t639;
t828 = X26.*t344.*t639;
t829 = X27.*t345.*t639;
t830 = X28.*t346.*t640;
t831 = X29.*t344.*t640;
t832 = X30.*t345.*t640;
t689 = X13.*t92.*t641;
t690 = X14.*t93.*t641;
t691 = X15.*t94.*t641;
t695 = X16.*t92.*t643;
t696 = X17.*t93.*t643;
t697 = X18.*t94.*t643;
t701 = X19.*t92.*t645;
t702 = X20.*t93.*t645;
t703 = X21.*t94.*t645;
t707 = X22.*t92.*t647;
t708 = X23.*t93.*t647;
t709 = X24.*t94.*t647;
t713 = X25.*t92.*t649;
t714 = X26.*t93.*t649;
t715 = X27.*t94.*t649;
t719 = X28.*t92.*t651;
t720 = X29.*t93.*t651;
t721 = X30.*t94.*t651;
t725 = X13.*t96.*t641;
t726 = X14.*t97.*t641;
t727 = X15.*t95.*t641;
t731 = -t671;
t732 = -t672;
t733 = -t673;
t734 = X16.*t96.*t643;
t735 = X17.*t97.*t643;
t736 = X18.*t95.*t643;
t740 = -t674;
t741 = -t675;
t742 = -t676;
t743 = X19.*t96.*t645;
t744 = X20.*t97.*t645;
t745 = X21.*t95.*t645;
t749 = -t677;
t750 = -t678;
t751 = -t679;
t752 = X22.*t96.*t647;
t753 = X23.*t97.*t647;
t754 = X24.*t95.*t647;
t758 = -t680;
t759 = -t681;
t760 = -t682;
t761 = X25.*t96.*t649;
t762 = X26.*t97.*t649;
t763 = X27.*t95.*t649;
t767 = -t683;
t768 = -t684;
t769 = -t685;
t770 = X28.*t96.*t651;
t771 = X29.*t97.*t651;
t772 = X30.*t95.*t651;
t776 = -t686;
t777 = -t687;
t778 = -t688;
t833 = X13.*t346.*t641;
t834 = X14.*t344.*t641;
t835 = X15.*t345.*t641;
t839 = X16.*t346.*t643;
t840 = X17.*t344.*t643;
t841 = X18.*t345.*t643;
t845 = X19.*t346.*t645;
t846 = X20.*t344.*t645;
t847 = X21.*t345.*t645;
t851 = X22.*t346.*t647;
t852 = X23.*t344.*t647;
t853 = X24.*t345.*t647;
t857 = X25.*t346.*t649;
t858 = X26.*t344.*t649;
t859 = X27.*t345.*t649;
t863 = X28.*t346.*t651;
t864 = X29.*t344.*t651;
t865 = X30.*t345.*t651;
t779 = -t725;
t780 = -t726;
t781 = -t727;
t785 = -t734;
t786 = -t735;
t787 = -t736;
t791 = -t743;
t792 = -t744;
t793 = -t745;
t797 = -t752;
t798 = -t753;
t799 = -t754;
t803 = -t761;
t804 = -t762;
t805 = -t763;
t809 = -t770;
t810 = -t771;
t811 = -t772;
t869 = t654+t733+t815;
t870 = t655+t731+t816;
t871 = t653+t732+t817;
t872 = t657+t742+t818;
t873 = t658+t740+t819;
t874 = t656+t741+t820;
t875 = t660+t751+t821;
t876 = t661+t749+t822;
t877 = t659+t750+t823;
t878 = t663+t760+t824;
t879 = t664+t758+t825;
t880 = t662+t759+t826;
t881 = t666+t769+t827;
t882 = t667+t767+t828;
t883 = t665+t768+t829;
t884 = t669+t778+t830;
t885 = t670+t776+t831;
t886 = t668+t777+t832;
t887 = t690+t781+t833;
t888 = t691+t779+t834;
t889 = t689+t780+t835;
t893 = t696+t787+t839;
t894 = t697+t785+t840;
t895 = t695+t786+t841;
t899 = t702+t793+t845;
t900 = t703+t791+t846;
t901 = t701+t792+t847;
t905 = t708+t799+t851;
t906 = t709+t797+t852;
t907 = t707+t798+t853;
t911 = t714+t805+t857;
t912 = t715+t803+t858;
t913 = t713+t804+t859;
t917 = t720+t811+t863;
t918 = t721+t809+t864;
t919 = t719+t810+t865;
et1 = -rho1_2.*(t729+X13.*t92.*(t521-t564+X14.*(t102-t135))+X15.*t345.*(t521-t564+X14.*(t102-t135)))+rho1_3.*(t728+X15.*t94.*(t521-t564+X14.*(t102-t135))+X14.*t344.*(t521-t564+X14.*(t102-t135)))-rho2_2.*(t738+X16.*t92.*(t523-t566+X17.*(t108-t141))+X18.*t345.*(t523-t566+X17.*(t108-t141)))+rho2_3.*(t737+X18.*t94.*(t523-t566+X17.*(t108-t141))+X17.*t344.*(t523-t566+X17.*(t108-t141)))-rho3_2.*(t747+X19.*t92.*(t525-t568+X20.*(t114-t147))+X21.*t345.*(t525-t568+X20.*(t114-t147)));
et2 = rho3_3.*(t746+X21.*t94.*(t525-t568+X20.*(t114-t147))+X20.*t344.*(t525-t568+X20.*(t114-t147)))-rho4_2.*(t756+X22.*t92.*(t527-t570+X23.*(t120-t153))+X24.*t345.*(t527-t570+X23.*(t120-t153)))+rho4_3.*(t755+X24.*t94.*(t527-t570+X23.*(t120-t153))+X23.*t344.*(t527-t570+X23.*(t120-t153)))-rho5_2.*(t765+X25.*t92.*(t529-t572+X26.*(t126-t159))+X27.*t345.*(t529-t572+X26.*(t126-t159)))+rho5_3.*(t764+X27.*t94.*(t529-t572+X26.*(t126-t159))+X26.*t344.*(t529-t572+X26.*(t126-t159)));
et3 = -rho6_2.*(t774+X28.*t92.*(t531-t574+X29.*(t132-t165))+X30.*t345.*(t531-t574+X29.*(t132-t165)))+rho6_3.*(t773+X30.*t94.*(t531-t574+X29.*(t132-t165))+X29.*t344.*(t531-t574+X29.*(t132-t165)));
et4 = j02+rho1_1.*(t729+X13.*t92.*(t521-t564+X14.*(t102-t135))+X15.*t345.*(t521-t564+X14.*(t102-t135)))+rho1_3.*(t730+X14.*t93.*(t521-t564+X14.*(t102-t135))+X13.*t346.*(t521-t564+X14.*(t102-t135)))+rho2_1.*(t738+X16.*t92.*(t523-t566+X17.*(t108-t141))+X18.*t345.*(t523-t566+X17.*(t108-t141)))+rho2_3.*(t739+X17.*t93.*(t523-t566+X17.*(t108-t141))+X16.*t346.*(t523-t566+X17.*(t108-t141)))+rho3_1.*(t747+X19.*t92.*(t525-t568+X20.*(t114-t147))+X21.*t345.*(t525-t568+X20.*(t114-t147)));
et5 = rho3_3.*(t748+X20.*t93.*(t525-t568+X20.*(t114-t147))+X19.*t346.*(t525-t568+X20.*(t114-t147)))+rho4_1.*(t756+X22.*t92.*(t527-t570+X23.*(t120-t153))+X24.*t345.*(t527-t570+X23.*(t120-t153)))+rho4_3.*(t757+X23.*t93.*(t527-t570+X23.*(t120-t153))+X22.*t346.*(t527-t570+X23.*(t120-t153)))+rho5_1.*(t765+X25.*t92.*(t529-t572+X26.*(t126-t159))+X27.*t345.*(t529-t572+X26.*(t126-t159)))+rho5_3.*(t766+X26.*t93.*(t529-t572+X26.*(t126-t159))+X25.*t346.*(t529-t572+X26.*(t126-t159)));
et6 = rho6_1.*(t774+X28.*t92.*(t531-t574+X29.*(t132-t165))+X30.*t345.*(t531-t574+X29.*(t132-t165)))+rho6_3.*(t775+X29.*t93.*(t531-t574+X29.*(t132-t165))+X28.*t346.*(t531-t574+X29.*(t132-t165)));
et7 = -rho1_1.*(t728+X15.*t94.*(t521-t564+X14.*(t102-t135))+X14.*t344.*(t521-t564+X14.*(t102-t135)))-rho1_2.*(t730+X14.*t93.*(t521-t564+X14.*(t102-t135))+X13.*t346.*(t521-t564+X14.*(t102-t135)))-rho2_1.*(t737+X18.*t94.*(t523-t566+X17.*(t108-t141))+X17.*t344.*(t523-t566+X17.*(t108-t141)))-rho2_2.*(t739+X17.*t93.*(t523-t566+X17.*(t108-t141))+X16.*t346.*(t523-t566+X17.*(t108-t141)))-rho3_1.*(t746+X21.*t94.*(t525-t568+X20.*(t114-t147))+X20.*t344.*(t525-t568+X20.*(t114-t147)));
et8 = -rho3_2.*(t748+X20.*t93.*(t525-t568+X20.*(t114-t147))+X19.*t346.*(t525-t568+X20.*(t114-t147)))-rho4_1.*(t755+X24.*t94.*(t527-t570+X23.*(t120-t153))+X23.*t344.*(t527-t570+X23.*(t120-t153)))-rho4_2.*(t757+X23.*t93.*(t527-t570+X23.*(t120-t153))+X22.*t346.*(t527-t570+X23.*(t120-t153)))-rho5_1.*(t764+X27.*t94.*(t529-t572+X26.*(t126-t159))+X26.*t344.*(t529-t572+X26.*(t126-t159)))-rho5_2.*(t766+X26.*t93.*(t529-t572+X26.*(t126-t159))+X25.*t346.*(t529-t572+X26.*(t126-t159)));
et9 = -rho6_1.*(t773+X30.*t94.*(t531-t574+X29.*(t132-t165))+X29.*t344.*(t531-t574+X29.*(t132-t165)))-rho6_2.*(t775+X29.*t93.*(t531-t574+X29.*(t132-t165))+X28.*t346.*(t531-t574+X29.*(t132-t165)));
mt1 = [m0+mi1.*t2+mi2.*t5+mi3.*t8+mi4.*t11+mi5.*t14+mi6.*t17,t70,t71,X13.*t635+X16.*t636+X19.*t637+X22.*t638+X25.*t639+X28.*t640,X13.*(t521-t564+X14.*(t102-t135))+X16.*(t523-t566+X17.*(t108-t141))+X19.*(t525-t568+X20.*(t114-t147))+X22.*(t527-t570+X23.*(t120-t153))+X25.*(t529-t572+X26.*(t126-t159))+X28.*(t531-t574+X29.*(t132-t165)),-X13.*t641-X16.*t643-X19.*t645-X22.*t647-X25.*t649-X28.*t651,t70,m0+mi1.*t3+mi2.*t6+mi3.*t9+mi4.*t12+mi5.*t15+mi6.*t18,t69];
mt2 = [-X14.*t635-X17.*t636-X20.*t637-X23.*t638-X26.*t639-X29.*t640,-X14.*(t521-t564+X14.*(t102-t135))-X17.*(t523-t566+X17.*(t108-t141))-X20.*(t525-t568+X20.*(t114-t147))-X23.*(t527-t570+X23.*(t120-t153))-X26.*(t529-t572+X26.*(t126-t159))-X29.*(t531-t574+X29.*(t132-t165)),X14.*t641+X17.*t643+X20.*t645+X23.*t647+X26.*t649+X29.*t651,t71,t69,m0+mi1.*t4+mi2.*t7+mi3.*t10+mi4.*t13+mi5.*t16+mi6.*t19];
mt3 = [-X15.*t635-X18.*t636-X21.*t637-X24.*t638-X27.*t639-X30.*t640,-X15.*(t521-t564+X14.*(t102-t135))-X18.*(t523-t566+X17.*(t108-t141))-X21.*(t525-t568+X20.*(t114-t147))-X24.*(t527-t570+X23.*(t120-t153))-X27.*(t529-t572+X26.*(t126-t159))-X30.*(t531-t574+X29.*(t132-t165)),X15.*t641+X18.*t643+X21.*t645+X24.*t647+X27.*t649+X30.*t651];
mt4 = [-rho1_2.*t581+rho1_3.*t583-rho2_2.*t590+rho2_3.*t592-rho3_2.*t599+rho3_3.*t601-rho4_2.*t608+rho4_3.*t610-rho5_2.*t617+rho5_3.*t619-rho6_2.*t626+rho6_3.*t628,rho1_2.*t586-rho1_3.*t585+rho2_2.*t595-rho2_3.*t594+rho3_2.*t604-rho3_3.*t603+rho4_2.*t613-rho4_3.*t612+rho5_2.*t622-rho5_3.*t621+rho6_2.*t631-rho6_3.*t630,rho1_2.*t588-rho1_3.*t587+rho2_2.*t597-rho2_3.*t596+rho3_2.*t606-rho3_3.*t605+rho4_2.*t615-rho4_3.*t614+rho5_2.*t624-rho5_3.*t623+rho6_2.*t633-rho6_3.*t632,j01-rho1_2.*t871+rho1_3.*t870-rho2_2.*t874+rho2_3.*t873-rho3_2.*t877+rho3_3.*t876-rho4_2.*t880+rho4_3.*t879-rho5_2.*t883+rho5_3.*t882-rho6_2.*t886+rho6_3.*t885];
mt5 = [et1+et2+et3,rho1_2.*t889-rho1_3.*t888+rho2_2.*t895-rho2_3.*t894+rho3_2.*t901-rho3_3.*t900+rho4_2.*t907-rho4_3.*t906+rho5_2.*t913-rho5_3.*t912+rho6_2.*t919-rho6_3.*t918,rho1_1.*t581+rho1_3.*t582+rho2_1.*t590+rho2_3.*t591+rho3_1.*t599+rho3_3.*t600+rho4_1.*t608+rho4_3.*t609+rho5_1.*t617+rho5_3.*t618+rho6_1.*t626+rho6_3.*t627,-rho1_1.*t586-rho1_3.*t584-rho2_1.*t595-rho2_3.*t593-rho3_1.*t604-rho3_3.*t602-rho4_1.*t613-rho4_3.*t611-rho5_1.*t622-rho5_3.*t620-rho6_1.*t631-rho6_3.*t629];
mt6 = [-rho1_1.*t588-rho1_3.*t589-rho2_1.*t597-rho2_3.*t598-rho3_1.*t606-rho3_3.*t607-rho4_1.*t615-rho4_3.*t616-rho5_1.*t624-rho5_3.*t625-rho6_1.*t633-rho6_3.*t634,rho1_1.*t871+rho1_3.*t869+rho2_1.*t874+rho2_3.*t872+rho3_1.*t877+rho3_3.*t875+rho4_1.*t880+rho4_3.*t878+rho5_1.*t883+rho5_3.*t881+rho6_1.*t886+rho6_3.*t884,et4+et5+et6,-rho1_1.*t889-rho1_3.*t887-rho2_1.*t895-rho2_3.*t893-rho3_1.*t901-rho3_3.*t899-rho4_1.*t907-rho4_3.*t905-rho5_1.*t913-rho5_3.*t911-rho6_1.*t919-rho6_3.*t917];
mt7 = [-rho1_1.*t583-rho1_2.*t582-rho2_1.*t592-rho2_2.*t591-rho3_1.*t601-rho3_2.*t600-rho4_1.*t610-rho4_2.*t609-rho5_1.*t619-rho5_2.*t618-rho6_1.*t628-rho6_2.*t627,rho1_1.*t585+rho1_2.*t584+rho2_1.*t594+rho2_2.*t593+rho3_1.*t603+rho3_2.*t602+rho4_1.*t612+rho4_2.*t611+rho5_1.*t621+rho5_2.*t620+rho6_1.*t630+rho6_2.*t629,rho1_1.*t587+rho1_2.*t589+rho2_1.*t596+rho2_2.*t598+rho3_1.*t605+rho3_2.*t607+rho4_1.*t614+rho4_2.*t616+rho5_1.*t623+rho5_2.*t625+rho6_1.*t632+rho6_2.*t634,-rho1_1.*t870-rho1_2.*t869-rho2_1.*t873-rho2_2.*t872-rho3_1.*t876-rho3_2.*t875-rho4_1.*t879-rho4_2.*t878-rho5_1.*t882-rho5_2.*t881-rho6_1.*t885-rho6_2.*t884,et7+et8+et9];
mt8 = [j03+rho1_1.*t888+rho1_2.*t887+rho2_1.*t894+rho2_2.*t893+rho3_1.*t900+rho3_2.*t899+rho4_1.*t906+rho4_2.*t905+rho5_1.*t912+rho5_2.*t911+rho6_1.*t918+rho6_2.*t917];
A = reshape([mt1,mt2,mt3,mt4,mt5,mt6,mt7,mt8],6,6);
end
