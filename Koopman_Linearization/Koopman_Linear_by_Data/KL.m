function output = KL(X,U,Y,F)
%KL クープマン線形化によって線形アフィン系状態方程式の係数行列ABCを求める
%   output = KoopmanLinear(X,U,Y)
%   outuput.A .B  観測量空間における線形アフィン系の係数行列 Z[k+1] = A*Z[k]+Bu[k]
%          .C     観測量空間から状態空間に送る線形状態方程式の係数行列 X[k] = C*Z[k]
%   X, U, Y       観測する状態Xに入力Uを与えた際の出力Yを集めたデータセット
%                 列：データ, 行：時系列
%   F             観測量 関数ハンドル

%Xlift,Yliftを計算する
for i = 1:size(X,2)%1:Data.num
    Xlift(:,i) = F(X(:,i));
    Ylift(:,i) = F(Y(:,i));
end

[numX, ~] = size(Xlift); %[numX, ~]=size(Xlift): Xliftのサイズ=(A行,B列)のとき，A行の値をnumXに入れ，B列の値は使わない(~:notの意味)
[numU, ~] = size(U);

% %ABをまとめて計算する 参考資料記載のやりかた
% M = Ylift * pinv([Xlift; U]);
% A = M(1 : numX, 1 : numX);
% B = M(1 : numX, numX + 1:numX + numU);
% C = X*pinv(Xlift);

% A,Bをまとめて計算するデータ数が多い場合のやりかた
G = [Xlift ; U]*[Xlift ; U]'; % size(G) = (numX+numU, numX+numU)
V = Ylift*[Xlift ; U]';       % size(V) = (numX,      numX+numU)
M = V * pinv(G);              % size(M) = (numX,      numX+numU)
output.A = M(1:numX, 1:numX); % size(.A) = (numX, numX)
output.B = M(1:numX, numX+1:numX+numU); % size(.B) = (numX, numU)
output.C = X*pinv(Xlift); % C: Z->X の厳密な求め方 pinv: Moore-Penrose疑似逆行列  size(.C) = (size(X), numX)
end