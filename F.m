function dxf = F(in1,in2)
%F
%    DXF = F(IN1,IN2)

%    This function was generated by the Symbolic Math Toolbox version 8.7.
%    27-Jun-2022 18:45:23

dp1 = in1(8,:);
dp2 = in1(9,:);
dp3 = in1(10,:);
gravity = in2(:,9);
jx = in2(:,6);
jy = in2(:,7);
jz = in2(:,8);
o1 = in1(11,:);
o2 = in1(12,:);
o3 = in1(13,:);
q0 = in1(1,:);
q1 = in1(2,:);
q2 = in1(3,:);
q3 = in1(4,:);
dxf = [o1.*q1.*(-1.0./2.0)-(o2.*q2)./2.0-(o3.*q3)./2.0;(o1.*q0)./2.0-(o2.*q3)./2.0+(o3.*q2)./2.0;(o2.*q0)./2.0+(o1.*q3)./2.0-(o3.*q1)./2.0;o1.*q2.*(-1.0./2.0)+(o2.*q1)./2.0+(o3.*q0)./2.0;dp1;dp2;dp3;0.0;0.0;-gravity;(jy.*o2.*o3-jz.*o2.*o3)./jx;-(jx.*o1.*o3-jz.*o1.*o3)./jy;(jx.*o1.*o2-jy.*o1.*o2)./jz];
