function dxg = Gep(in1,in2)
%Gep
%    DXG = Gep(IN1,IN2)

%    This function was generated by the Symbolic Math Toolbox version 9.3.
%    2023/06/15 12:08:18

jx = in2(:,6);
jy = in2(:,7);
jz = in2(:,8);
dxg = reshape([0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0./jx,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0./jy,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0./jz,0.0,0.0],[15,4]);
end
