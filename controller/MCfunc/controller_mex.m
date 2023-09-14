function contResult = input2eval(OBJ)
    % 入力算出までまとめてmex化するためのファイル

    % sigma : HLcontroller

    ave = [0;0;0;0];
    OBJ.input.u1 = OBJ.input.sigma(1).*randn(OBJ.param.H, OBJ.N) + ave(1); 
    OBJ.input.u2 = OBJ.input.sigma(2).*randn(OBJ.param.H, OBJ.N) + ave(2);
    OBJ.input.u3 = OBJ.input.sigma(3).*randn(OBJ.param.H, OBJ.N) + ave(3);
    OBJ.input.u4 = OBJ.input.sigma(4).*randn(OBJ.param.H, OBJ.N) + ave(4);

    OBJ.input.u(4, 1:OBJ.param.H, 1:OBJ.N) = OBJ.input.u4;   % reshape
    OBJ.input.u(3, 1:OBJ.param.H, 1:OBJ.N) = OBJ.input.u3;
    OBJ.input.u(2, 1:OBJ.param.H, 1:OBJ.N) = OBJ.input.u2;
    OBJ.input.u(1, 1:OBJ.param.H, 1:OBJ.N) = OBJ.input.u1;

    %% predict state
        u = OBJ.input.u;
        OBJ.state.state_data(:,1,1:OBJ.N) = repmat(OBJ.current_state,1,1,OBJ.N);  % サンプル数分初期値を作成
        for i = 1:OBJ.param.H-1
            OBJ.state.state_data(:,i+1,1:OBJ.N) = pagemtimes(OBJ.A(:,:,1:OBJ.N),OBJ.state.state_data(:,i,1:OBJ.N)) + pagemtimes(OBJ.B(:,:,1:OBJ.N),u(:,i,1:OBJ.N));
        end
        % predict_state = OBJ.state.state_data;

    %% 実状態変換 real state transform
        Xd = repmat(OBJ.reference.xr_org, 1,1,OBJ.N);
        Xreal = Xd + OBJ.state.state_data; % + or -
        OBJ.state.error_data = Xd - Xreal;
        OBJ.state.real_data = Xreal;

    %% Evaluate 
        % X = OBJ.state.state_data(:,:,1:OBJ.N);       % 12 * 10 * N
        U = OBJ.input.u(:,:,1:OBJ.N);                % 4  * 10 * N
        
        %% 実状態との誤差
        Z = OBJ.state.error_data;
        k = ones(1, OBJ.param.H-1);
        
        %% コスト計算
        tildeUpre = U - OBJ.input.v;          % agent.input 　前時刻入力との誤差
        tildeUref = U - OBJ.param.ref_input;  % 目標入力との誤差 0　との誤差
        
        stageStateZ = k .* Z(:,1:end-1,:).*pagemtimes(OBJ.Weight(:,:,1:OBJ.N),Z(:,1:end-1,:));
        stageInputPre  = k .* tildeUpre(:,1:end-1,:).*pagemtimes(OBJ.WeightR(:,:,1:OBJ.N),tildeUpre(:,1:end-1,:));
        stageInputRef  = k .* tildeUref(:,1:end-1,:).*pagemtimes(OBJ.WeightRp(:,:,1:OBJ.N),tildeUref(:,1:end-1,:));
    
        terminalState = sum(k .* Z(:,end,:).*pagemtimes(OBJ.Weight(:,:,1:OBJ.N),Z(:,end,:)),[1,2]);
    
        Eval{1} = sum(sum(stageStateZ,[1,2]) + stageInputPre + stageInputRef + terminalState, [1,2]);  % 全体の評価値
        Eval{2} = sum(stageStateZ(1:2,:,:),  [1,2]);   % Z
        Eval{3} = sum(stageStateZ(3:6,:,:),  [1,2]);   % X
        Eval{4} = sum(stageStateZ(7:10,:,:), [1,2]);   % Y
        Eval{5} = sum(stageStateZ(11:12,:,:),[1,2]);   % YAW
    
        MCeval(:,1) = reshape(Eval{1}, OBJ.N, 1);
        MCeval(:,2) = reshape(Eval{2}, OBJ.N, 1);
        MCeval(:,3) = reshape(Eval{3}, OBJ.N, 1);
        MCeval(:,4) = reshape(Eval{4}, OBJ.N, 1);
        MCeval(:,5) = reshape(Eval{5}, OBJ.N, 1);

        OBJ.MCeval = MCeval;
    
    %% contResult
    contResult.state = OBJ.state.state_data;
    contResult.eval = OBJ.MCeva;
    % OBJ.state.state_data
    % OBJ.MCeval
end