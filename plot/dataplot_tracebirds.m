function dataplot_tracebirds(logger,N,Nb,fp,dt)
%害鳥追跡用のプロット関数
%引数はログ，ドローンと害鳥の総数，害鳥の総数，畑のエリア
%返し値はなく画像を表示，subversionのファイルに.eps形式で画像出力
%% 行列生成
    t = logger.Data.t;
for n = 1:numel(logger.Data.t)
    for i=1:N
        x(i,n) = logger.Data.agent{n,3,i}.state.p(1,1);
        y(i,n) = logger.Data.agent{n,3,i}.state.p(2,1);
        z(i,n) = logger.Data.agent{n,3,i}.state.p(3,1);
    end
    for i=1:N-1
        distance(i,n) = sqrt((x(1,n)-(x(1+i,n)))^2+(y(1,n)-(y(1+i,n)))^2+(z(1,n)-(z(1+i,n)))^2);
    end
end
    
    %-------------------エージェントのx座標------------------------
    figure(1)
    figure1=figure(1);
    axes1=axes('Parent',figure1);
    for i=1:Nb
        text_number{i} = append('bird',num2str(i));
    end
    for i=Nb+1:N
        text_number{i} = append('drone',num2str(i-Nb));
    end
    for i=N+1:N+numel(fp)
        text_number{i} = append('farm',num2str(i-N));
    end
    hold on
    for i=1:N
        figi = plot(t,x(i,1:numel(logger.Data.t)),'displayname',text_number{i});
%     if i==1 figi = plot(t,x(i,1:numel(logger.Data.t)),'r-');end
%     if i==2 figi = plot(t,x(i,1:numel(logger.Data.t)),'g-');end
%     if i==3 figi = plot(t,x(i,1:numel(logger.Data.t)),'b-');end
%     if i==4 figi = plot(t,x(i,1:numel(logger.Data.t)),'c-');end
    end
    hold off
    
    %-------------グラフィックスオブジェクトのプロパティ--------------
    for i=1:N
    set(figi,'LineWidth',1);
    end
    set(axes1,'FontName','Times New Roman','FontSize',14);
    grid on;
    xlim([0,logger.Data.t(end)+1]);
    xlabel('Time {\it t} [s]');
    ylabel('Position {\it x} [m]');
    axis square;
    legend('Location','eastoutside');
      
        
%%        
%-------------------エージェントのy座標------------------------
    figure(2)
    figure2=figure(2);
    axes2=axes('Parent',figure2);
    hold on
    for i=1:N
        figi = plot(t,y(i,1:numel(logger.Data.t)),'displayname',text_number{i});
%     if i==1 figi = plot(t,y(i,1:numel(logger.Data.t)),'r-');end
%     if i==2 figi = plot(t,y(i,1:numel(logger.Data.t)),'g-');end
%     if i==3 figi = plot(t,y(i,1:numel(logger.Data.t)),'b-');end
%     if i==4 figi = plot(t,y(i,1:numel(logger.Data.t)),'c-');end
    end
    hold off
    
    %-------------グラフィックスオブジェクトのプロパティ--------------
    for i=1:N
    set(figi,'LineWidth',1);
    end
    set(axes2,'FontName','Times New Roman','FontSize',14);
    grid on;
    xlim([0,logger.Data.t(end)+1]);
    xlabel('Time {\it t} [s]');
    ylabel('Position {\it y} [m]');
    axis square;
    legend('Location','eastoutside');
    
%%
    %-------------------エージェントのz座標------------------------
    figure(3)
    figure3=figure(3);
    axes3=axes('Parent',figure3);
    for i=1:Nb
        text_number{i} = append('bird',num2str(i));
    end
    for i=Nb+1:N
        text_number{i} = append('drone',num2str(i-Nb));
    end
    hold on
    for i=1:N
        figi = plot(t,z(i,1:numel(logger.Data.t)),'displayname',text_number{i});
