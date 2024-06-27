clear;
clc;
clear all;

% EJERCICIO 1

    %A: Calcular la matriz G de Google del grafo

% Nodos de entrada (Origen de las flechas)
i=[1 1 1 2 2 3 3 4 4 6 6 7 7]; 
% Nodos de salida (Destino de las flechas)
j=[2 4 5 3 7 4 6 2 7 5 7 2 4];
% Dimensión de la matriz
N=7; 

% matriz dispersa. Matriz C con 13 1s (cada flecha),
C=sparse(j,i,1,N,N); %C(i,j)=1 si Pj -> Pi
 
% visualizar matriz completa (con 0s tambien)
full(C);
% Creamos la matriz completa
Ccompleta=full(C);
% Vemos el tamaño que ocupan en memoria las matrices C y Ccompleta 
% (C menor espacio ya que no tiene los 0s)
% whos;

% calcular vector Nj. No todos los nodos tienen salida. Nodo 5 = 0 links de
% salida
C
[num_links, nodoMax] = max(sum(C, 1))
% a(1)
% nodoMax
% numLinksSalida = C(:,nodoMax);
% numLinksSalida = sum(numLinksSalida(:,1))
% numLinksSalida = sum(C(nodoMax, :))
Nj = sum(C);

%calcular vector dj (solo el nodo 5 es un nodo sin salida dj(5) == 1)
dj=zeros(1,N);
dj(find(Nj==0))=1;

% Calcular matriz de transición modificada S
A = C./Nj


nodosConSalida = sum((sum(C, 2) > 0));
nodosSinSalida = size(A, 1) - nodosConSalida;

S=C;

% Convertir en array logico
dj_loj = logical(dj);

% calculamos S = A + 1/N * e * dj
S(:,dj_loj)=1/N;
S(:,~dj_loj)=S(:,~dj_loj)./Nj(~dj_loj);
S
%calcular matriz G con param alfa=0.85
G = getG(S,0.85);
% suma de elementos de sus columnas == 1 --> matriz estocástica
sum_G = sum(G);



    %B: Teorema de Perron-Frobenius


% Para que la matriz G verifique el teorema de Perron-Frobenius se deben
% cumplir las siguientes condiciones de entrada:

    %a. Matriz irreducible
    %b. Matriz sin elementos negativos
    %c. Suma de elementos de columnas == 1 


% Segun el Teorema de Perron-Frobenius: Si S es una matriz irreducible,
% estostática y no negativa se deberan cumplir las siguientes condiciones
% de salida --> mayor autovalor de S = 1 (autovalor dominante)
% y su autovector (autovector dominante) tiene todos sus elementos no negativos

%matriz diagonal D de autovalores y matriz de columnas de autovectores
[V, D] = eig(G);

% Encuentra el autovalor dominante y su índice
[~, index] = max(abs(diag(D)));

% Extrae el autovalor y el autovector dominante
autovalor_dominante = D(index, index);  %1
autovector_dominante = V(:, index);     %autovector con todos los elementos no negativos

%Compobracion teorema Perron-Frobenius



    %C: Método de la potencia
%metodo potencia
[lambda,x] = potencia(G,50); %lambda y x son los autovalor y autovector obtenido anteriormente


%utilizando definicion G * x = lambda * x. Se verifica la definicion
G_x = G*x;
lambda_x = lambda * x;

% precisiones obtenidas con metodo potencia
precision1 = norm(G * x - x,2);
precision2 = abs(lambda - 1);
precision = max(precision1,precision2);



    %D: Calcular pagerank del grafo

pagerank = x/sum(x);
sum(pagerank);  %=1

% metodo de la potencia con pagerank como salida, al menos 12 cifras prec.
[lambda,pagerank,precision1,precision2,precision]=potencia_mod(G,50);



orden_pagerank = get_ranking(pagerank');  %P7 > P2 > P4 > P3 > P6 > P5 > P1
% bar(pagerank)

% EJERCICIO 2

i = [3 3 5 7 7 8 11 11];    %nodos de entrada
j = [8 10 11 8 11 9 9 10];  %nodos de salida
N = 11;                      %dimension matriz
alfa = 0.85;
niter = 50;
[pagerank, orden_pagerank] = get_pagerank(N,i,j,alfa,50);

%orden pagerank =      9    10    11     8     1     2     3     4     5     6     7


% EJERCICIO 3

[ordenpagerank1,precision1, memoria_usada1, tiempo_cpu1] = CalculoPageRank(1000,20,100);
[ordenpagerank2,precision2, memoria_usada2, tiempo_cpu2] = CalculoPageRank(10000,20,1000);
[ordenpagerank3,precision3, memoria_usada3, tiempo_cpu3] = CalculoPageRank(100000,20,10000);





