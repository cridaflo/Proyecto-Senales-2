function [posiciones] = cargar_pos(posiciones)
[num,txt,raw] = xlsread(posiciones);
[m,n] = size(num);
posiciones = {};
for i =1:m
    posiciones{i} = num(i,:)';
end
end

