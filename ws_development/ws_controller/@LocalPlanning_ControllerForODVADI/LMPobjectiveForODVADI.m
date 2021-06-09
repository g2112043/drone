function [eval] = LMPobjectiveForODVADI(obj,x,params)
% 評価値を計算する
%x(1) : optimal variables x dimension vector
%x(2) : optimal variables y dimension vector
%x(3) : optimal variables omega
% params.dis%wall distanse
% params.alpha%wall angle
% params.fai%raser angle
% params.pos%robot position [x y theta]
% params.t%control tic
% params.DeltaTheta

% hk1 = cell2mat( arrayfun(@(i) (params.dis(i) - params.pos(1)*cos(params.alpha(i)) - params.pos(2)*sin(params.alpha(i)))./cos(params.fai(i) - params.alpha(i) + params.pos(3)) ,1:params.Num,'UniformOutput',false));


hk1 = (params.dis - params.pos(1).*cos(params.alpha) - params.pos(2).*sin(params.alpha))./cos(params.fai - params.alpha + params.pos(3));
hk2 = (params.dis - (params.pos(1)+x(1).*cos(params.pos(3)).*params.t)*cos(params.alpha) - (params.pos(2)+x(2).*sin(params.pos(3)).*params.t).*sin(params.alpha))./cos(params.fai - params.alpha +(params.pos(3)+x(3).*params.t));

deltah = (hk1 - hk2) * (hk1 - hk2)';%観測値差分の２乗のsum
eval = 1/(deltah + params.e) + params.k * abs(atan2(x(2),x(1)) - params.DeltaTheta) + params.u * x(1)^2 + params.u * x(2)^2;%観測値差分の逆数と目標に向かう角速度

% diffomega = diff(invdeltah,omega);%観測値差分の逆数をωで微分
%     %-- 評価値計算
%     eval = sum(stageMidF + stageTrajectry + stageInput + stageSlack_s + stageSlack_r + stagevelocity) + terminalTrajectry + terminalvelocity +  terminalMidF;
end