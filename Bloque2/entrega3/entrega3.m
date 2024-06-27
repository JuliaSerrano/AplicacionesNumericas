clear;
clc;

% Calcular pagerank de matrices de gran tamaño

%EJERCICIO 1: codificar rutina

% Paso 1: Generar Matriz Aleatoria C
N=150;
p=5;
C = get_randomC(N,p);

% Paso 2: Calcular Matrices A y G
alpha = 0.85;

Nj = sum(C); 
dj=zeros(1,N);
dj(find(Nj==0))=1;          %vector dj
S=C;


% Convertir en array logico
dj_loj = logical(dj);

% calculamos S = A + 1/N * e * dj
S(:,dj_loj)=1/N;
S(:,~dj_loj)=S(:,~dj_loj)./Nj(~dj_loj);



% Paso 3: Calcular PageRank con calculo_PR
niter = 50;  % Número de iteraciones
[pagerank, ordenpagerank, precision, tiempo] = calculo_PR(S, alpha, niter);
G = getG(S,alpha);

sum(pagerank);
bar(pagerank)
set(gca, 'YScale', 'log')  % Cambiar el eje Y a escala logarítmica
xlabel('Nodos')
ylabel('PageRank (escala logarítmica)')
title('Distribución del PageRank en el Grafo (Escala Logarítmica)')
axis tight
grid on


% Paso 4: Comprobar Resultados
% disp('PageRank Calculado:');
% disp(pagerank(1:30));  % Mostrar los primeros 30 valores de PageRank
% disp(['Precisión: ', num2str(precision)]);
% disp(['Tiempo de Ejecución: ', num2str(tiempo), ' segundos']);



% Crear un objeto de grafo dirigido a partir de la matriz C
G = digraph(C, 'omitselfloops'); 

% Escalar los valores de PageRank para usarlos como tamaños de nodo
pagerankScaled = 2 + (pagerank / max(pagerank)) * 15;  

% Dibujar el grafo dirigido
figure;
p = plot(G, 'Layout', 'force', 'NodeLabel', {});  % 'force' para un layout automático
p.NodeCData = pagerank;  % Colorea los nodos basándose en el PageRank
p.MarkerSize = pagerankScaled;  % Ajusta el tamaño de los nodos
colorbar;  % Muestra una barra de colores para interpretar los valores de PageRank
title('Grafo Dirigido con Nodos Escalados por PageRank');


%EJERCICIO 2




