clear;
clc;

% vector de pesos
w = [0.4 0.25 0.15 0.2]'; %vector
n = length(w);

% MCP -> (mij)=(wi/wj)
M = w ./ w';

% nuevas matrices con ruido
Mk = M;
num_matrices = 3;

%params entrada metodo potencia
x0 = ones(n,1);
tol = 1e-14;

%params salida metodo potencia
autoval_dom = zeros(1, num_matrices);
IC = zeros(1, num_matrices);
vect_pesos1 = zeros(n, num_matrices);
iter = zeros(1,num_matrices);
error = zeros(30,num_matrices);

%generamos matrices con ruido y aplicamos método potencia
for k = 0:2
    Mk(1,2) = M(1,2) * ((100 - 40 * k) / 100);
    Mk(2,1) = 1/Mk(1,2);

    [autoval_dom(k+1), vect_pesos1(:,k+1), errk, iter(k+1), IC(k+1)] = metodoPotenciaTol(Mk, x0, tol);
    error(1:length(errk),k+1) = errk;
    
end


%representar vectores de error para k = 1 y k = 2
semilogy(1:iter(2),error(1:iter(2),2), 'r*',1:iter(3),error(1:iter(3),3),'g*')
legend('k=1','k=2') 
title('Gráfica vectores de error')
