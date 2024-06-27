function [pagerank, orden_pagerank] = get_pagerank(N,i,j,alfa,niter)

% i = [3 3 5 7 7 8 11 11];    %nodos de entrada
% j = [8 10 11 8 11 9 9 10];  %nodos de salida
% N = 11;                      %dimension matriz

C=sparse(j,i,1,N,N);        %matriz dispersa
Nj = sum(C);                %vector Nj
dj=zeros(1,N);
dj(find(Nj==0))=1;          %vector dj

% Calcular matriz de transición modificada S
A = C./Nj;
S=C;

% Convertir en array logico
dj_loj = logical(dj);

% calculamos S = A + 1/N * e * dj
S(:,dj_loj)=1/N;
S(:,~dj_loj)=S(:,~dj_loj)./Nj(~dj_loj);

%calcular matriz G
G = getG(S,alfa);

[lambda,pagerank,precision1,precision2,precision]=potencia_mod(G,niter);

orden_pagerank = get_ranking(pagerank');
bar(pagerank)

end