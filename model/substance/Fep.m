function dxf = Fep(in1,in2)
%Fep
%    DXF = Fep(IN1,IN2)

%    This function was generated by the Symbolic Math Toolbox version 9.3.
%    2023/06/15 12:08:18

Tr = in1(14,:);
dTr = in1(15,:);
dp1 = in1(8,:);
dp2 = in1(9,:);
dp3 = in1(10,:);
gravity = in2(:,9);
jx = in2(:,6);
jy = in2(:,7);
jz = in2(:,8);
m = in2(:,1);
o1 = in1(11,:);
o2 = in1(12,:);
o3 = in1(13,:);
q0 = in1(1,:);
q1 = in1(2,:);
q2 = in1(3,:);
q3 = in1(4,:);
t2 = 1.0./m;
dxf = [o1.*q1.*(-1.0./2.0)-(o2.*q2)./2.0-(o3.*q3)./2.0;(o1.*q0)./2.0-(o2.*q3)./2.0+(o3.*q2)./2.0;(o2.*q0)./2.0+(o1.*q3)./2.0-(o3.*q1)./2.0;o1.*q2.*(-1.0./2.0)+(o2.*q1)./2.0+(o3.*q0)./2.0;dp1;dp2;dp3;Tr.*t2.*(q0.*q2.*2.0+q1.*q3.*2.0);-Tr.*t2.*(q0.*q1.*2.0-q2.*q3.*2.0);-gravity+Tr.*t2.*(q0.^2-q1.^2-q2.^2+q3.^2);(jy.*o2.*o3-jz.*o2.*o3)./jx;-(jx.*o1.*o3-jz.*o1.*o3)./jy;(jx.*o1.*o2-jy.*o1.*o2)./jz;dTr;0.0];
end
