%Es un codigo auxiliar para visualizar las distancias entre los agentes y
%el minimo.

distances=[];
 for j=1:numAgentes
     pj = poss{j};
     dist = norm([(min1(1)-pj(1));(min1(2)-pj(2))])
     distances=[distances dist];
 end
 
 sort(distances)