%     if i==1 figi = plot(t,x(i,1:numel(logger.Data.t)),'r-');end
%     if i==2 figi = plot(t,x(i,1:numel(logger.Data.t)),'g-');end
%     if i==3 figi = plot(t,x(i,1:numel(logger.Data.t)),'b-');end
%     if i==4 figi = plot(t,x(i,1:numel(logger.Data.t)),'c-');end
    end
    hold off
    
    %-------------グラフィックスオブジェクトのプロパティ--------------
    for i=1:N
    set(figi,'LineWidth',1);
    end
    set(axes3,'FontName','Times New Roman','FontSize',14);
    grid on;
    xlim([0,logger.Data.t(end)+1]);
    xlabel('Time {\it t} [s]');
    ylabel('Position {\it z} [m]');
    axis square;
    legend('Location','eastoutside');
 
    %%  
    %-------------------エージェント初期位置------------------------
    figure(4)
    figure4=figure(4);
    axes4=axes('Parent',figure4);

    hold on
            farea = 5;
            n=numel(fp);
            for i=1:n
                farmxi = fp{i}(1);
                farmyi = fp{i}(2);
                xfi = [farmxi+farea farmxi+farea farmxi-farea farmxi-farea];
                yfi = [farmyi-farea farmyi+farea farmyi+farea farmyi-farea];
                fill(xfi,yfi,'r','FaceAlpha',.2,'EdgeAlpha',.2,'displayname',text_number{i+N});
                text(fp{i}(1),fp{i}(2),num2str(i));
            end
            for i=1:Nb
                figi = plot3(x(i,1),y(i,1),z(i,1),'o','MarkerSize',5,'MarkerFaceColor',[1,0,0],'displayname',text_number{i});
            end
            for i=Nb+1:N
                figi = plot3(x(i,1),y(i,1),z(i,1),'^','MarkerSize',5,'MarkerFaceColor',[0,1,0],'displayname',text_number{i});
            end
    hold off
    
    %-------------グラフィックスオブジェクトのプロパティ--------------
    for i=1:N
    set(figi,'LineWidth',1);
    end
    set(axes4,'FontName','Times New Roman','FontSize',12);
    grid on;

    xlim([30,90]);
    ylim([30,90]);
    xlabel('Position {\it x} [m]');
    ylabel('Position {\it y} [m]');
    view(180,-90);
    axis square;
    legend('Location','eastoutside');
    cd 'C:\Users\kasai\Desktop\work\work_svn\bachelor\thesis\fig'
%     exportgraphics(gcf,'initial position trace birds.eps');
%     %% エージェント間の距離
%     figure(5)
%     figure5=figure(5);
%     axes5=axes('Parent',figure5);
%     for i=Nb+1:N-1
%         text2{i} = append('agent1-',num2str(i+1));
%     end
%     hold on
%     for i=Nb+1:N-1
%         figi = plot(t,distance(i,1:numel(logger.Data.t)),'displayname',text2{i});
%     end
%     hold off
%     
%     %-------------グラフィックスオブジェクトのプロパティ--------------
%     for i=1:N
%     set(figi,'LineWidth',1);
%     end
%     set(axes5,'FontName','Times New Roman','FontSize',14);
%     grid on;
%     xlim([0,logger.Data.t(end)+1]);
% %     ylim([0,100]);
%     xlabel('Time {\it t} [s]');
%     ylabel('Distance {\it d} [m]');
%     axis square;
%     legend;
    %% 動画作成スレッド

    figure(6)

    % Animation Loop

    t = 1;
    FigNo=6;
    view_x=120;
    view_y=-10;
    for i=1:n
        P(i) = polyshape([1 2.5*(i-1)+1;10 2.5*(i-1)+1;10 2.5*(i-1)+2;1 2.5*(i-1)+2]);
    end
    MaxHp =10;
    for i=1:n
        CurrentHp(i) = MaxHp;
    end
    damage_dt = 0.01;
    v = VideoWriter('tracebirds','MPEG-4');
    v.FrameRate = 10;
    open(v);
    while t <= numel(logger.Data.t)
        clf(figure(6)); 
        
            farea = 5;
            for i=1:n
                farmxi = fp{i}(1);
                farmyi = fp{i}(2);
                xf{i} = [farmxi+farea farmxi+farea farmxi-farea farmxi-farea];
                yf{i} = [farmyi-farea farmyi+farea farmyi+farea farmyi-farea];
%                 fill(xf{i},yf{i},'r','FaceAlpha',.2,'EdgeAlpha',.2,'displayname','farm');
                vertices=[xf{i}(3),yf{i}(1),0;      %point1
                          xf{i}(1),yf{i}(1),0;      %point2
                          xf{i}(3),yf{i}(2),0;      %point3
                          xf{i}(1),yf{i}(2),0;      %point4
                          xf{i}(3),yf{i}(1),0.5;    %point5
                          xf{i}(1),yf{i}(1),0.5;    %point6
                          xf{i}(3),yf{i}(2),0.5;    %point7
                          xf{i}(1),yf{i}(2),0.5];   %point8
               faces=[1,2,4,3;      %face1
                      1,3,7,5;      %face2
                      1,2,6,5;      %face3
                      2,4,8,6;      %face4
                      4,3,7,8;      %face5
                      5,6,7,8];     %face6
               patch('Faces', faces, 'Vertices', vertices, 'facecolor', 'r');
            end
            
            
            hold on
            for i=1:n
                fill(xf{i},yf{i},'r','FaceAlpha',.2,'EdgeAlpha',.2);
                text(fp{i}(1),fp{i}(2),num2str(i));
            end

            hold off
        xlim([30,90]);
        ylim([30,90]);
        zlim([0,15]);
        set(gca,'FontSize',20);
        xlabel('\sl x \rm [m]','FontSize',25);
        ylabel('\sl y \rm [m]','FontSize',25);
        view(view_x,view_y);%シミュレーション用
%         view(0,0);%高度確認用
        hold on

        grid on; 
        grid minor;
        daspect([1 1 1]);
        ax = gca;
        ax.Box = 'on';
        ax.GridColor = 'k';
        ax.GridAlpha = 0.4;
        
        for i=1:Nb
            figi = plot3(x(i,t),y(i,t),z(i,t),'o','MarkerSize',5,'MarkerFaceColor',[1,1,0]);
