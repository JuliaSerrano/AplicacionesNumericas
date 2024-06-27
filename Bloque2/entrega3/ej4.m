clear;
clc;

% Abrir el archivo
fid = fopen('web-BerkStan.txt', 'rt');

% Leer línea por línea, ignorar las líneas de encabezado
tline = fgetl(fid);
while ischar(tline)
    if tline(1) ~= '#'
        break;
    end
    tline = fgetl(fid);
end

% Leer los datos
fromNodes = [];
toNodes = [];
while ischar(tline)
    data = sscanf(tline, '%d %d');
    fromNodes(end+1) = data(1);
    toNodes(end+1) = data(2);
    tline = fgetl(fid);
end
fclose(fid);

% Crear la matriz de conectividad C
N = max(max(fromNodes), max(toNodes)); % Número total de nodos
C = sparse(fromNodes, toNodes, 1, N, N);

alpha = 0.85;

% Calcular el número de enlaces salientes para cada nodo
Nj = sum(C, 2); 
% Identificar nodos sin enlaces de salida
dj = (Nj == 0)'; % Vector lógico de nodos sin salida

% Matriz S inicializada como C
S = C;

% Normalizar las columnas de S para nodos con enlaces de salida
for i = find(~dj)
    S(:, i) = S(:, i) / Nj(i);
end

% Ajustar las columnas para nodos sin enlaces de salida
S(:, dj) = 1 / N;

% Resto de tu código para calcular PageRank...


[pagerank, ordenpagerank, precision, tiempo,memoria] = calculo_PR(S, 0.85, 100);
printf('20 nodos con mayor pagerank:\n')
for i = 1:20
    fprintf('Orden %d Nodo %d Pagerank %.40f\n',i, ordenpagerank(i), pagerank(i));
end
fprintf('---------------------------------------\n')
fprintf('20 nodos con menor pagerank:\n')
for i = numNodos-20:numNodos
    fprintf('Orden %d Nodo %d Pagerank %.40f\n',i, ordenpagerank(i), pagerank(i));
end


precision
tiempo
memoria
visualizarPageRank(pagerank);
