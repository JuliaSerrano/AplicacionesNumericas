function mostrarCaracteristicas(A)
    % Determinar el tamaño y si la matriz es cuadrada
    [filas, columnas] = size(A);
    isSquare = (filas == columnas);
    fprintf('La matriz es cuadrada: %s\n', mat2str(isSquare));

    % Número total de nodos
    numNodos = filas;
    fprintf('Número total de nodos: %d\n', numNodos);

    % Verificar si la matriz es dispersa
    isSparse = issparse(A);
    fprintf('La matriz es dispersa: %s\n', mat2str(isSparse));

    % Mostrar la memoria utilizada por la matriz
    memoryInfo = whos('A');
    fprintf('Memoria utilizada por A: %d bytes\n', memoryInfo.bytes);

    % Número de elementos no nulos en la matriz
    numNonZero = nnz(A);
    fprintf('Número de elementos no nulos en A: %d\n', numNonZero);

    % Número de unos y ceros en la matriz
    numOnes = nnz(A == 1);
    numZeros = numel(A) - nnz(A);
    fprintf('Número de 1s en A: %d\n', numOnes);
    fprintf('Número de 0s en A: %.4e\n', numZeros);

    % Número de elementos distintos de 1 y 0
    numOthers = numel(A) - numOnes - numZeros;
    fprintf('Número de elementos en A distintos de 0 y 1: %d\n', numOthers);

    % Características de la submatriz
    subMatrix = A(1:1000, 1:1000);
    numNonZeroSub = nnz(subMatrix);
    fprintf('Número de elementos no nulos en la submatriz 1000x1000: %d\n', numNonZeroSub);

    % Índice de dispersión en la submatriz
    d = nnz(subMatrix)/numel(subMatrix);
    fprintf('Índice de dispersión en la submatriz 1000x1000: %f\n', d);

    % Nodo con el máximo número de links de salida
    [num_links, nodoMax] = max(sum(A, 1));
    num_links = full(num_links);
    fprintf('Nodo con el máximo número de links de salida: %d, con %d links\n', nodoMax, num_links);

    % Comprobar si la matriz cumple con la propiedad de conectividad y transición modificada
    totalEnlacesSalida = nnz(A);
    r = totalEnlacesSalida / numNodos;
    cumple_conectividad = nnz(A) == r * numNodos;
    fprintf('La matriz cumple con la propiedad de conectividad: %s\n', mat2str(cumple_conectividad));

    Nj = sum(A);
    dj = zeros(1, numNodos);
    dj(Nj == 0) = 1;
    cumple_transicion_modificada = nnz(A) == r * numNodos + numNodos * nnz(dj);
    fprintf('La matriz cumple con la propiedad de una matriz de transición modificada: %s\n', mat2str(cumple_transicion_modificada));

    % Índice de dispersión de A
    d = nnz(A)/numel(A);
    fprintf('Índice de dispersión de A: %e\n', d);

    % Número de nodos con y sin salida
    nodosConSalida = full(sum(sum(A, 2) > 0));
    nodosSinSalida = full(sum(sum(A, 2) == 0));
    fprintf('Número de nodos con salida: %d\n', nodosConSalida);
    fprintf('Número de nodos sin salida: %d\n', nodosSinSalida);

    % Verificar la relación de nodos
    verifica_relacion = numNodos == nodosConSalida + nodosSinSalida;
    fprintf('Se verifica la relación de número de nodos = nodos sin salida + nodos con salida: %s\n', mat2str(verifica_relacion));
end
