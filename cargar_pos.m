function [posiciones] = cargar_pos()
[num,txt,raw] = xlsread('posiciones_W204.xlsx');
[m,n] = size(num);
posiciones = {};
for i =1:m
    posiciones{i} = num(i,:)';
end
end

