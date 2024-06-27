function [pagerank, ordenpagerank, precision, tiempo,memoria] = calculo_PR(A, alfa, n_iter)
    N = size(A, 1);  % Asumimos que A es cuadrada
    tic;  % Comenzar a medir el tiempo
    e = ones(N, 1);
    Nj = sum(A, 2);  % Suma de cada fila
    dj = double(Nj == 0);  % Vector lógico de nodos sin salida
    v = alfa * dj' + (1 - alfa) * e';
    x = e / N;  % Inicializar x con el vector de unos normalizado
    c = sum(v) / N; 

    for k = 1:n_iter
        x = alfa * A * x + c * e;  % Actualizar x
        x = x / norm(x, 1);  % Normalizar x después de la actualización
    end
    
    Gx = alfa * A * x + c * e;  % Calcular Gx para la precisión
    precision = norm(Gx - x, 1);  % Calcular la precisión con la norma L1
    
    [sortedX, index] = sort(x, 'descend');  % Ordenar x y obtener índices
    pagerank = sortedX / sum(sortedX);  % Normalizar el pagerank
    ordenpagerank = index;  % Orden de los pageranks
    tiempo = toc;  % Obtener el tiempo transcurrido

    % Calcular la memoria usada por 'pagerank'
    pagerankInfo = whos('pagerank');
    memoria = pagerankInfo.bytes / (1024^2);  % Memoria en megabytes
end
