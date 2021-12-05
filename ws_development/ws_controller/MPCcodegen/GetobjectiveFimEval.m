function eval = GetobjectiveFimEval(x, params,NoiseR,SensorRange,RangeGain)
% モデル予測制御の評価値を計算するプログラム

%-- MPCで用いる予測状態 Xと予測入力 Uを設定
X = x(1:params.state_size, :);
U = x(params.state_size+1:end, :);

%-- 状態及び入力に対する目標状態や目標入力との誤差を計算
tildeX = X - params.Xr;
%     tildeU = U - params.Ur;
tildeU = U;
%
evFim = zeros(1,params.H);
for j = 1:params.H
    H = (params.dis(:) - X(1,j).*cos(params.alpha(:)) - X(2,j).*sin(params.alpha(:)))./cos(params.phi(:) - params.alpha(:) + X(3,j));%observation
%     RangeLogic = H<SensorRange;
    RangeLogic = (tanh(RangeGain*(SensorRange - H))+1)/2;
    Fim = RangeLogic(1) * FIM_ObserbSub(X(1,j), X(2,j), X(3,j), X(4,j), U(2,j), params.dt, params.dis(1), params.alpha(1), params.phi(1));
    for i = 2:length(params.dis)
        Fim = Fim + RangeLogic(i) * FIM_ObserbSub(X(1,j), X(2,j), X(3,j), X(4,j), U(2,j), params.dt, params.dis(i), params.alpha(i), params.phi(i) );
    end
    Fim = (1/(2*NoiseR))*Fim;
    InvFim = inv(Fim);
    evFim(1,j) = max(eig(InvFim));
end
%-- 状態及び入力のステージコストを計算
stageState = arrayfun(@(L) tildeX(:, L)' * params.Q * tildeX(:, L), 1:params.H);
stageInput = arrayfun(@(L) tildeU(:, L)' * params.R * tildeU(:, L), 1:params.H);

eval.stageevFim = evFim* params.T * evFim';
%-- 状態の終端コストを計算
eval.terminalState = tildeX(:, end)' * params.Qf * tildeX(:, end);
%-- 評価値計算
eval.StageState = sum(stageState);
eval.StageInput = sum(stageInput);
end