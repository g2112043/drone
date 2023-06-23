function A = estps(in1)
%ESTPS
%    A = ESTPS(IN1)

%    This function was generated by the Symbolic Math Toolbox version 9.3.
%    2023/06/17 13:07:50

pb1 = in1(:,1);
pb2 = in1(:,2);
pb3 = in1(:,3);
qb1 = in1(:,4);
qb2 = in1(:,5);
qb3 = in1(:,6);
y = in1(:,7);
t2 = cos(qb1);
t3 = cos(qb2);
t4 = cos(qb3);
t5 = sin(qb1);
t6 = sin(qb2);
t7 = sin(qb3);
t8 = qb1./2.0;
t9 = qb2./2.0;
t10 = qb3./2.0;
t11 = cos(t8);
t12 = cos(t9);
t13 = cos(t10);
t14 = sin(t8);
t15 = sin(t9);
t16 = sin(t10);
A = [pb1,pb2,pb3,t3.*t4,-t2.*t7+t4.*t5.*t6,t5.*t7+t2.*t4.*t6,t3.*t7,t2.*t4+t11.*t12.*t13.*t14.*t15.*t16.*8.0,-t4.*t5+t2.*t6.*t7,-t6,t3.*t5,t2.*t3,t3.*t4.*y,-t2.*t7.*y+t4.*t5.*t6.*y,t5.*t7.*y+t2.*t4.*t6.*y,t3.*t7.*y,t2.*t4.*y+t11.*t12.*t13.*t14.*t15.*t16.*y.*8.0,-t4.*t5.*y+t2.*t6.*t7.*y,-t6.*y,t3.*t5.*y,t2.*t3.*y];
end