%             if t>=2
%                 quiver3(x(i,t),y(i,t),z(i,t),(x(i,t)-x(i,t-1)),(y(i,t)-y(i,t-1)),(z(i,t)-z(i,t-1)));
%             end
            for j=1:n
            HpBar(j) = polyshape([1 2.5*(j-1)+1;CurrentHp(j) 2.5*(j-1)+1;CurrentHp(j) 2.5*(j-1)+2;1 2.5*(j-1)+2]);
                if x(i,t)>xf{j}(3) && x(i,t)<xf{j}(1) && y(i,t)>yf{j}(1) && y(i,t)<yf{j}(2) && z(i,t)>0 && z(i,t)<0.5
                    if CurrentHp(j) <=1
                        break;
                    end
                    CurrentHp(j) = CurrentHp(j)-damage_dt;
                    HpBar(j) = polyshape([1 2.5*(j-1)+1;CurrentHp(j) 2.5*(j-1)+1;CurrentHp(j) 2.5*(j-1)+2;1 2.5*(j-1)+2]);
                end
            end
        end
        
        for i=Nb+1:N
            figi = plot3(x(i,t),y(i,t),z(i,t),'^','MarkerSize',5,'MarkerFaceColor',[0,1,0]);
        end
        
        hold off 
        pause(16 * 1e-3) ; 
        t = t+1;
        t_sub=1/dt;        
        if mod(t,t_sub*10)==1
            FigNo=FigNo+1;
            figure(FigNo)
            farea = 5;
            for i=1:n
                farmxi = fp{i}(1);
                farmyi = fp{i}(2);
                xf{i} = [farmxi+farea farmxi+farea farmxi-farea farmxi-farea];
                yf{i} = [farmyi-farea farmyi+farea farmyi+farea farmyi-farea];
                vertices=[xf{i}(3),yf{i}(1),0;      %point1
                          xf{i}(1),yf{i}(1),0;      %point2
                          xf{i}(3),yf{i}(2),0;      %point3
                          xf{i}(1),yf{i}(2),0;      %point4
                          xf{i}(3),yf{i}(1),0.5;    %point5
                          xf{i}(1),yf{i}(1),0.5;    %point6
                          xf{i}(3),yf{i}(2),0.5;    %point7
                          xf{i}(1),yf{i}(2),0.5];   %point8
               faces=[1,2,4,3;      %face1
                      1,3,7,5;      %face2
                      1,2,6,5;      %face3
                      2,4,8,6;      %face4
                      4,3,7,8;      %face5
                      5,6,7,8];     %face6
               patch('Faces', faces, 'Vertices', vertices, 'facecolor', 'r');
            end
            
            title(['t=',num2str(logger.Data.t(t)),'s']);
            
            grid on; 
            grid minor;
            daspect([1 1 1]);
            ax = gca;
            ax.Box = 'on';
            ax.GridColor = 'k';
            ax.GridAlpha = 0.4;
            xlim([30,90])
            ylim([30,90])
            zlim([0,15])
            set(gca,'FontSize',20);
            xlabel('\sl x \rm [m]','FontSize',25);
            ylabel('\sl y \rm [m]','FontSize',25);
            view(view_x,view_y);
            hold on
            for i=1:n
                fill(xf{i},yf{i},'r','FaceAlpha',.2,'EdgeAlpha',.2);
                text(fp{i}(1),fp{i}(2),num2str(i));
            end
            
            for i=1:Nb
                figi = plot3(x(i,t),y(i,t),z(i,t),'o','MarkerSize',5,'MarkerFaceColor',[1,1,0]);
                if t>=2
                    quiver3(x(i,t),y(i,t),z(i,t),(x(i,t)-x(i,t-1)),(y(i,t)-y(i,t-1)),(z(i,t)-z(i,t-1)));
                end
            end
            for i=Nb+1:N
                figi = plot3(x(i,t),y(i,t),z(i,t),'^','MarkerSize',5,'MarkerFaceColor',[0,1,0]);
            end
            hold off
            
%             exportgraphics(gcf,['Position trace(t=',num2str(logger.Data.t(t)),'s).eps']);
            
            FigNo=FigNo+1;
            figure(FigNo)
            
            title(['t=',num2str(logger.Data.t(t)),'s']);
            hold on
            for i=1:n
                plot(P(i),'facecolor','none');
                text(0,2.5*(i-1)+1.5,num2str(i));
                for j=1:n
                    if CurrentHp(j)<3
                        plot(HpBar(j),'facecolor','r')
                    else
                        plot(HpBar(j),'facecolor','g')
                    end
                end
            end
            xlim([-1 11]);
            ylim([0 HpBar(n).Vertices(2,2)+1]);
            hold off
            
%             exportgraphics(gcf,['Farm Durable Value(t=',num2str(logger.Data.t(t)),'s).eps']);
        end
        frame = getframe(figure(6));
        writeVideo(v,frame);      

    end
            
    close(v);
    exportgraphics(gcf,'final position trace birds.eps');
    disp('simulation ended')
end 