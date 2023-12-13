function [autovalor, pagerank]=getPageRank(A,niter,N)
    x1=ones(N,1);
    for k=1:niter
        x=x1;
        x=x/norm(x);
        x1=A*x;
    end
    lambda=x'*x1;
    pagerank=x/sum(x);
    autovalor=lambda;
return
end