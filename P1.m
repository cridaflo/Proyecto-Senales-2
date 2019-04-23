covs = {[1,0;0,1]};
mius = {[0;0]};
alphas = [1];
cuad = {[1,0;0,1], [1;1], 1};

syms x y;
f = @(x,y) gauss_m_cuad([x;y], mius, covs, alphas, cuad);

gradient(f, [x,y])