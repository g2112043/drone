% function Lghn = CalculateLghn(file_name,est,name)

% % Correct Obserbavility 用　Lghn計算
% % file_name 保存するファイル名
% % est 推定モデル
% % name 可観測性行列の関数名
%     n = est.model.dim(1);
%     x = sym('x',[n,1]);
%     u = sym('u',[est.model.dim(2),1]);
%     p = sym('p',[1,est.model.dim(3)]);
%     Vn = sym('Vn',[n,1]);
%     O_func = str2func(name); 
%     h = O_func(x,u);
%     hn = h(1:n,n);
%     % hn = h(n,:);
%     g = G_RPY18(x,p);
%     Lghn = jacobian(hn, x) * g;
%     matlabFunction(Lghn,'File',strcat(file_name,".m"),'Vars',{x,u,p});
%     Lghn=str2func('Lghn');
% end

function Lghn = CalculateLghn(file_name,est,name)
% Correct Obserbavility 用　Lghn計算
% file_name 保存するファイル名
% est 推定モデル
% name 可観測性行列の関数名
    n = est.model.dim(1);
    x = sym('x',[n,1]);
    u = sym('u',[est.model.dim(2),1]);
    p = sym('p',[1,est.model.dim(3)]);
    Vn = sym('Vn',[n,1]);
    O_func = str2func(name); 
    O = O_func(x,u);
    g = G_RPY18(x,p);
    dhndx = zeros(size(O));
    for i=1:n
        A = jacobian(O(:,i),x);
        dhndx = dhndx + (A * Vn(i));
    end
    Lghn = dhndx * g;
    matlabFunction(Lghn,'File',strcat(file_name,".m"),'Vars',{x,u,p,Vn});
    Lghn=str2func('file_name');
end
 