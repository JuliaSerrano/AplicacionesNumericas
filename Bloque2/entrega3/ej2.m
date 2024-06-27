clear;
clc;

load web-Stanford.mat;
Problem
A=Problem.A;
whos
spy(A);title('Gráfica de la dispersión de la matriz A')

[filas,columnas] = size(A);
isSquare = (filas == columnas); %el numero de filas es igual que el numero de columnas -> matriz cuadrada
fprintf('La matriz es cuadrada: %s\n', mat2str(isSquare));

numNodos = filas; % tiene 281903 nodos
fprintf('Número total de nodos: %d\n', numNodos);

isSparse = issparse(A); %true --> se trata de una matriz dispersa
fprintf('La matriz es dispersa: %s\n', mat2str(isSparse));

memoryInfo = whos('A'); %39255184 bytes
fprintf('Memoria utilizada por A: %d bytes\n', memoryInfo.bytes);

numNonZero = nnz(A); %elementos no nulos = 2312497
fprintf('Número de elementos no nulos en A: %d\n', numNonZero);

%B = A - 1;  %excede capacidad de memoria, ya que al tratarse de una matriz
%dispersa (mayor parte de sus elementos son 0 y estos no se almacenan 
% explicitamente en memoria). Si restamos -1, obtendremos
%una matriz con muy pocos elementos nulos, transformando la matriz dispersa
%en una matriz completa

numOnes = nnz(A == 1); %La matriz tiene 2312497 1s
numZeros = numel(A)-nnz(A); % La matriz tiene 7.9467e+10 0s
numOthers = numel(A) - numOnes - numZeros; %0 elementos distintos de 1 Y 0
fprintf('Número de 1s en A: %d\n', numOnes);
fprintf('Número de 0s en A: %.4e\n', numZeros);
fprintf('Número de elementos en A distintos de 0 y 1: %d\n', numOthers);


subMatrix = A(1:1000, 1:1000);
numNonZeroSub = nnz(subMatrix);  %en la submatriz hay 18 elementos no nulos
nnz(subMatrix == 1); % y comprobamos que los 18 elementos no nulos son 1 
% (lo esperado ya que vimos anteriormente que todos los elementos != 0 eran 1s)
fprintf('Número de elementos no nulos en la submatriz 1000x1000: %d\n', numNonZeroSub);


d = nnz(subMatrix)/numel(subMatrix); %solo el 0.0018% de los elementos de la submatriz son != 0
fprintf('Índice de dispersión en la submatriz 1000x1000: %f\n', d);

[num_links, nodoMax] = max(sum(A, 1));  % el nodo con mayor numero de links
% de salida es el 226411 que cuenta con 38606 links de salida
num_links = full(num_links);
fprintf('Nodo con el máximo número de links de salida: %d, con %d links\n', nodoMax, num_links);


% qué tipo de matriz es de las descritas en las diapositivas

%Como comprobamos anteriormente, la matriz A SÍ es dispersa --> 
% no es matriz G ya que esta se trata de una matriz densa

N = size(A, 1);  % Número total de nodos
totalEnlacesSalida = nnz(A);  % Número total de enlaces de salida en la red
r = totalEnlacesSalida / N;  % Número medio de enlaces de salida = 8.2032

cumple_conectividad = nnz(A) == r * N ; % Sí cumple la propiedad de conectividad --> se trata de una matriz C de conectividad
fprintf('La matriz cumple con la propiedad de conectividad: %s\n', mat2str(cumple_conectividad));

% no se trata de una matriz de transición A ya que los elementos son 0 o 1
% como hemos comprobado antes y no probabilidades como en la matriz A
Nj = sum(A); 
dj=zeros(1,N);
dj(find(Nj==0))=1;          %vector dj
cumple_transicion_modificada = nnz(A) == r* N + N * nnz(dj);    %   falso por lo tanto no se trata de una matriz de transicion modificada S
% aparte no puede ser S por la misma razon que no puede ser A. Los valores
% no son probabilidades sino conexión entre nodos = 1 o falta de conexión
% entre nodos = 0
fprintf('La matriz cumple con la propiedad de una matriz de transición modificada: %s\n', mat2str(cumple_transicion_modificada));


%indice de dispersion de A
d = nnz(A)/numel(A); %indice de dispersion = 2.9099e-05. Solo el 0.0029% de los elementos de la matriz A son != 0
fprintf('Índice de dispersión de A: %e\n', d);


nodosConSalida = full(sum((sum(A, 2) > 0))); % hay 281731 nodos con salida
nodosSinSalida = full(sum((sum(A, 2) == 0))); % hay 172 nodos sin salida
fprintf('Número de nodos con salida: %d\n', nodosConSalida);
fprintf('Número de nodos sin salida: %d\n', nodosSinSalida);

% Identificar los índices de los nodos que no tienen salida

% Mostrar los índices de los nodos sin salida
% Identificar los índices de los nodos que no tienen salida
indicesSinSalida = find(sum(A, 2) == 0);

% Mostrar los índices de los nodos sin salida con formato más amigable
% fprintf('Lista de nodos sin salida (total: %d nodos):\n', length(indicesSinSalida));
% for i = 1:length(indicesSinSalida)
%     fprintf('Nodo %d\n', indicesSinSalida(i));
% end



%comprobar que se verifica la relacion dada
verifica_relacion = N == nodosConSalida + nodosSinSalida; % si se verifica
fprintf('Se verifica la relación de numero nodos = nodos sin salida + nodos con salida: %s\n', mat2str(verifica_relacion));


% APARTADO B: Calcular el pagerank de Standford Web Matrix
alfa = 0.85;
niter = 100; 
[pagerank, ordenpagerank, precision, tiempo] = calculo_PR(A, alfa, niter);

bar(pagerank)
set(gca, 'YScale', 'log')  % Cambiar el eje Y a escala logarítmica
xlabel('Nodos')
ylabel('PageRank (escala logarítmica)')
title('PageRank de Stanford Web Matrix');
axis tight
grid on

pagerank(1:20);
fprintf('20 nodos con mayor pagerank:\n')
for i = 1:20
    fprintf('Orden %d Nodo %d Pagerank %.40f\n',i, ordenpagerank(i), pagerank(i));
end
fprintf('---------------------------------------\n')
fprintf('20 nodos con menor pagerank:\n')
for i = numNodos-20:numNodos
    fprintf('Orden %d Nodo %d Pagerank %.40f\n',i, ordenpagerank(i), pagerank(i));
end














