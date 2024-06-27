function [autovalor,x] = potencia(A,niter)
N = length(A);
x1 = ones(N,1);
for k = 1:niter
    x = x1;
    x = x / norm(x);
    x1 = A * x;
end
autovalor = x' * x1;

