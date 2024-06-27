function C = get_randomC(N,p)
    i=randi(N,1,p*N);
    j=randi(N,1,p*N);
    C=sparse(j,i,1,N,N);


end

