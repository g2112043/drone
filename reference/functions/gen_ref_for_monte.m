function Xd = gen_ref_for_monte(Xd_old)
%% Setting
dz = 0.1 * 0.025; % 目標速度 * サンプリングタイム
%% Set Xd
    Xd = Xd_old(1:3);
    if Xd_old(3) > 0
        Xd( 3, 1)   = Xd_old( 3) - dz;
    end
  %  Xd(4,1)=Xd_old(3);
end
