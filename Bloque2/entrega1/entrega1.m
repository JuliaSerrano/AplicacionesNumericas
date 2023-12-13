clear;
clc;



%Ejercicio. Calcular e interpretar el pagerank de un grafo 6x6

% Matriz de conectividad
C = [0 0 0 0 0 0;
     1 0 0 1 0 1;
     0 0 0 0 1 1;
     1 1 0 0 0 1;
     0 0 1 1 0 0;
     0 1 0 1 0 0];

N = length(C);

% Vector Nj
Nj = sum(C);

% Matriz transición A
A = C./Nj;
% comprobamos que la suma de las columnas sea 1
sum(A);     %=1
A
% calcular dj
Dj=zeros(1,N);
Dj(find(Nj==0))=1;


%calcular la matriz de transición modificada S
S=C;

% e vector columna de 1′s
e = ones(N, 1);


% Construir la matriz S 
S = A + ((1/N) * e * Dj);

%Calcular el estado 100 de la tabla de estados
r = [1 0 0 0 0 0]';

for i = 1:100
    r = S*r;
end


% Calcular la suma de r
suma_r = sum(r);

S_r = (S*r)';


%Calcular la matriz de Google G para un alfa=0.85.
alfa = 0.85;
G=getG(S, alfa);
sum(G);    %=1

%realizar 100 iteraciones
r = [1 0 0 0 0 0]';

for i = 1:100
    r = G*r;
end
r';

norm(G*r-r);   %2.8222e-08
sum(r);        %1


% Calcular el pagerank r que verifique la siguiente condición de tolerancia, con tol=1e-15
n = length(G);
tol=1e-15;
x0=rand(n,1);

[lambda,r,v_err,iter,IC] = metodoPotenciaTol(G,x0,tol);
pagerank = r';

orden_pagerank = get_ranking(r');  %5 3 4 6 2 1
bar(r)
r

a54 = A(4,5)
a42 = A(2,4)

