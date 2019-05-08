function [rta] = J_agg(x,y,vol,escena)

a=0.5;
b=0.1;
c=1.5;
e = 0.05;
eta = 0.43/2;

if strcmp(escena,'W204')
   disp('Entre');
   a = 1.1;
   e = 0.003;
end

rta =a/2*distance(x,y)^2;
if vol == 0
    %e = 20;
    rta = rta+(b*c/2)*exp(-(distance(x,y))^2/c);
else
    rta =  rta + b/(2*(distance(x,y)^2-4*eta^2));
end
rta = rta*e;
end

