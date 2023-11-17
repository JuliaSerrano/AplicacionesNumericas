function wi = metodoPond(n, M)
%obtención matriz coeficientes (B)
%obtención términos independientes (b)
num_ecuaciones = n * (n - 1) / 2; % Número de ecuaciones
H = zeros(num_ecuaciones, n);
b = zeros(1, num_ecuaciones);
ecuacion_idx = 1;
% for i = 1:n
%     for j = i+1:n
%         H(ecuacion_idx, i) = -M(i,i);
%         H(ecuacion_idx, j) = M(i,j);
%         ecuacion_idx = ecuacion_idx + 1;
%     end
% end
for i=1:n
    for j=1:n
        if i<j
           H(ecuacion_idx,i)=M(i,i)*-1;
           H(ecuacion_idx,j)=M(i,j);
           ecuacion_idx = ecuacion_idx + 1;
        end
    end
end
H
% Agregar una fila de unos a la matriz de coeficientes
H = [H; ones(1, n)];
H
b = [b,1]
% Resolución del sistema lineal (v = vector de incógnitas)
v = H\b';
% Deshacer la transformación logarítmica para obtener el vector de pesos
wi = v / sum(v);
end