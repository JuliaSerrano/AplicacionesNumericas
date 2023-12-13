function [lambda,x,errores,IC] = metodoPotencia(A,x0,nmax)
% calcula el autovalor dominante (mayor valor absoluto) 
% y su vector de pesos utilizando el método de 
% la potencia.
%   Entradas:
%   - A: Matriz cuadrada de tamaño nxn.
%   - x0: Vector inicial de tamaño n.
%   - nmax: Número máximo de iteraciones.
%
%   Salidas:
%   - lambda: Autovalor dominante.
%   - x: Vector de pesos (debe ser positivo y suma de comp = 1)
%   - errores: Vector de errores(autovalor) en cada iteración.
%   - IC: Índice de Consistencia
n = size(A,1);
if nargin == 1

    x0=rand(n,1); % Vector de arranque, por ejemplo vector aleatorio
    nmax=20;% Nº iteraciones a realizar
end

lambda_prev = 0;   % Inicialización para el error en el autovalor
x=x0/norm(x0); % Normalizamos
errores = zeros(nmax, 1);  % Vector para almacenar los errores
vector_lamda = zeros(1,nmax);

for k=0:nmax
    x1 = A * x;  %transformacion de x por A
    lambda = x' * x1; %==norm(x1)  estimacion del autovalor dominante de A
    x = x1/norm(x1);
    
    % Estimación del error en el autovalor
    error_autovalor = abs(lambda - lambda_prev);
    errores(k+1) = error_autovalor;

    
    % Imprimir información en cada iteración
    fprintf('Iter: %2d  Lambda: %f  Error: %e\n', k, lambda, error_autovalor);
    
    % Actualizar valores previos
    lambda_prev = lambda;
    % vector_lamda(k+1) = 
end
x = x/sum(x);   %normalizar vector de pesos
IC = (lambda-n)/(n-1);  %cálculo Indice de Consistencia

