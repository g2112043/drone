%個体が２つのときに回避開始地点の距離を算出する．ついでに図を出す．
close all;clc
figure
N=length(yasui.save.agent);
fp=[0 0];
PlotColor = ['r';'b';'g'];
close all;
mb = 1;
pb = 10;
xmin = -1;
ymin = -1;
xmax = 2;
ymax = 11;


%%
axis equal;
view(2)
env = yasui.save.env;
axis equal;
plot(env,'Facecolor','none')
hold on; axis equal;grid on;
Col = ['k','r','m','b','g','c'];
hh = 1;%%ターゲットの個体番号
for hh= 1:2
SponeTiming = find_respone(yasui,hh);
AvoidTiming(hh) = find_avoid(yasui,hh);

kk=2;
% for kk =2:length(SponeTiming)
if length(SponeTiming)==1
    plot((yasui.save.agent{hh}.state(1,SponeTiming(1):end)),(yasui.save.agent{hh}.state(2,SponeTiming(1):end)),'color',Col(hh),'Linewidth',2)
else
    plot((yasui.save.agent{hh}.state(1,SponeTiming(kk-1):SponeTiming(kk))),(yasui.save.agent{hh}.state(2,SponeTiming(kk-1):SponeTiming(kk))),'color',Col(hh),'Linewidth',2)
end
    hold on 
    plot((yasui.save.agent{hh}.state(1,AvoidTiming(hh))),(yasui.save.agent{hh}.state(2,AvoidTiming(hh))),'k:o')
    
% end
axis([xmin xmax ymin ymax]);
xlim([xmin xmax]);
ylim([ymin ymax]);
pbaspect([abs(xmin)+abs(xmax) abs(ymin)+abs(ymax) 1]);
xlabel('{\it x} [m]','FontName','Times New Roman','FontSize',24,'Interpreter','latex')
ylabel('{\it y} [m]','FontName','Times New Roman','FontSize',24,'Interpreter','latex')
ax = gca;
ax.FontSize = 24;
fig = gcf;
fig.PaperPositionMode = 'auto';
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
exportsetupdlg
end
AvoidDistance = norm(yasui.save.agent{1}.state(2,AvoidTiming(1))-yasui.save.agent{2}.state(1,AvoidTiming(1)))
% cd 'C:\Users\Tyasui\OneDrive - tcu.ac.jp\work2020\論文用\fig'
% cd 'C:\Users\owner\OneDrive - tcu.ac.jp\work2020\論文用\fig'









function result = find_respone(yasui,hh)
[~,m] = size(yasui.save.agent{hh}.state);
for i=1:m
    TF(i) = isnan(yasui.save.agent{hh}.state(1,i));
end
[~,col] = find(TF);
result = [1,col];
end
function result = find_avoid(yasui,hh)
[~,m] = size(yasui.save.agent{hh}.state);
for i=1:m
    if norm(yasui.save.agent{hh}.state(1,1)-yasui.save.agent{hh}.state(1,i))>0.5
    TF(i) = 1;
    else 
       TF(i) = 0; 
    end
end
[~,bbb] = find(TF);
result = min(bbb);
end







