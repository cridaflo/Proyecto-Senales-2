function [] = pintar(f,xs,zs, equis, zi,numAgentesInicio)
%% Graficas
figure;
hold on

s = ezsurf(f,[-1 6 -1 8]);
%s = fsurf(f,[-1 6 -1 8]);
%s.EdgeColor = 'none';

colores = hot(numAgentesInicio);

for j = 1:numAgentesInicio
    xss = xs{j};
    p = plot3(transpose(xss(1,:)),transpose(xss(2,:)), zs{j});

    p.Color = colores(j,:);
    p.LineWidth = 1;
end

for j = 1:numAgentesInicio
   xss = xs{j};
   xss = [xss(end-1) xss(end)];
   zss = zs{j};
   zss = zss(end);
   zss = zss;
   
   scatter3(xss(1),xss(2),zss,'o','MarkerFaceColor',[0 0 0], 'MarkerEdgeColor',colores(j,:) );
   
end

for j = 1:numAgentesInicio
   xss = equis{j};
   xss = [xss(1) xss(2)];
   zss = zi{j};
   zss = zss(end);
   zss = zss;
   
   scatter3(xss(1),xss(2),zss,'o','MarkerFaceColor',[1 1 1],'MarkerEdgeColor',colores(j,:));
   
end

end

