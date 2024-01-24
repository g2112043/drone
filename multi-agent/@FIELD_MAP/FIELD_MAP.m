classdef FIELD_MAP < handle
  properties(Constant)
    sm = 12; % [m] : spread fire possible distance under 10 m/s wind
    ss = 80/3600; % [m/s] : spread fire speed under 10 m/s wind
  end
  properties
    g_per_step
    % grid/step = m/s * grid/m * s/step = m/s *(meter/grid)^-1*(step/second)^-1
    % = ss*(1/mperg)*(1/(step/s)) = ss*(1/mperg)*(3600/(step/h))
    % = 3600*ss/(m_per_grid*step_per_h)
    % = sum_d (p[d]*d) % wind direction
    % where p[d] is the probability of spreading to d step ahead.
    nx = 100; % x axis grid number
    ny = 100; % y axis grid number
    N  % total number of grid
    maxv = 0.04;    % 確率の上限，シミュレーションの進行に関係するパラメータであり、適当な値を入力
    map_meter_size  % マップ幅 m
    m_per_grid % meter/grid
    step_per_h = 20; % step/hour
    W % weight matrix : nx-ny size matrix
    shape_data
    shape_opts % TODO : flag と整理
    flag
    xq % meshgrid : grid size nx x ny : range = nx*m_per_grid
    yq % meshgrid : grid size nx x ny : 
  end
  properties
    wind_data
    wind % [dir,speed] dir 0:南 45:南西 90:西 135:北西 180:北 225:北東 270:東 315:南東
    wind_time % wi = wind_time(i); wind(wi,:) is wind info at time step i 
    map
    unum
    FF
    E
    ES
    EF
    WS
    WF
    X
    Xm
    vi1
    w2
    fDynamics
  end
  properties % SIR
    x
    A
    B
    Si % vector of S state = [1;0;...;0]
    Ii % vector of I1 state
    Ri % vector of R state
    ti = 30; % length of I
    U
    v % outbreak
    vs % outbreak by spreding fire
    vf % outbreak by flying fire
    n % number of state
    h = 0; % extinction probability　消火確率は0.1で設定
    S % indices of S agents
    I % indices of I agents
    R % indices of R agents
  end

  methods
    function obj = FIELD_MAP(flag,shape_data,shape_opts,W)
      arguments
        flag
        shape_data
        shape_opts %
        W = []
      end
      if isempty(W)
        obj.S = shaperead(shape_data);
        disp("shape file loaded ");
      elseif isstring(W)
        load(W,"W");
      end
      obj.W = W;
      obj.shape_data = shape_data;
      obj.flag = flag;
      obj.shape_opts = shape_opts;
      if isfield(shape_opts,"nx")
        obj.nx = shape_opts.nx;
        obj.ny = shape_opts.ny;
      end
      if isfield(shape_opts,"step_per_h")
        obj.step_per_h = shape_opts.step_per_h;
      end
    end
    function set_target(obj)
      arguments
        obj
      end
      obj.map_meter_size = obj.shape_opts.map_size;
      obj.N  = obj.nx*obj.ny; % total grid number
      obj.m_per_grid = obj.map_meter_size(1)/obj.nx; % meter/grid
      obj.g_per_step = 3600*obj.ss/(obj.m_per_grid*obj.step_per_h); % grid/step
      [obj.xq,obj.yq] = meshgrid(0:obj.m_per_grid:obj.nx*obj.m_per_grid,0:obj.m_per_grid:obj.ny*obj.m_per_grid);
      obj.W = obj.gen_grid_weight(obj.shape_opts);
    end
    function setup_wind(obj,wind_data)
      arguments
        obj
        wind_data
      end
      %% wind infomation
      obj.wind_data = wind_data;
      [obj.wind,obj.wind_time] = obj.gen_wind_effect(wind_data);
      disp("generated wind ")
      if obj.flag.wind_average % average wind during time
        th = obj.wind(:,1);
        wind1 = atan2(mean(sin(th)),mean(cos(th))); % average wind direction
        wind2 = mean(obj.wind(:,2));  % average wind speed
        [ES,EF,WS,WF] = obj.gen_edge([wind1,wind2]);
        obj.ES{1} =ES;
        obj.EF{1} =EF;
        obj.WS{1} =WS;
        obj.WF{1} =WF;
      else
        for i = 1:length(obj.wind(:,1))
          [ES,EF,WS,WF] = obj.gen_edge(obj.wind(i,:));
          obj.ES{i} =ES;
          obj.EF{i} =EF;
          obj.WS{i} =WS;
          obj.WF{i} =WF;
        end
      end
    end

    function set_gridcell_model(obj)
      %% SIR model
      %   N : number of agents
      %   ti : length of infected time step = number of "I" state
      %   h : transition probability to R
      %   xi : corresponds to (S,I1,I2,I3,...,Iti,R)'; = ti+2 dimension
      %       xi = [1,0,...,0]'; means xi is S
      %       xi = [0,0,1,0,...,0]'; means xi is I2
      %       xi = [0,...,0,1]'; means xi is R
      %   x = [x1; x2; ... ; xN];
      % xn = A*xc + B*v   if u = 0
      % xn = R            if u = 1
      %   xn : next state
      %   xc : current state
      %   v  : state transition input from S to I
      %   u  : state transition input to R
      obj.x = zeros(obj.N*(obj.ti+2),1); % each cell has (ti+2)-state : S,I(1),...,I(ti),R
      obj.x(1:(obj.ti+2):end,1) = 1;% initial (state = S) <=> xi corresponding S is 1.
      obj.x = obj.x;

      Ai = [[1;0],zeros(2,obj.ti+1);zeros(obj.ti,1),eye(obj.ti),[zeros(obj.ti-1,1);1]];
      Bi = [-1;1;zeros(obj.ti,1)];
      obj.A = kron(speye(obj.N),sparse(Ai));
      obj.B = kron(speye(obj.N),sparse(Bi));
      obj.S = ones(obj.N,1);
      obj.I = zeros(obj.N,1);
      obj.R = zeros(obj.N,1);
      obj.Si = [1;zeros(obj.ti+1,1)];
      obj.Ii = [0;1;zeros(obj.ti,1)];
      obj.Ri = [zeros(obj.ti+1,1);1];
      obj.n = obj.ti+2;% number of state
      obj.U = zeros(obj.N,1);
    end

    function initialize_each_grid(obj,I,R)
      obj.I = I;
      obj.R = R;
      obj.S(find(I+R))=0;
      obj.x = (obj.x & kron(~I,ones(obj.n,1))) + kron(I,obj.Ii);
      obj.x = sparse((obj.x & kron(~R,ones(obj.n,1))) + kron(R,obj.Ri));
      obj.U = sparse(obj.N,1);
    end
    function kk = calc_v(obj,E)
      % E : edge matrix
      % eij : (i,j) element of E
      % eij > 0 if edge exists from j to i else eij = 0
      sIt = (obj.I>0)';
      Tsi = obj.S*sIt;% 向き注意！eij の感染の向きに従うように．具体的な数値で確認せよ
      aa=E.*Tsi;% Iの拡散edge重み = Iの拡散確率行列
      aaa = spones(aa)-aa; % I が拡散しないスパース確率行列
      [i,~,v]=find(aaa);   % (非ゼロを探すfind)aaaの行の添え字をiに、要素の値をvに返す処理
      [ui,~,ic] = unique(i,'stable');     % uiの値を、iと同じ順序にするための処理
      bb = ones(size(ui));
      for k = 1:length(v)
        bb(ic(k),1) = bb(ic(k),1)*v(k);
      end
      dd = rand(length(ui),1); % [0,1]乱数
      cc = spones(bb)-bb; % Iになる確率
      kk = sparse(size(aa,1),1);  % aaと同じ行数の0スパースベクトルを生成
      kk(ui)=dd <= cc;
    end
    function transition_to_R(obj,U)
      % U = [u1; u2; ... ; uN];
      % ui = 0 or 1;
      R = (obj.I>0).*(U.*(rand(obj.N,1) <= obj.h)); % indices of agents to be R
      obj.x=sparse((obj.x & kron(~R,ones(obj.n,1))) + kron(R,obj.Ri));% transform to R
      % [Description]
      % kron(R,obj.Ri) : a vector such that subvector corresponding to R-th agents position equals Ri
      % kron(~R,ones(n,1)) : a vector such that subvector
      % corresponding to ('not' R)-th agents position equals 1
      obj.S=obj.S & ~R;% update S agents
      obj.I=obj.I .* ~R;% update I agents % need "*" not "&" because I is a value in [0, ti]
      obj.R=obj.R | R;% update R agents
      obj.U = U;
    end
    function next_step_func(obj,U,k)
      % next_step_func : function to calculate next state
      obj.transition_to_R(U);% h 以下の確率でUのある燃えているセルを消火（Rに遷移）
      obj.vs = obj.calc_v(obj.ES{k});
      obj.vf = obj.calc_v(obj.EF{k});
      obj.v = obj.vs+obj.vf;
      obj.R(obj.I == obj.ti)=1;
      obj.I(obj.I == obj.ti)=0;
      obj.x = obj.A*obj.x+obj.B*(obj.v);
      obj.I = obj.I + (obj.I>0);% 火災の進行具合を1-tiの整数で表現
      i=find(obj.v);
      obj.S(i) = 0;
      obj.I(i) = 1;
    end
    function calc_page_rank(obj)
      %% Page-RankやAlt-Page-Rankを用いるのに利用する(つまり単純なWeightでは使わない)
      L = speye(size(obj.E)) - obj.E/eigs(obj.E,1);
      %[V,Eig,Flag]=eigs(L',1,'smallestabs','Tolerance',1e-20); % V : alt page rank
      obj.L = sparse(L); % TODO：上の行で既にスパースになっていないか確認
      %[V2,Eig2,Flag2]=eigs(E'/eigs(E,1),1,'largestreal','Tolerance',1e-20);
      %map.draw_state(nx,ny,reshape(V,[nx,ny]));% V2だとAPRが負になることがある．Vの方が数値的に安定そう．符号自由度についてはVの方が悪そうなのになぜだろう？

    end
  end

  %% figure
  methods
    function figure=draw_state(obj,W,ax)
      arguments
        obj
        W = [];
        ax = []
      end
      if isempty(W)
        W = obj.W;
      end
      %clf
      %hold on
      if isfield(W,"S")||isprop(W(1),"S")%(length(W)==1)
        V = 2*W.S+5*(W.I>0)+3*(W.R.*~W.U)+4*W.U;
        cmin=2;
        %colorbar(ax,'Ticks',[2,3,4,5],'TickLabels',{'Not burn','Extinct','Extincting','Burning'})
        if isfield(W,"P")||isprop(W(1),"P")
          PU = W.P.*~W.U;
          V = (V.* ~PU) + 1*PU;
          cmin=2; % Pathを使うときは1
          colorbar(ax,'Ticks',[2,3,4,5],'TickLabels',{'Not burn','Extinct','Extincting','Burning'})
          %                     colorbar('Ticks',[1,2,3,4,5],'TickLabels',{'Path','Not burn','Extinct','Extincting','Burning'})
        end
        if isempty(ax)
          figure=surf(obj.xq,obj.yq,reshape(V,[obj.nx,obj.ny]));hold on;
          set(gca,'FontSize',20);
          ax = gca;
        else
          figure=surf(ax,obj.xq,obj.yq,reshape(V,[obj.nx,obj.ny]));
          hold(ax,'on');
        end
        mycmap=[1 1 0; 0 1 0;0.5 0.5 0.5;0 0 1;1 0 0]; %[Blue;Green;Gray;Cyan;Red];
        cmax=5;
        clim(ax,[cmin cmax]);
        colormap(ax,mycmap(cmin:cmax,:));
      else
        if isempty(ax)
          figure=surf(obj.xq,obj.yq,W);hold on;
          set(gca,'FontSize',20);
          ax = gca;
        else
          figure=surf(ax,obj.xq,obj.yq,W);hold on;
        end
        colorbar(ax);
      end
      view(ax,2)
      % マップ範囲を決めている
      % xlabel(ax,'\sl x','FontSize',25);
      % ylabel(ax,'\sl y','FontSize',25);
      xlim(ax,[1,obj.nx*obj.m_per_grid]);
      ylim(ax,[1,obj.ny*obj.m_per_grid]);
      ax.Box = 'on';
      ax.GridColor = 'k';
      ax.GridAlpha = 0.4;
      axis(ax,'square');
      hold(ax,'off');
    end
    function F=draw_movie(obj,logger,output,filename)
      % draw/generate movie
      % logger : struct with fields S, I, R matrices
      % nx : x axis grid number
      % ny : y axis grid number
      % output(optional) : 1 means output file (default 0)
      % filename(optional) : output file name
      arguments
        obj
        logger
        output = 0
        filename = "";
      end
      if filename==""
        F=make_animation(find(logger.k),@(k) obj.draw_state(obj.loggerk(logger,k)),@()[],output);
      else
        F=make_animation(find(logger.k),@(k) obj.draw_state(obj.loggerk(logger,k)),@()[],output,filename);
      end
    end
    function W=loggerk(obj,logger,k)
      if isfield(logger,"P")||isprop(logger(1),"P")
        W = struct("S",logger.S(:,k),"I",logger.I(:,k),"R",logger.R(:,k),"U",logger.U(:,k),"P",logger.P(:,k));
      else
        W = struct("S",logger.S(:,k),"I",logger.I(:,k),"R",logger.R(:,k),"U",logger.U(:,k));
      end
    end
    function save(filename,logger)
      if isstruct(logger)
        myfield=fieldnames(logger);
        %tmp = logger(1);
        for n = 1:length(myfield)
          tmp.(myfield{n}) = {logger.(myfield{n})};
        end
        save(filename,'-struct','tmp','-v7.3');
      else
        save(filename,'logger');
      end
    end
    function Logger=load(filename)
      data=load(filename);
      F = fieldnames(data);
      if length(F)==1
        Logger = data.(F{1});
      else
        for i = 1:numel(data.(F{1}))
          for n = 1:length(F)
            Logger(i).(F{n})=data.(F{n}){i};
          end
        end
      end
    end
    function plot_W(obj,ax)
      delete(ax.Children);
      %surf(ax,obj.xq,obj.yq,obj.W(1:obj.ny,1:obj.nx));
      surf(ax,obj.xq,obj.yq,obj.W);
      %legend(ax,"x","y","z");
      %colormap(ax,'default');
      view(ax,2);daspect(ax,[1 1 1]);
      %disp("complete generating W");
    end
    function plot_E(obj,ax,E)
      delete(ax.Children);
      WW=reshape(E(:,floor(1.01*obj.N/2)),obj.nx,obj.ny);
      surf(ax,obj.xq,obj.yq,WW);
      %legend(ax,"x","y");
      view(ax,2);daspect(ax,[1 1 1]);
    end
  end

end