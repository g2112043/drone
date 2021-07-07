function [eval] = LMPobjective(obj,x, params)
% 評価値を計算する
%x(1) : optimal variables velocity
%x(2) : optimal variables omega
% params.dis%wall distanse
% params.alpha%wall angle
% params.phi%raser angle
% params.pos%robot position [x y theta]
% params.t%control tic
% params.DeltaOmega

hk1 = (params.dis - params.pos(1).*cos(params.alpha) - params.pos(2).*sin(params.alpha))./cos(params.phi - params.alpha + params.pos(3));
hk2 = (params.dis - (params.pos(1)+x(1).*cos(params.pos(3)).*params.t)*cos(params.alpha) - (params.pos(2)+x(1).*sin(params.pos(3)).*params.t).*sin(params.alpha))./cos(params.phi - params.alpha +(params.pos(3)+x(2).*params.t));

deltah = (hk1 - hk2) * (hk1 - hk2)';%観測値差分の２乗のsum
eval = 1/(deltah + params.ipsiron) + params.k1 *(x(2) - params.DeltaOmega)^2 + params.k2 * (x(2) - params.Oldw)^2 + params.k3 * (x(1) - params.v)^2;%観測値差分の逆数と目標に向かう角速度

% diffomega = diff(invdeltah,omega);%観測値差分の逆数をωで微分
%     %-- 評価値計算
%     eval = sum(stageMidF + stageTrajectry + stageInput + stageSlack_s + stageSlack_r + stagevelocity) + terminalTrajectry + terminalvelocity +  terminalMidF;
end