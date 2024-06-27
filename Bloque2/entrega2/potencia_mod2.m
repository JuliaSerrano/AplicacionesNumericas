function [autovalor,pagerank,precision1,precision2,precision,iter] = potencia_mod2(A,nmax,tol)
N = length(A);
x1 = ones(N,1);
iter = 0;
x = x1;
precision1 = -inf;
precision2 = -inf;
precision = -inf;
while precision1 <= tol && precision2 <= tol && iter <=nmax
    x = x1;
    x = x / norm(x);
    x1 = A * x;
    
    autvl =  x' * x1;
    precision1 = norm(A * x - x,2)
    precision2 = abs(autvl - 1)
    precision = max(precision1,precision2)
    iter = iter+1;

 end
autovalor = x' * x1;
pagerank = x/sum(x);

end