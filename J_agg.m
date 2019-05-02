function [rta] = J_agg(x,y,vol)

a=1;
b=2;
c=1;
e = 20;
eta = 0.2;
rta =a/2*distance(x,y)^2;
if vol == 0
    e = 20;
    rta = rta+(b*c/2)*exp(-(distance(x,y))^2/c);
else
    rta =  rta + b/(2*(distance(x,y)^2-4*eta^2));
end
rta = rta*e;
end

