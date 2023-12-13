clear;
clc;

% EJERCICIO 1

% matriz de comparacion por pares
M = [1 3 5; 1/3 1 9; 1/5 1/9 1]


%aplicar metodo de la potencia
[lambda,w1,error1,IC1] = metodoPotencia(M)
% 
% lambda2_vector = abs(eig(M));
% lambda2 = 1.0385;
% 
% vector_graf = (lambda2 / abs(lambda)).^[1:20];
% 
% %graficar
% % semilogy(0:20,error1','*r',1:20,vector_graf,'*g')

   % Calcular residuos
    Wi = w1 ./ w1';
    residuos = abs(M - Wi)

    % Calcular residuos relativos
    residuos_rel = abs((M - Wi) ./ M);

    % Error global
    err_global = norm(residuos)


% EJERCICIO 2
[w2, fila1H,res2, residuos2_rel,err2] = metodoMinimosPond(3,M)


% %EJERCICIO 3
vect_pesos = [w1 w2]
bar(vect_pesos)

%residuos

%2.
res2
res2max = max(max(res2))

% 
% 
