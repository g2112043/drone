function out1 = JacobH_param2(in1,in2)
%JacobH_param2
%    OUT1 = JacobH_param2(IN1,IN2)

%    This function was generated by the Symbolic Math Toolbox version 9.3.
%    2023/07/31 18:51:07

x4 = in1(4,:);
x5 = in1(5,:);
x6 = in1(6,:);
x13 = in1(13,:);
x14 = in1(14,:);
x15 = in1(15,:);
x16 = in1(16,:);
x17 = in1(17,:);
x18 = in1(18,:);
x19 = in1(19,:);
x20 = in1(20,:);
x21 = in1(21,:);
x22 = in1(22,:);
t2 = -x22;
t3 = x4./2.0;
t4 = x5./2.0;
t5 = x6./2.0;
t6 = x16./2.0;
t7 = x17./2.0;
t8 = x18./2.0;
t9 = cos(t3);
t10 = cos(t4);
t11 = cos(t5);
t12 = cos(t6);
t13 = cos(t7);
t14 = cos(t8);
t15 = sin(t3);
t16 = sin(t4);
t17 = sin(t5);
t18 = sin(t6);
t19 = sin(t7);
t20 = sin(t8);
t21 = t9.*t10.*t11;
t22 = t12.*t13.*t14;
t23 = t9.*t10.*t17;
t24 = t9.*t11.*t16;
t25 = t10.*t11.*t15;
t26 = t12.*t13.*t20;
t27 = t12.*t14.*t19;
t28 = t13.*t14.*t18;
t29 = t9.*t16.*t17;
t30 = t10.*t15.*t17;
t31 = t11.*t15.*t16;
t32 = t12.*t19.*t20;
t33 = t13.*t18.*t20;
t34 = t14.*t18.*t19;
t35 = t15.*t16.*t17;
t36 = t18.*t19.*t20;
t37 = -t29;
t38 = -t31;
t39 = -t32;
t40 = -t34;
t41 = t21./2.0;
t42 = t22./2.0;
t43 = t23./2.0;
t44 = t24./2.0;
t45 = t25./2.0;
t46 = t26./2.0;
t47 = t27./2.0;
t48 = t28./2.0;
t49 = t29./2.0;
t50 = t30./2.0;
t51 = t31./2.0;
t52 = t32./2.0;
t53 = t33./2.0;
t54 = t34./2.0;
t55 = t35./2.0;
t56 = t36./2.0;
t65 = t21+t35;
t66 = t24+t30;
t67 = t22+t36;
t68 = t27+t33;
t57 = -t49;
t58 = -t50;
t59 = -t51;
t60 = -t52;
t61 = -t53;
t62 = -t54;
t63 = -t55;
t64 = -t56;
t69 = t65.^2;
t70 = t66.^2;
t71 = t67.^2;
t72 = t68.^2;
t73 = t23+t38;
t74 = t25+t37;
t75 = t26+t40;
t76 = t28+t39;
t81 = t41+t55;
t82 = t43+t51;
t83 = t44+t50;
t84 = t45+t49;
t85 = t42+t56;
t86 = t46+t54;
t87 = t47+t53;
t88 = t48+t52;
t77 = t73.^2;
t78 = t74.^2;
t79 = t75.^2;
t80 = t76.^2;
t89 = t41+t63;
t90 = t43+t59;
t91 = t44+t58;
t92 = t45+t57;
t93 = t42+t64;
t94 = t46+t62;
t95 = t47+t61;
t96 = t48+t60;
t112 = t73.*t81.*2.0;
t113 = t73.*t83.*2.0;
t114 = t73.*t84.*2.0;
t115 = t74.*t81.*2.0;
t116 = t74.*t82.*2.0;
t117 = t74.*t83.*2.0;
t121 = t75.*t85.*2.0;
t122 = t75.*t87.*2.0;
t123 = t75.*t88.*2.0;
t124 = t76.*t85.*2.0;
t125 = t76.*t86.*2.0;
t126 = t76.*t87.*2.0;
t97 = t65.*t90.*2.0;
t98 = t65.*t91.*2.0;
t99 = t65.*t92.*2.0;
t100 = t66.*t89.*2.0;
t101 = t66.*t90.*2.0;
t102 = t66.*t92.*2.0;
t103 = t67.*t94.*2.0;
t104 = t67.*t95.*2.0;
t105 = t67.*t96.*2.0;
t106 = t68.*t93.*2.0;
t107 = t68.*t94.*2.0;
t108 = t68.*t96.*2.0;
t127 = -t112;
t128 = -t115;
t129 = -t121;
t130 = -t124;
t131 = t69+t70+t77+t78;
t132 = t71+t72+t79+t80;
t109 = -t100;
t110 = -t101;
t111 = -t102;
t118 = -t106;
t119 = -t107;
t120 = -t108;
t133 = 1.0./t131;
t135 = 1.0./t132;
t134 = t133.^2;
t136 = t135.^2;
t137 = t69.*t133;
t138 = t70.*t133;
t139 = t71.*t135;
t140 = t72.*t135;
t141 = t77.*t133;
t142 = t78.*t133;
t144 = t79.*t135;
t145 = t80.*t135;
t151 = t65.*t66.*t133.*2.0;
t152 = t67.*t68.*t135.*2.0;
t153 = t65.*t73.*t133.*2.0;
t154 = t65.*t74.*t133.*2.0;
t155 = t66.*t73.*t133.*2.0;
t156 = t66.*t74.*t133.*2.0;
t157 = t67.*t75.*t135.*2.0;
t158 = t67.*t76.*t135.*2.0;
t159 = t68.*t75.*t135.*2.0;
t160 = t68.*t76.*t135.*2.0;
t164 = t73.*t74.*t133.*2.0;
t165 = t75.*t76.*t135.*2.0;
t168 = t65.*t81.*t133.*2.0;
t169 = t65.*t82.*t133.*2.0;
t170 = t65.*t83.*t133.*2.0;
t171 = t65.*t84.*t133.*2.0;
t172 = t66.*t81.*t133.*2.0;
t173 = t66.*t82.*t133.*2.0;
t174 = t66.*t83.*t133.*2.0;
t175 = t66.*t84.*t133.*2.0;
t176 = t67.*t85.*t135.*2.0;
t177 = t67.*t86.*t135.*2.0;
t178 = t67.*t87.*t135.*2.0;
t179 = t67.*t88.*t135.*2.0;
t180 = t68.*t85.*t135.*2.0;
t181 = t68.*t86.*t135.*2.0;
t182 = t68.*t87.*t135.*2.0;
t183 = t68.*t88.*t135.*2.0;
t184 = t65.*t89.*t133.*2.0;
t185 = t97.*t133;
t186 = t98.*t133;
t188 = t99.*t133;
t189 = t100.*t133;
t190 = t101.*t133;
t192 = t66.*t91.*t133.*2.0;
t194 = t102.*t133;
t196 = t67.*t93.*t135.*2.0;
t197 = t103.*t135;
t198 = t104.*t135;
t200 = t105.*t135;
t201 = t106.*t135;
t202 = t107.*t135;
t204 = t68.*t95.*t135.*2.0;
t206 = t108.*t135;
t207 = t65.*t91.*t133.*-2.0;
t208 = t66.*t90.*t133.*-2.0;
t210 = t66.*t92.*t133.*-2.0;
t211 = t112.*t133;
t212 = t73.*t82.*t133.*2.0;
t213 = t113.*t133;
t214 = t114.*t133;
t215 = t115.*t133;
t216 = t116.*t133;
t217 = t117.*t133;
t218 = t74.*t84.*t133.*2.0;
t219 = t67.*t95.*t135.*-2.0;
t220 = t68.*t94.*t135.*-2.0;
t222 = t68.*t96.*t135.*-2.0;
t223 = t121.*t135;
t224 = t75.*t86.*t135.*2.0;
t225 = t122.*t135;
t226 = t123.*t135;
t227 = t124.*t135;
t228 = t125.*t135;
t229 = t126.*t135;
t230 = t76.*t88.*t135.*2.0;
t231 = t73.*t89.*t133.*2.0;
t233 = t73.*t90.*t133.*2.0;
t235 = t73.*t91.*t133.*2.0;
t236 = t73.*t83.*t133.*-2.0;
t237 = t73.*t92.*t133.*2.0;
t238 = t73.*t84.*t133.*-2.0;
t239 = t74.*t89.*t133.*2.0;
t241 = t74.*t90.*t133.*2.0;
t242 = t74.*t82.*t133.*-2.0;
t243 = t74.*t91.*t133.*2.0;
t244 = t74.*t83.*t133.*-2.0;
t245 = t74.*t92.*t133.*2.0;
t247 = t75.*t93.*t135.*2.0;
t249 = t75.*t94.*t135.*2.0;
t250 = t75.*t95.*t135.*2.0;
t251 = t75.*t87.*t135.*-2.0;
t252 = t75.*t96.*t135.*2.0;
t253 = t75.*t88.*t135.*-2.0;
t254 = t76.*t93.*t135.*2.0;
t256 = t76.*t94.*t135.*2.0;
t257 = t76.*t95.*t135.*2.0;
t258 = t76.*t87.*t135.*-2.0;
t259 = t76.*t96.*t135.*2.0;
t272 = t98+t109+t114+t116;
t273 = t104+t118+t123+t125;
t274 = t97+t111+t117+t127;
t275 = t99+t110+t113+t128;
t276 = t103+t120+t126+t129;
t277 = t105+t119+t122+t130;
t143 = -t138;
t146 = -t140;
t147 = -t141;
t148 = -t142;
t149 = -t144;
t150 = -t145;
t161 = -t155;
t162 = -t156;
t163 = -t160;
t166 = -t164;
t167 = -t165;
t187 = -t170;
t191 = -t173;
t193 = -t174;
t195 = -t175;
t199 = -t178;
t203 = -t181;
t205 = -t182;
t209 = -t192;
t221 = -t204;
t234 = -t212;
t246 = -t218;
t260 = -t231;
t261 = -t233;
t262 = -t237;
t263 = -t239;
t264 = -t241;
t265 = -t245;
t266 = -t247;
t267 = -t249;
t268 = -t252;
t269 = -t254;
t270 = -t256;
t271 = -t259;
t278 = t151+t164;
t279 = t153+t156;
t280 = t154+t155;
t281 = t157+t160;
t282 = t158+t159;
t306 = t69.*t134.*t272;
t307 = t70.*t134.*t272;
t308 = t71.*t136.*t273;
t309 = t72.*t136.*t273;
t310 = t69.*t134.*t274;
t311 = t69.*t134.*t275;
t312 = t70.*t134.*t274;
t313 = t70.*t134.*t275;
t314 = t71.*t136.*t276;
t315 = t71.*t136.*t277;
t316 = t72.*t136.*t276;
t317 = t72.*t136.*t277;
t318 = t77.*t134.*t272;
t319 = t78.*t134.*t272;
t321 = t79.*t136.*t273;
t322 = t80.*t136.*t273;
t324 = t77.*t134.*t274;
t325 = t77.*t134.*t275;
t326 = t78.*t134.*t274;
t327 = t78.*t134.*t275;
t332 = t79.*t136.*t276;
t333 = t79.*t136.*t277;
t334 = t80.*t136.*t276;
t335 = t80.*t136.*t277;
t350 = t65.*t66.*t134.*t272.*2.0;
t351 = t67.*t68.*t136.*t273.*2.0;
t352 = t65.*t66.*t134.*t274.*2.0;
t353 = t65.*t66.*t134.*t275.*2.0;
t354 = t67.*t68.*t136.*t276.*2.0;
t355 = t67.*t68.*t136.*t277.*2.0;
t356 = t65.*t73.*t134.*t272.*2.0;
t357 = t65.*t74.*t134.*t272.*2.0;
t358 = t66.*t73.*t134.*t272.*2.0;
t359 = t66.*t74.*t134.*t272.*2.0;
t360 = t67.*t75.*t136.*t273.*2.0;
t361 = t67.*t76.*t136.*t273.*2.0;
t362 = t68.*t75.*t136.*t273.*2.0;
t363 = t68.*t76.*t136.*t273.*2.0;
t364 = t65.*t73.*t134.*t274.*2.0;
t366 = t65.*t73.*t134.*t275.*2.0;
t367 = t65.*t74.*t134.*t274.*2.0;
t369 = t65.*t74.*t134.*t275.*2.0;
t370 = t66.*t73.*t134.*t274.*2.0;
t372 = t66.*t73.*t134.*t275.*2.0;
t373 = t66.*t74.*t134.*t274.*2.0;
t375 = t66.*t74.*t134.*t275.*2.0;
t376 = t67.*t75.*t136.*t276.*2.0;
t378 = t67.*t75.*t136.*t277.*2.0;
t379 = t67.*t76.*t136.*t276.*2.0;
t381 = t67.*t76.*t136.*t277.*2.0;
t382 = t68.*t75.*t136.*t276.*2.0;
t384 = t68.*t75.*t136.*t277.*2.0;
t385 = t68.*t76.*t136.*t276.*2.0;
t387 = t68.*t76.*t136.*t277.*2.0;
t392 = t73.*t74.*t134.*t272.*2.0;
t395 = t75.*t76.*t136.*t273.*2.0;
t396 = t73.*t74.*t134.*t274.*2.0;
t398 = t73.*t74.*t134.*t275.*2.0;
t399 = t75.*t76.*t136.*t276.*2.0;
t401 = t75.*t76.*t136.*t277.*2.0;
t283 = t151+t166;
t284 = t153+t162;
t285 = t154+t161;
t286 = t152+t167;
t287 = t157+t163;
t288 = t279.*x13;
t289 = t280.*x14;
t290 = t278.*x15;
t291 = t278.*x19;
t292 = t279.*x20;
t293 = t280.*x21;
t320 = -t306;
t323 = -t308;
t328 = -t310;
t329 = -t311;
t330 = -t312;
t331 = -t313;
t336 = -t314;
t337 = -t315;
t338 = -t316;
t339 = -t317;
t340 = -t318;
t341 = -t319;
t342 = -t321;
t343 = -t322;
t345 = -t325;
t346 = -t326;
t348 = -t334;
t365 = -t356;
t368 = -t357;
t371 = -t358;
t374 = -t359;
t377 = -t360;
t380 = -t361;
t383 = -t362;
t386 = -t363;
t388 = -t366;
t389 = -t367;
t390 = -t372;
t391 = -t373;
t393 = -t378;
t394 = -t385;
t397 = -t392;
t400 = -t395;
t406 = t137+t138+t147+t148;
t407 = t137+t141+t143+t148;
t408 = t137+t142+t143+t147;
t409 = t139+t140+t149+t150;
t410 = t139+t145+t146+t149;
t417 = t280.*t281;
t426 = t278.*t282.*1.745240643728351e-2;
t466 = t184+t209+t234+t246+t350+t392;
t477 = t168+t193+t245+t261+t364+t373;
t478 = t168+t193+t233+t265+t369+t372;
t480 = t172+t187+t241+t262+t366+t375;
t481 = t172+t187+t237+t264+t367+t370;
t482 = t188+t208+t215+t236+t352+t396;
t483 = t176+t205+t259+t267+t376+t385;
t484 = t176+t205+t249+t271+t381+t384;
t485 = t180+t199+t256+t268+t378+t387;
t486 = t180+t199+t252+t270+t379+t382;
t503 = x15.*(t210+t211+t244+t353+t398+t65.*t90.*t133.*2.0);
t294 = t283.*x13;
t295 = t284.*x14;
t296 = t285.*x15;
t297 = t284.*x19;
t298 = t285.*x20;
t299 = t283.*x21;
t411 = t408.*x13;
t412 = t406.*x14;
t413 = t407.*x15;
t414 = t408.*x19;
t415 = t406.*x20;
t416 = t407.*x21;
t418 = t278.*t286;
t419 = t281.*t284;
t420 = t285.*t286;
t421 = -t417;
t422 = t417.*9.998476951563913e-1;
t427 = -t426;
t428 = t279.*t287.*1.745240643728351e-2;
t429 = t282.*t285.*1.745240643728351e-2;
t430 = t283.*t287.*1.745240643728351e-2;
t433 = t281.*t406;
t434 = t279.*t410;
t435 = t286.*t407;
t436 = t283.*t410;
t443 = t282.*t407.*1.745240643728351e-2;
t444 = t280.*t409.*1.745240643728351e-2;
t445 = t287.*t408.*1.745240643728351e-2;
t446 = t284.*t409.*1.745240643728351e-2;
t447 = t408.*t410;
t451 = t406.*t409.*1.745240643728351e-2;
t461 = t184+t209+t212+t218+t350+t397;
t462 = t169+t195+t231+t243+t358+t368;
t463 = t171+t191+t235+t239+t359+t365;
t464 = t196+t221+t224+t230+t351+t400;
t465 = t179+t203+t250+t254+t363+t377;
t467 = t169+t175+t243+t260+t368+t371;
t468 = t170+t172+t237+t241+t375+t388;
t469 = t170+t172+t237+t241+t370+t389;
t470 = t171+t173+t235+t263+t365+t374;
t471 = t177+t183+t257+t266+t380+t383;
t472 = t178+t180+t252+t256+t387+t393;
t473 = t179+t181+t250+t269+t377+t386;
t490 = t466.*x15;
t492 = t168+t174+t261+t265+t364+t391;
t493 = t168+t174+t261+t265+t369+t390;
t496 = t176+t182+t267+t271+t376+t394;
t499 = t477.*x13;
t500 = t480.*x13;
t501 = t478.*x14;
t502 = t481.*x14;
t504 = t482.*x15;
t514 = t189+t207+t214+t216+t306+t307+t340+t341;
t515 = t186+t189+t216+t238+t307+t318+t320+t341;
t516 = t186+t189+t214+t242+t307+t319+t320+t340;
t517 = t201+t219+t226+t228+t308+t309+t342+t343;
t518 = t198+t201+t228+t253+t309+t321+t323+t343;
t522 = t185+t194+t211+t217+t312+t324+t328+t346;
t523 = t188+t190+t213+t215+t313+t327+t329+t345;
t524 = t197+t206+t223+t229+t316+t332+t336+t348;
t528 = t185+t210+t211+t244+t324+t326+t328+t330;
t530 = t188+t208+t215+t236+t325+t327+t329+t331;
t532 = t197+t222+t223+t258+t332+t334+t336+t338;
t533 = t200+t220+t227+t251+t333+t335+t337+t339;
t539 = x13.*(t208+t213+t215+t311+t327+t331+t345-t65.*t92.*t133.*2.0);
t300 = -t294;
t301 = -t295;
t302 = -t296;
t303 = -t297;
t304 = -t298;
t305 = -t299;
t423 = t418.*9.998476951563913e-1;
t424 = t419.*9.998476951563913e-1;
t425 = t420.*9.998476951563913e-1;
t431 = -t428;
t432 = -t429;
t437 = t433.*9.998476951563913e-1;
t438 = t434.*9.998476951563913e-1;
t439 = t435.*9.998476951563913e-1;
t440 = t436.*9.998476951563913e-1;
t448 = -t447;
t449 = t447.*9.998476951563913e-1;
t474 = t461.*x13;
t475 = t463.*x14;
t476 = t462.*x15;
t487 = t470.*x13;
t488 = t467.*x14;
t489 = t468.*x14;
out1 = ft_1({t133,t135,t190,t194,t2,t202,t206,t208,t210,t211,t213,t215,t217,t220,t223,t225,t227,t236,t244,t251,t258,t278,t279,t280,t281,t282,t283,t284,t285,t286,t287,t288,t289,t290,t291,t292,t293,t300,t301,t302,t303,t304,t305,t310,t311,t315,t324,t327,t330,t331,t333,t335,t339,t345,t346,t352,t353,t354,t355,t396,t398,t399,t401,t406,t407,t408,t409,t410,t411,t412,t413,t414,t415,t416,t418,t419,t420,t421,t422,t423,t424,t425,t427,t430,t431,t432,t433,t434,t435,t436,t437,t438,t439,t440,t443,t444,t445,t446,t448,t449,t451,t461,t462,t463,t464,t465,t466,t467,t468,t469,t470,t471,t472,t473,t474,t475,t476,t477,t478,t480,t481,t482,t483,t484,t485,t486,t487,t488,t489,t490,t492,t493,t496,t499,t500,t501,t502,t503,t504,t514,t515,t516,t517,t518,t522,t523,t524,t528,t530,t532,t533,t539,t65,t67,t90,t92,t94,t96,x13,x14,x15,x19,x20,x21});
end
function out1 = ft_1(ct)
[t133,t135,t190,t194,t2,t202,t206,t208,t210,t211,t213,t215,t217,t220,t223,t225,t227,t236,t244,t251,t258,t278,t279,t280,t281,t282,t283,t284,t285,t286,t287,t288,t289,t290,t291,t292,t293,t300,t301,t302,t303,t304,t305,t310,t311,t315,t324,t327,t330,t331,t333,t335,t339,t345,t346,t352,t353,t354,t355,t396,t398,t399,t401,t406,t407,t408,t409,t410,t411,t412,t413,t414,t415,t416,t418,t419,t420,t421,t422,t423,t424,t425,t427,t430,t431,t432,t433,t434,t435,t436,t437,t438,t439,t440,t443,t444,t445,t446,t448,t449,t451,t461,t462,t463,t464,t465,t466,t467,t468,t469,t470,t471,t472,t473,t474,t475,t476,t477,t478,t480,t481,t482,t483,t484,t485,t486,t487,t488,t489,t490,t492,t493,t496,t499,t500,t501,t502,t503,t504,t514,t515,t516,t517,t518,t522,t523,t524,t528,t530,t532,t533,t539,t65,t67,t90,t92,t94,t96,x13,x14,x15,x19,x20,x21] = ct{:};
t491 = t469.*x15;
t507 = t492.*x14;
t509 = t493.*x15;
t510 = -t500;
t513 = -t504;
t519 = t515.*x13;
t520 = t514.*x14;
t521 = t516.*x15;
t526 = t522.*x13;
t527 = t523.*x15;
t536 = t528.*x14;
t537 = t530.*x14;
t541 = t420+t433+t434;
t544 = t421+t435+t436;
t441 = -t439;
t442 = -t440;
t450 = -t449;
t452 = t288+t302+t412;
t453 = t289+t300+t413;
t454 = t290+t301+t411;
t455 = t291+t304+t416;
t456 = t292+t305+t414;
t457 = t293+t303+t415;
t508 = -t487;
t525 = -t519;
t540 = -t536;
t542 = t541.*x20;
t543 = t418+t419+t448;
t547 = t544.*x21;
t551 = t425+t431+t432+t437+t438+t451;
t556 = t474+t488+t521;
t563 = t507+t513+t526;
t565 = t489+t503+t539;
t571 = t509+t510+t537;
t458 = t454.*x19;
t459 = t452.*x20;
t460 = t453.*x21;
t545 = t543.*x19;
t546 = -t542;
t549 = t423+t424+t427+t445+t446+t450;
t550 = t422+t430+t441+t442+t443+t444;
t553 = t551.*x20;
t557 = t556.*x21;
t558 = t476+t508+t520;
t559 = t475+t490+t525;
t566 = t491+t499+t540;
t567 = t563.*x19;
t568 = t565.*x19;
t573 = t571.*x20;
t548 = t2+t458+t459+t460;
t552 = t549.*x19;
t554 = t550.*x21;
t560 = t559.*x19;
t561 = t558.*x20;
t562 = -t557;
t569 = t566.*x20;
t577 = t545+t546+t547;
t555 = -t552;
t578 = 1.0./t577;
t583 = t560+t561+t562;
t579 = t578.^2;
t580 = t553+t554+t555;
t581 = 1.0./t580;
t582 = t581.^2;
et1 = t287.*(t208+t213+t215+t311+t327+t331+t345-t65.*t92.*t133.*2.0).*(-1.745240643728351e-2)+t410.*(t208+t213+t215+t311+t327+t331+t345-t65.*t92.*t133.*2.0).*9.998476951563913e-1+t282.*(t210+t211+t244+t353+t398+t65.*t90.*t133.*2.0).*1.745240643728351e-2-t286.*(t210+t211+t244+t353+t398+t65.*t90.*t133.*2.0).*9.998476951563913e-1;
et2 = t281.*t468.*9.998476951563913e-1+t409.*t468.*1.745240643728351e-2;
et3 = t281.*t478.*9.998476951563913e-1-t282.*t523.*1.745240643728351e-2+t286.*t523.*9.998476951563913e-1+t409.*t478.*1.745240643728351e-2;
et4 = t287.*(t194+t211+t244-t353+t398-t65.*t90.*t133.*2.0).*(-1.745240643728351e-2)+t410.*(t194+t211+t244-t353+t398-t65.*t90.*t133.*2.0).*9.998476951563913e-1;
et5 = t287.*t480.*1.745240643728351e-2+t282.*t493.*1.745240643728351e-2-t286.*t493.*9.998476951563913e-1+t281.*t530.*9.998476951563913e-1-t410.*t480.*9.998476951563913e-1;
et6 = t409.*t530.*1.745240643728351e-2;
et7 = t281.*t463.*9.998476951563913e-1+t282.*t466.*1.745240643728351e-2-t286.*t466.*9.998476951563913e-1+t287.*t515.*1.745240643728351e-2+t409.*t463.*1.745240643728351e-2;
et8 = t410.*t515.*(-9.998476951563913e-1);
et9 = t281.*t467.*9.998476951563913e-1-t287.*t461.*1.745240643728351e-2+t282.*t516.*1.745240643728351e-2-t286.*t516.*9.998476951563913e-1+t410.*t461.*9.998476951563913e-1;
et10 = t409.*t467.*1.745240643728351e-2;
et11 = t282.*t462.*1.745240643728351e-2-t286.*t462.*9.998476951563913e-1+t287.*t470.*1.745240643728351e-2+t281.*t514.*9.998476951563913e-1-t410.*t470.*9.998476951563913e-1;
et12 = t409.*t514.*1.745240643728351e-2;
et13 = t282.*t469.*(-1.745240643728351e-2)+t286.*t469.*9.998476951563913e-1+t287.*t477.*1.745240643728351e-2+t281.*t528.*9.998476951563913e-1-t410.*t477.*9.998476951563913e-1;
et14 = t409.*t528.*1.745240643728351e-2;
et15 = t282.*t482.*(-1.745240643728351e-2)+t286.*t482.*9.998476951563913e-1+t281.*t492.*9.998476951563913e-1-t287.*t522.*1.745240643728351e-2+t409.*t492.*1.745240643728351e-2;
et16 = t410.*t522.*9.998476951563913e-1;
et17 = t282.*(t210+t211+t217+t310+t324+t330+t346-t65.*t90.*t133.*2.0).*1.745240643728351e-2-t286.*(t210+t211+t217+t310+t324+t330+t346-t65.*t90.*t133.*2.0).*9.998476951563913e-1+t281.*t481.*9.998476951563913e-1+t409.*t481.*1.745240643728351e-2;
et18 = t287.*(t190+t215+t236-t352+t396-t65.*t92.*t133.*2.0).*(-1.745240643728351e-2)+t410.*(t190+t215+t236-t352+t396-t65.*t92.*t133.*2.0).*9.998476951563913e-1;
et19 = t278.*t484.*1.745240643728351e-2-t284.*t485.*9.998476951563913e-1+t284.*t533.*1.745240643728351e-2+t408.*t472.*1.745240643728351e-2;
et20 = t408.*(t220+t225+t227+t315-t333+t335+t339-t67.*t96.*t135.*2.0).*9.998476951563913e-1+t278.*(t206+t223+t258-t355+t401-t67.*t94.*t135.*2.0).*9.998476951563913e-1;
et21 = t279.*t472.*1.745240643728351e-2-t285.*t484.*1.745240643728351e-2+t406.*t485.*9.998476951563913e-1-t406.*t533.*1.745240643728351e-2;
et22 = t279.*(t220+t225+t227+t315-t333+t335+t339-t67.*t96.*t135.*2.0).*9.998476951563913e-1-t285.*(t206+t223+t258-t355+t401-t67.*t94.*t135.*2.0).*9.998476951563913e-1;
et23 = t283.*t472.*1.745240643728351e-2-t280.*t485.*9.998476951563913e-1+t280.*t533.*1.745240643728351e-2-t407.*t484.*1.745240643728351e-2;
et24 = t283.*(t220+t225+t227+t315-t333+t335+t339-t67.*t96.*t135.*2.0).*9.998476951563913e-1-t407.*(t206+t223+t258-t355+t401-t67.*t94.*t135.*2.0).*9.998476951563913e-1;
et25 = t278.*t464.*9.998476951563913e-1+t278.*t471.*1.745240643728351e-2-t284.*t473.*9.998476951563913e-1+t284.*t517.*1.745240643728351e-2-t408.*t465.*1.745240643728351e-2;
et26 = t408.*t518.*9.998476951563913e-1;
et27 = t279.*t465.*1.745240643728351e-2+t285.*t464.*9.998476951563913e-1+t285.*t471.*1.745240643728351e-2-t279.*t518.*9.998476951563913e-1-t406.*t473.*9.998476951563913e-1;
et28 = t406.*t517.*1.745240643728351e-2;
et29 = t283.*t465.*1.745240643728351e-2+t280.*t473.*9.998476951563913e-1-t280.*t517.*1.745240643728351e-2-t283.*t518.*9.998476951563913e-1+t407.*t464.*9.998476951563913e-1;
et30 = t407.*t471.*1.745240643728351e-2;
et31 = t278.*t486.*1.745240643728351e-2-t284.*t483.*9.998476951563913e-1+t284.*t532.*1.745240643728351e-2-t408.*t496.*1.745240643728351e-2-t408.*t524.*9.998476951563913e-1;
et32 = t278.*(t202+t227+t251-t354+t399-t67.*t96.*t135.*2.0).*9.998476951563913e-1;
et33 = t285.*t486.*1.745240643728351e-2+t279.*t496.*1.745240643728351e-2+t279.*t524.*9.998476951563913e-1-t406.*t483.*9.998476951563913e-1+t406.*t532.*1.745240643728351e-2;
et34 = t285.*(t202+t227+t251-t354+t399-t67.*t96.*t135.*2.0).*9.998476951563913e-1;
et35 = t280.*t483.*9.998476951563913e-1+t283.*t496.*1.745240643728351e-2+t283.*t524.*9.998476951563913e-1-t280.*t532.*1.745240643728351e-2+t407.*t486.*1.745240643728351e-2;
et36 = t407.*(t202+t227+t251-t354+t399-t67.*t96.*t135.*2.0).*9.998476951563913e-1;
mt1 = [1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,t578.*(t568-t573+x21.*(t501-t527+x13.*(t194+t211+t244-t353+t398-t65.*t90.*t133.*2.0)))+t548.*t579.*(x20.*(t286.*t493-t281.*t530+t410.*t480)+x21.*(t281.*t478+t286.*t523+t410.*(t194+t211+t244-t353+t398-t65.*t90.*t133.*2.0))+x19.*(t410.*(t208+t213+t215+t311+t327+t331+t345-t65.*t92.*t133.*2.0)-t286.*(t210+t211+t244+t353+t398+t65.*t90.*t133.*2.0)+t281.*t468))];
mt2 = [-t581.*(t568-t573+x21.*(t501-t527+x13.*(t194+t211+t244-t353+t398-t65.*t90.*t133.*2.0)))+t548.*t582.*(x19.*(et1+et2)+x21.*(et3+et4)-x20.*(et5+et6)),0.0,0.0,0.0,0.0,1.0,0.0,t578.*t583-t548.*t579.*(x19.*(-t281.*t463+t286.*t466+t410.*t515)+x21.*(t281.*t467-t286.*t516+t410.*t461)+x20.*(t286.*t462-t281.*t514+t410.*t470)),-t581.*t583+t548.*t582.*(x19.*(et7+et8)-x21.*(et9+et10)+x20.*(et11+et12)),0.0,0.0,0.0,0.0,0.0,1.0];
mt3 = [t578.*(-t567+t569+x21.*(t502+x15.*(t210+t211+t217+t310+t324+t330+t346-t65.*t90.*t133.*2.0)+x13.*(t190+t215+t236-t352+t396-t65.*t92.*t133.*2.0)))-t548.*t579.*(x20.*(t286.*t469+t281.*t528-t410.*t477)+x19.*(t286.*t482+t281.*t492+t410.*t522)-x21.*(-t286.*(t210+t211+t217+t310+t324+t330+t346-t65.*t90.*t133.*2.0)+t281.*t481+t410.*(t190+t215+t236-t352+t396-t65.*t92.*t133.*2.0))),-t581.*(-t567+t569+x21.*(t502+x15.*(t210+t211+t217+t310+t324+t330+t346-t65.*t90.*t133.*2.0)+x13.*(t190+t215+t236-t352+t396-t65.*t92.*t133.*2.0)))-t548.*t582.*(x20.*(et13+et14)+x19.*(et15+et16)-x21.*(et17+et18)),0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0];
mt4 = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,t456.*t578,-t456.*t581,0.0,0.0,0.0,0.0,0.0,0.0,t457.*t578,-t457.*t581,0.0,0.0,0.0,0.0,0.0,0.0,t455.*t578,-t455.*t581,0.0,0.0,0.0,0.0,0.0,0.0];
mt5 = [t548.*t579.*(x19.*(-t284.*t485+t408.*(t220+t225+t227+t315-t333+t335+t339-t67.*t96.*t135.*2.0)+t278.*(t206+t223+t258-t355+t401-t67.*t94.*t135.*2.0))+x20.*(t406.*t485+t279.*(t220+t225+t227+t315-t333+t335+t339-t67.*t96.*t135.*2.0)-t285.*(t206+t223+t258-t355+t401-t67.*t94.*t135.*2.0))+x21.*(t280.*t485-t283.*(t220+t225+t227+t315-t333+t335+t339-t67.*t96.*t135.*2.0)+t407.*(t206+t223+t258-t355+t401-t67.*t94.*t135.*2.0))),t548.*t582.*(x19.*(et19+et20)+x20.*(et21+et22)-x21.*(et23+et24)),0.0,0.0,0.0,0.0,0.0,0.0];
mt6 = [-t548.*t579.*(x19.*(t278.*t464-t284.*t473+t408.*t518)+x20.*(-t285.*t464+t279.*t518+t406.*t473)+x21.*(t280.*t473-t283.*t518+t407.*t464)),-t548.*t582.*(x19.*(et25+et26)-x20.*(et27+et28)+x21.*(et29+et30)),0.0,0.0,0.0,0.0,0.0,0.0,-t548.*t579.*(x19.*(t284.*t483+t408.*t524-t278.*(t202+t227+t251-t354+t399-t67.*t96.*t135.*2.0))+x20.*(t279.*t524-t406.*t483+t285.*(t202+t227+t251-t354+t399-t67.*t96.*t135.*2.0))-x21.*(t280.*t483+t283.*t524+t407.*(t202+t227+t251-t354+t399-t67.*t96.*t135.*2.0))),t548.*t582.*(x19.*(et31+et32)-x20.*(et33+et34)+x21.*(et35+et36)),0.0,0.0,0.0,0.0,0.0,0.0];
mt7 = [t454.*t578-t543.*t548.*t579,-t454.*t581-t548.*t549.*t582,0.0,0.0,0.0,0.0,0.0,0.0,t452.*t578+t541.*t548.*t579,-t452.*t581+t548.*t551.*t582,0.0,0.0,0.0,0.0,0.0,0.0,t453.*t578-t544.*t548.*t579,-t453.*t581+t548.*t550.*t582,0.0,0.0,0.0,0.0,0.0,0.0,-t578,t581];
out1 = reshape([mt1,mt2,mt3,mt4,mt5,mt6,mt7],8,22);
end
