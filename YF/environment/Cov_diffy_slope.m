function out1 = Cov_diffy_slope(symx,symy,a,b,c,d,e,f,g)
%COV_DIFFY_SLOPE
%    OUT1 = COV_DIFFY_SLOPE(SYMX,SYMY,A,B,C,D,E,F,G)

%    This function was generated by the Symbolic Math Toolbox version 8.5.
%    07-Aug-2021 11:51:17

t2 = f.*5.0;
t3 = symy.*5.0;
t4 = -symy;
t5 = -t3;
t6 = g+t4;
t7 = t2+t5;
t8 = t6.*t7;
t9 = tanh(t8);
out1 = b+(pi.*(t9.^2-1.0).*(tan((pi.*(t9+1.0))./4.0).^2+1.0).*(g.*5.0-symy.*1.0e+1+t2))./4.0;
