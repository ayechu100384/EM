function centroids = kMeansInitCentroids(X, K)

% Debes devolver los centroides iniciales de forma aleatoria
centroids = zeros(K, size(X, 2));
pos = zeros(K,1);

for i=1:K
    pos(i) = randi(size(X, 1));
end
centroids = X(pos,:);

end

