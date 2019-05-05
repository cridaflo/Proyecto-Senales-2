close all;
clc;
clear;

tic
[mius, covs, alphas] = cargar_escena();

%cuad = {[1,0;0,1], [-36;-36], 648};
cuad = {[1,0;0,2], [-27.6;-11.37*2], 50};
paso = 0.05; %Es la factor que multiplica al gradiente de los agentes en cada iteracion.

%Es el minimo de agentes que deben permanecer para continuar la simulacion.
%Recordar que un agente se elimina al llegar al mínimo.
minimoAgentes = 0;

%Es un umbral utilizado para definir cuando se elimina un agente de la
%simulacion.
umbralNorma = 0.5;

syms x y;
f = @(x,y) gauss_m_cuad([x;y], mius, covs, alphas, cuad,0.025/8);
g=-gradient(f, [x,y]);


arf=@(x,y) J_agg(x,y,1);
h=-gradient(arf,[x,y]);

poss = cargar_pos();
equis = poss;
xs = {};
zs = {};
zi = {};
[m,numAgentes] = size(poss);

%Es el número de agentes con el que se inicia la simulación.
numAgentesInicio = numAgentes;
frecuencia = numAgentesInicio*8;

%Es una variable utilizada para indicar los agentes restantes y su
%posición.
j0=1:1:numAgentesInicio;

for i = 1:numAgentes
    p = poss{i};
    xs{i} = p;
    zs{i} = [f(p(1),p(2))];
    zi{i} = [f(p(1),p(2))];
end

%Calcular el mínimo, el punto de salida al que deberían llegar.
i=0;
x0=15;
y0=15;
[min1]=fminsearch(@(z) f(z(1),z(2)) ,[x0,y0] )

while i<1000 && numAgentes > minimoAgentes
    %[m,numAgentes] = size(poss);
    ji=1;
    while ji<numAgentes+1
        j = j0(ji);
        
        pj = poss{j};
        G = double(subs(g, [x y], {pj(1),pj(2)}));
        g1 = G(1);
        g2 = G(2);
        for ki=1:numAgentes
            k = j0(ki);
            if k~=j
                pk = poss{k};
                H = double(subs(h, [x y], {pj(1)-pk(1),pj(2)-pk(2)}));
                g1 = g1+H(1);
                g2 = g2+H(2);
            end
        end
        dist = norm([(min1(1)-pj(1));(min1(2)-pj(2))]);
        norma = norm([g1;g2]);
        
        if dist > umbralNorma
            pj = pj+paso*[g1;g2]/norma;
            poss{j} = pj;
            xs{j} = [xs{j},pj];
            zs{j} = [zs{j}, f(pj(1), pj(2))];
            ji = ji+1;
        else
            dist
            j0(ji) = [];
            numAgentes = numAgentes-1
        end
    end
    if mod(i,frecuencia) == 0
        pintar(f,xs,zs, equis, zi,numAgentesInicio);
        i
    end
    i=i+1
    
end
mensaje = 'se fini'
%pintar(f,xs,zs, equis, zi,numAgentesInicio);
tiempo = toc
i-1

%% Grafica Escena
figure; hold on;  
a0=1;
[mius, covs, alphas] = cargar_escena();
cuad = {[a0,0;0,2*a0], [-20*a0;-11.37*2*a0], 50};
%cuad = {[0,0;0,0], [0;0], 0};

paso = 0.02;

syms x y;
f = @(x,y) gauss_m_cuad([x;y], mius, covs, alphas, cuad,0.025/32);

fsurf(f,[-2 15 -2 8]);

[min1]=fminsearch(@(z) f(z(1),z(2)) ,[x0,y0] );

zmin = f(min1(1),min1(2));

scatter3(min1(1),min1(2),zmin,'filled','MarkerFaceColor','r');
min1