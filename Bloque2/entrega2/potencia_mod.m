function [autovalor,pagerank,precision1,precision2,precision] = potencia_mod(A,niter)
N = length(A);
x1 = ones(N,1);
for k = 1:niter
    x = x1;
    x = x / norm(x);
    x1 = A * x;
end
autovalor = x' * x1;
pagerank = x/sum(x);
precision1 = norm(A * x - x,2);
precision2 = abs(autovalor - 1);
precision = max(precision1,precision2);