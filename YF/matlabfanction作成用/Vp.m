cd 'C:\Users\owner\OneDrive - tcu.ac.jp\work2020\work\YF\matlabfanction作成用'
% cd 'C:\Users\Tyasui\OneDrive - tcu.ac.jp\work2020\work\YF\matlabfanction作成用'
%%symsで変数定義
syms symx symy symnodex symnodey symnoder
%%関数の作成，あんまり複雑なのは無理だと思う．確認したことないけど．
symVp = (2*symnoder/pi)*tan(pi*sqrt((symx-symnodex)^2+(symy-symnodey)^2)/(2*symnoder));
diffx = diff(symVp,symx);
diffy = diff(symVp,symy);
%%mファイルの作成，（関数，'file'，名前，'vars'，[変数]）で，ここに書いた順番で変数をいれればいい．
matlabFunction(symVp,'file','Cov_Vp.m','vars',[symx symy symnodex symnodey symnoder])
matlabFunction(diff(symVp,symx),'file','Cov_diffx_Vp.m','vars',[symx symy symnodex symnodey symnoder])
matlabFunction(diff(symVp,symy),'file','Cov_diffy_Vp.m','vars',[symx symy symnodex symnodey symnoder])