close all;
clc;
clear;

tic

%Especificar en esta variable la escena que se desea cargar.
%Existen 2 opciones: 'W204' o 'PU300'.
escena = 'PU300';

%Carga la escena dependiendo de un excel. 
%Esta escena define las diferentes gaussianas necesarias para formar el 
%layout del salón (sus normas, covarianzas y el factor al cual están 
%escalados).
[mius, covs, alphas] = cargar_escena(['escena_' escena '.xlsx']);

pTam = struct('W204',[-2 16 -2 8],'PU300',[-1 6 -1 8]);
pCuad = struct('W204',[0.5, 0.02, -32,-12],'PU300',[0.1, 0.5/4, 1,-1.35]);

param = pCuad.(escena);
min = param(3:4);
fact = param(2);

cuad = {[1,0;0,1], [min(1);min(2)], 50};

%Es el factor que multiplica al gradiente de los agentes en cada iteracion.
paso = 0.05; 

%Indica si los agentes van a tener radio (1) o no (0).
vol = 1;

%Es el minimo de agentes que deben permanecer para continuar la simulacion.
%Recordar que un agente se elimina al llegar al mínimo.
minimoAgentes = 0;

%Es un umbral utilizado para definir cuando se elimina un agente de la
%simulacion.
umbralNorma = param(1);

syms x y;

%Gauss_m_cuad es la función que realiza la sumatoria de las diferentes
%gauseanas y la cuadrática para definir el layout como esta gran 
%sumatoria de funciones. Luego se precalcula el gradiente simbólico
f = @(x,y) gauss_m_cuad([x;y], mius, covs, alphas, cuad, fact);
g=-gradient(f, [x,y]);

%J_agg es la función que calcula la función de atracción-repulsión de los
%agentes entre sí. También se precalcula el gradiente simbólico
arf=@(x,y) J_agg(x,y,vol,escena);
h=-gradient(arf,[x,y]);

%Se cargan las posiciones iniciales de los agentes
poss = cargar_pos(['posiciones_' escena '.xlsx']);
equis = poss;
xs = {};
zs = {};
zi = {};
[m,numAgentes] = size(poss);

%Es el número de agentes con el que se inicia la simulación.
numAgentesInicio = numAgentes;

%Es una variable usada para definir cada cuantas iteraciones se grafica el
%estado actual de la simulacion.
frecuencia = numAgentesInicio;

%Es una variable utilizada para indicar los agentes restantes y su
%posición.
j0=1:1:numAgentesInicio;

disp(['Simulando la escena ' escena ' ...']);

for i = 1:numAgentes
    p = poss{i};
    xs{i} = p;
    zs{i} = [f(p(1),p(2))];
    zi{i} = [f(p(1),p(2))];
end

%Calcular el mínimo, el punto de salida al que deberían llegar.
i=0;
x0=3;
y0=5;
[min1]=fminsearch(@(z) f(z(1),z(2)) ,[x0,y0] )

%Aquí comienza la simulación, en cada iteración cada agente se mueve una
%distancia definida por su paso hasta llegar al final
while i<1000 && numAgentes > minimoAgentes
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
        
        %En caso que se supere un umbral el agente es retirado porque se
        %asume que ya escapó
        if dist > umbralNorma
            pj = pj+paso*[g1;g2]/norma;
            poss{j} = pj;
            xs{j} = [xs{j},pj];
            zs{j} = [zs{j}, f(pj(1), pj(2))];
            ji = ji+1;
        else
            dist
            j0(ji) = [];
            numAgentes = numAgentes-1;
            disp(['El número de agentes restantes es: ' numAgentes]);
        end
    end
    if mod(i,frecuencia) == 0
        pintar(f,xs,zs, equis, zi,numAgentesInicio,pTam.(escena));
        title(['Iteration ' num2str(i)]);
        i
    end
    i=i+1;
    
end
mensaje = 'Finalizado'
pintar(f,xs,zs, equis, zi,numAgentesInicio,pTam.(escena));
tiempo = toc
i-1

%% Grafica Escena
% Quitarle el comentario a estas lineas si se desea graficar unicamente la
% escena.

% figure; hold on;  
% 
% escena = 'PU300';
% [mius, covs, alphas] = cargar_escena(['escena_' escena '.xlsx']);
% 
% pTam = struct('W204',[-2 16 -2 8],'PU300',[-1 6 -1 8]);
% pCuad = struct('W204',[1, 0.02, -32,-12],'PU300',[1, 0.5/4, 1,-1.35]);
% 
% param = pCuad.(escena);
% a0 = param(1);
% min = param(3:4);
% fact = param(2);
% 
% cuad = {[1,0;0,a0], [min(1);min(2)], 50};
% 
% paso = 0.02;
% 
% syms x y;
% f = @(x,y) gauss_m_cuad([x;y], mius, covs, alphas, cuad, fact);
% 
% %Con ezsurf es mas rapido.
% ezsurf(f,pTam.(escena));
% 
% %ezsurf(f,[-2 13 -2 8]);
% %fsurf(f,[-1 6 -1 8]);
% 
% x0 = 3;
% y0 = 5;
% [min1]=fminsearch(@(z) f(z(1),z(2)) ,[x0,y0] );
% 
% zmin = f(min1(1),min1(2));
% 
% scatter3(min1(1),min1(2),zmin+0.1,'filled','MarkerFaceColor','r');
% min1
% 
% title(['Scenario for classroom ' escena]);

%% Guardar Figuras y Workspace
%Es la ubicacion en donde se van a guardar las simulaciones.
ubicacion = ['./Resultados/lf_simu_' num2str(numAgentesInicio) '_' num2str(vol) '_' escena];
mkdir(ubicacion);

FolderName = ubicacion;

%En las siguientes lineas se guardan todas las figuras de la simulacion
%junto con el workspace. 
FigList = findobj(allchild(0), 'flat', 'Type', 'figure');

numFigs = length(FigList);

for iFig = 1:numFigs
  FigHandle = FigList(iFig);
  FigName   = ['F' num2str(iFig)];
  set(0, 'CurrentFigure', FigHandle);
  savefig(fullfile(FolderName, [FigName '.fig']));
end
  
save([ubicacion '/Workspace']);
