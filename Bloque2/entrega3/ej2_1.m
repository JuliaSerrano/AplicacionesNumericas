clear;
clc;

load web-Stanford.mat;
Problem
A=Problem.A;
whos
spy(A);title('Gráfica de la dispersión de la matriz A')

%APARTADO A: caracteristicas de la matriz A
mostrarCaracteristicas(A)

% APARTADO B: Calcular el pagerank de Standford Web Matrix
alfa = 0.85;
niter = 100; 
[pagerank, ordenpagerank, precision, tiempo,memoria] = calculo_PR(A, alfa, niter);

visualizarPageRank(pagerank);