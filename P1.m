close all;
covs = {[0.9,0;0,0.9],[0.9,0;0,0.9],[1,0;0,100],[100,0;0,1]};
mius = {[-1;0],[-1;10],[10;5],[0;15]};
alphas = [20000,20000,1000000,1000000];
cuad = {[1,0;0,1], [-10;-10], 50};

syms x y;
f = @(x,y) gauss_m_cuad([x;y], mius, covs, alphas, cuad,20);

g=-gradient(f, [x,y])

x0=[-5;-5];
x1=[-5;10];
equis=x0;
equis1=x1;
xs=[equis];
xs1=[equis];
i=0
z=[f(equis(1),equis(2))];
z1=[f(equis1(1),equis1(2))];
while norm(equis-[5;5])>0.02 || norm(equis1-[5;5])>0.02
    g1=double(subs(g(1), [x y], {equis(1),equis(2)}));
    g2=double(subs(g(2), [x y], {equis(1),equis(2)}));
    equis=equis+0.02*[double(g1);double(g2)]/norm([double(g1);double(g2)]);
    xs=[xs equis];
    z=[z f(equis(1),equis(2))];
    i=i+1;
    
    
    g11=double(subs(g(1), [x y], {equis1(1),equis1(2)}));
    g21=double(subs(g(2), [x y], {equis1(1),equis1(2)}));
    equis1=equis1+0.02*[double(g11);double(g21)]/norm([double(g11);double(g21)]);
    xs1=[xs1 equis1];
    z1=[z1 f(equis1(1),equis1(2))];
end

%% Graficas
figure;
hold on
fsurf(f, [-10 20]);
scatter3(transpose(xs(1,:)),transpose(xs(2,:)), z, 'filled', 'm')

scatter3(transpose(xs1(1,:)),transpose(xs1(2,:)), z1, 'filled', 'm')
