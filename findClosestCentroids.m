function idx = findClosestCentroids(X, centroids)
% K
K = size(centroids, 1);

% Debes devolver el siguiente vector con los indices de los centroides mas
% cercanos a cada elemento
idx = zeros(size(X,1), 1);
distancias = zeros(size(X,1),K);
for i=1:size(X,1)
    for j=1:K
        distancias(i,j) = sum((X(i,:)-centroids(j,:)).^2);
    end
end
[~,idx] = min(distancias');
idx = idx';