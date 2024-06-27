function [pagerank, ordenpagerank, precision, tiempo] = calculo_PR2(A, alfa, n_iter)
    N = length(A); 
    tic 
    e = ones(N, 1);
    eT = ones(1, N);
    Nj = sum(A);
    dj = Nj;
    dj(find(Nj == 0)) = 1;
    dj(find(Nj ~= 0)) = 0;
    v = alfa * dj' + (1 - alfa) * e';
    x = ones(N, 1);
    for k = 1:n_iter
        x = x / norm(x);
        x = alfa * A * x + ((eT * v) * x) / N;
    end
    Gx = alfa * A * x + ((eT * v) * x) / N;
    precision = norm(Gx - x);
    [sortedX, index] = sort(x, 'descend');
    pagerank = x / sum(x);
    ordenpagerank = index;
    tiempo = toc;  
end