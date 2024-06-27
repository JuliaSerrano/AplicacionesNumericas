function visualizarPageRank(pagerank)
    % Crear la figura para el gráfico de barras
    figure;
    
    % Crear el gráfico de barras
    bar(pagerank);
    
    % Configurar la escala logarítmica para el eje Y
    set(gca, 'YScale', 'log');
    
    % Etiquetas y título
    xlabel('Nodos');
    ylabel('PageRank (escala logarítmica)');
    title('PageRank de Stanford Web Matrix');
    
    % Ajustar los ejes para que se ajusten a los datos
    axis tight;
    
    % Activar la cuadrícula para mejorar la visibilidad
    grid on;
end
