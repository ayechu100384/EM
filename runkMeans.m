function [centroids, idx] = runkMeans(X, initial_centroids,max_iters, plot_progress)

%   plot_progress true/false flag para indicar si se imprime el progreso 
%   runkMeans devuelve una matriz Kxn con los centroides y un vector idx de m x 1 
%   con el cluster al que pertenece cada elemento
%

if ~exist('plot_progress', 'var') || isempty(plot_progress)
    plot_progress = false;
end

if plot_progress
    figure;
    hold on;
end

% Inicializar los valores
K = size(initial_centroids,1);
centroids = initial_centroids;
previous_centroids = initial_centroids;
%nos los pasan desde el kmeans centroids = kMeansInitCentroids(X, K);

% Ejecutar K-Means
for i=1:max_iters
    
    % Output progress
    fprintf('K-Means iteración %d/%d...\n', i, max_iters);
    
    % Para cada ejemplo en X encontrar el centroide mas cercarno
    idx = findClosestCentroids(X, centroids);
    
    % Optionally, plot progress here
    if plot_progress
        plotProgresskMeans(X, centroids, previous_centroids, idx, K, i);
        previous_centroids = centroids;
        fprintf('Press enter to continue.\n');
        pause;
    end
    
    % Dadas las nuevas asignaciones calcular los nuevos centroides
    centroids = computeCentroids(X, idx, K);
end

% Hold off if we are plotting progress
if plot_progress
    hold off;
end

end

