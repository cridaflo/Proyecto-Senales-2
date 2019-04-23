close all;
h=[5;5];

x0=[-4;4.8];

syms x1 x2
u=[-1;5];
u2=[10;5];
u3=[5;10];
u4=[-1;0];
Cx=[1 0;0 1];

f=2000*(x1-h(1))^2+2000*(x2-h(2))^2+10*x1*x2+2000000/(2*pi*det(Cx))*exp(-1/2*(0.9*(x1-u(1))^2+0.9*(x2-u(2))^2))+2000000/(2*pi*det(Cx))*exp(-1/2*(0.9*(x1-u4(1))^2+0.9*(x2-u4(2))^2))+2000000/(2*pi*det(Cx))*exp(-1/2*(1*(x1-u2(1))^2+0.001*(x2-u2(2))^2))+2000000/(2*pi*det(Cx))*exp(-1/2*(0.001*(x1-u3(1))^2+1*(x2-u3(2))^2));
fsurf(f, [-10 20]);
g=-gradient(f,[x1,x2])
x=x0;
xs=[x];
i=0
while i<500
    g1=double(subs(g(1), [x1 x2], {x(1),x(2)}));
    g2=double(subs(g(2), [x1 x2], {x(1),x(2)}));
    x=x+0.02*[double(g1);double(g2)]/norm([double(g1);double(g2)]);
    xs=[xs x];
    i=i+1;
    norm(x-h)
    x
end
figure;
scatter(transpose(xs(1,:)),transpose(xs(2,:)), 'filled', 'm')

