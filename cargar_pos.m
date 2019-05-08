function [posiciones] = cargar_pos(posiciones)

%Esta funcion se encarga de cargar las posiciones de todos los agentes
%ubicadas en el archivo de excel indicadas por la escena.

[num,txt,raw] = xlsread(posiciones);
[m,n] = size(num);
posiciones = {};
for i =1:m
    posiciones{i} = num(i,:)';
end
end

