function symVp = Cov_daen(symx,symy,obx1,oby1,obx2,oby2)
%COV_DAEN
%    SYMVP = COV_DAEN(SYMX,SYMY,OBX1,OBY1,OBX2,OBY2)

%    This function was generated by the Symbolic Math Toolbox version 8.6.
%    08-Jan-2021 14:19:29

t2 = -symx;
t3 = -symy;
symVp = 1.0./(sqrt(abs(obx1-obx2).^2+abs(oby1-oby2).^2)+sqrt(abs(obx1+t2).^2+abs(oby1+t3).^2)+sqrt(abs(obx2+t2).^2+abs(oby2+t3).^2)).^2;
