load web-Google;
Problem
A=Problem.A;
whos
% spy(A);title('Gráfica de la dispersión de la matriz A')

mostrarCaracteristicas(A);
alfa = 0.85;
niter = 100; 
[pagerank, ordenpagerank, precision, tiempo,memoria] = calculo_PR(A, alfa, niter);

fprintf('20 nodos con mayor pagerank:\n')
for i = 1:20
    fprintf('Orden %d Nodo %d Pagerank %.40f\n',i, ordenpagerank(i), pagerank(i));
end
fprintf('---------------------------------------\n')
fprintf('20 nodos con menor pagerank:\n')
for i = numNodos-20:numNodos
    fprintf('Orden %d Nodo %d Pagerank %.40f\n',i, ordenpagerank(i), pagerank(i));
end


precision
tiempo
memoria
visualizarPageRank(pagerank);