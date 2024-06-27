function [ordenpagerank, precision, memoria_usada, tiempo_cpu]  = CalculoPageRank(N,p,niter)
% N = dimension
% p = numero medio de links
% niter = numero de iteraciones

% Iniciar temporizador
tic;

i=randi(N,1,p*N);
j=randi(N,1,p*N);
C=sparse(i,j,1,N,N);
alpha = 0.85;

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
G = getG(S,alpha);

% metodo de la potencia con pagerank como salida
[lambda,pagerank,precision1,precision2,precision]=potencia_mod(G,niter);

ordenpagerank = get_ranking(pagerank');

 % Detener el temporizador
 tiempo_cpu = toc;

 % Medir la memoria utilizada
 memoria_info = memory;
 memoria_usada = memoria_info.MemUsedMATLAB / (1024 ^ 2); % Convertir a megabytes


 % Mostrar resultados
 fprintf('N = %d, p = %d, niter = %d\n', N, p, niter);
 fprintf('Tiempo de CPU: %.4f segundos\n', tiempo_cpu);
 fprintf('Memoria utilizada: %.4f MB\n', memoria_usada);
 fprintf('Precision1 obtenida: %.4e\n', precision1);
 fprintf('Precision2 obtenida: %.4e\n', precision2);
 fprintf('Precision obtenida: %.4e\n', precision);
 fprintf('---------------------------------------\n');



end

