function [] = pintar(f,xs,zs, equis, zi,numAgentesInicio,lim)
%Esta funcion se encarga de graficar la posicion actual y la trayectoria
%de los agentes.
figure;
hold on

s = ezsurf(f,lim);

colores = hot(numAgentesInicio);

for j = 1:numAgentesInicio
    xss = xs{j};
    p = plot3(transpose(xss(1,:)),transpose(xss(2,:)), zs{j}+1);

    p.Color = colores(j,:);
    p.LineWidth = 1;
end

for j = 1:numAgentesInicio
   xss = xs{j};
   xss = [xss(end-1) xss(end)];
   zss = zs{j};
   zss = zss(end);
   zss = zss;
   
   scatter3(xss(1),xss(2),zss+1,'o','MarkerFaceColor',[0 0 0], 'MarkerEdgeColor',colores(j,:) );
   
end

for j = 1:numAgentesInicio
   xss = equis{j};
   xss = [xss(1) xss(2)];
   zss = zi{j};
   zss = zss(end);
   zss = zss;
   
   scatter3(xss(1),xss(2),zss+1,'o','MarkerFaceColor',[1 1 1],'MarkerEdgeColor',colores(j,:));
   
end

end

