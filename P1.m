close all;
clc;
clear;

[mius, covs, alphas] = cargar_escena();

cuad = {[1,0;0,1], [-10;-10], 50};
paso = 0.02;

syms x y;
f = @(x,y) gauss_m_cuad([x;y], mius, covs, alphas, cuad,20);
g=-gradient(f, [x,y]);

a=1;
b=2;
c=1;
d=sqrt(10*log(b/a));
arf=@(x,y) 100*(a/2*distance(x,y)^2+b*c/2*exp(-(distance(x,y))^2/c));
h=-gradient(arf,[x,y]);

poss = cargar_pos();
equis = poss;
xs = {};
zs = {};
[m,numAgentes] = size(poss);
for i = 1:numAgentes
    p = poss{i};
    xs{i} = p;
    zs{i} = [f(p(1),p(2))];
end

i=0;
while i<1000
    for j = 1:numAgentes
        pj = poss{j};
        G = double(subs(g, [x y], {pj(1),pj(2)}));
        g1 = G(1);
        g2 = G(2);
        for k=1:numAgentes
            if k~=j
                pk = poss{k};
                H = double(subs(h, [x y], {pj(1)-pk(1),pj(2)-pk(2)}));
                g1 = g1+H(1);
                g2 = g2+H(2);
            end
        end
        pj = pj+paso*[g1;g2]/norm([g1;g2]);
        poss{j} = pj;
        xs{j} = [xs{j},pj];
        zs{j} = [zs{j}, f(pj(1), pj(2))];       
    end
    i=i+1;
    
end
mensaje = 'se fini'
%% Graficas
figure;
hold on
fsurf(f, [-20 20]);

for j = 1:numAgentes
    xss = xs{j};
    scatter3(transpose(xss(1,:)),transpose(xss(2,:)), zs{j}, 'filled', 'm')
end

%% Grafica Escena
figure;

[mius, covs, alphas] = cargar_escena();
cuad = {[1,0;0,1], [-10;-10], 50};
paso = 0.02;

syms x y;
f = @(x,y) gauss_m_cuad([x;y], mius, covs, alphas, cuad,20);

fsurf(f,[-22 22]);