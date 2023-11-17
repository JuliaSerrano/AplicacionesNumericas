clear;
clc;

%EJERCICIO 1
% 1. Creación matriz M de comparación por pares
w = [0.88 0.06 0.00033]';
n=length(w);

M = w ./ w';

[wi,residuos, residuos_rel,err_global] = metodoMinimosLog(n,M);
wiP = metodoMinimosPond(n,M);

%EJERCICIO 2

% vector de pesos
w = [0.4 0.25 0.15 0.2]'; %vector
n = length(w);

% MCP -> (mij)=(wi/wj)
M = w ./ w';

% nuevas matrices con ruido
Mk = M;
num_matrices = 3;


vect_pesos2 = zeros(n,num_matrices);
residuos = cell(1, num_matrices);
residuos_rel = cell(1, num_matrices);
err_global = zeros(1, num_matrices);

%generamos matrices con ruido y aplicamos método potencia
for k = 0:2
   %aplicamos ruido (elementos m12 y m21)
   Mk(1,2) = M(1,2) * ((100 - 40 * k) / 100);
   Mk(2,1) = 1/Mk(1,2);

   %aplicamos metodo de minimos cuadrados logaritmicos
   [vect_pesos2(:,k+1),residuos{k+1},residuos_rel{k+1},err_global(k+1)] = metodoMinimosLog(n,Mk);
end

max(max(residuos_rel{1}));
max(max(residuos_rel{2}));
max(max(residuos_rel{3}));

norm(residuos_rel{2});
norm(residuos_rel{3});

ranking = get_ranking(vect_pesos2(:,1)')
bar(vect_pesos2())
vect_pesos2
legend('k = 0','k = 1','k = 2')
title('Gráfica vectores de pesos')
