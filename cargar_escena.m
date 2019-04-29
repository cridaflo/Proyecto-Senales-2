function [medias, covs, alphas] = cargar_escena()

num = xlsread('escena.xlsx');

[m,n] = size(num);
medias = cell(1,m);
covs = cell(1,m);

for i=1:m
    medias{i} = num(i,1:2)';
    covs{i} = diag(num(i,3:4));
end

alphas = num(:,5)';

end
