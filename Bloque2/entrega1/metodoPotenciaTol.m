function [lambda,x,v_err,iter,IC] = metodoPotenciaTol(A,x0,tol)
% calcula el autovalor dominante y su autovector asociado
% de la matriz A utilizando el metodo de la potencia.
% El metodo continua iterando hasta que la diferencia entre 2 
% estimaciones consecutivas del autovalor sea <= que la tol o 
% se alcance nmax

%   Entradas:
%   - A: Matriz cuadrada de tamaño nxn.
%   - x0: Vector inicial de tamaño n.
%   - tol: Tolerancia para la convergencia.
%   - nmax: Número máximo de iteraciones.
%
%   Salidas:
%   - lambda: Autovalor dominante.
%   - x: Autovector asociado al autovalor dominante.


n = size(A,1);
if nargin == 1
    x0=rand(n,1); % Vector de arranque, por ejemplo vector aleatorio
    nmax=10;% Nº iteraciones a realizar
    tol = 1e-06; % Tolerancia
end

x0=x0/norm(x0); %normalizamos vector de arranque
x1 = A*x0;
lambda= x0'*x1; % Otra opción lambda= norm(x1);
err = tol + 100;
iter=0;
% while err > tol && iter <= nmax
while norm(A*x1-x1) > tol
    x=x1; x=x/norm(x);
    x1=A*x; lambda_new= x'*x1; % Otra opción lambda= norm(x1);
    err = abs(lambda_new - lambda);
    lambda=lambda_new;
    iter = iter + 1;
    v_err(iter) = err;
    % Imprimir información en cada iteración
    fprintf('Iter: %2d  Lambda: %f  Error: %e\n', iter, lambda, err);

end
x = x/sum(x);
IC = (lambda-n)/(n-1);
fprintf('-----------------------------\n\n')
