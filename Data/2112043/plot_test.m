%最初の実行前にmatファイルをロードしてください
%１回目にmatファイルをロードした後は必要な変数が出来上がるので，実行するだけでデータの確認ができます．
clc;close all
if length(ref) == 1
else
    num_lim = i-1;
    mkmap = pointCloud([nan nan nan]);
    for j=1:num_lim
        ndtPCdata(j) = pctransform(savedata(j).ndtPCdata,savedata(j).tform);    
        mkmap = pcmerge(mkmap,ndtPCdata(j), 0.001);
    end    
    mkmap_rs = pointCloud([nan nan nan]);
    for j=1:num_lim
        d435i_data(j) = depth_ptc(savedata(j).rs);
        rspcd(j) = pctransform(d435i_data(j),savedata(j).nowpose);
        mkmap_rs = pcmerge(mkmap_rs,rspcd(j),0.001);
    end
    ref = 1;
end
%%
prompt = "何番のデータを出力する？ ";
x = input(prompt);
disp("figure(1)に"+num2str(x)+"番の剛体変換後の2D点群と3D点群を同時にプロットします．")
figure(1)
pcshowpair(mkmap,rspcd(1,x))
disp("figure(2)に3D点群のmkmapをプロットします．")
figure(2)
pcshow(mkmap_rs)
disp("figure(3)に隣接するデータ番号のD435iのデータを比較プロットします")
figure(3)
pcshowpair(rspcd(1,x),rspcd(1,x+1))