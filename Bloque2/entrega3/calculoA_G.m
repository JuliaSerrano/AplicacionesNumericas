function [A,G] = calculoA_G(N,p,alpha)
% N = dimension
% p = numero medio de links
i=randi(N,1,p*N);
j=randi(N,1,p*N);
C=sparse(i,j,1,N,N);
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
end

