function centroids = computeCentroids(X, idx, K)
[m,n] = size(X);
% Debes devolver los nuevos centroides
centroids = zeros(K, n);
for i=1:K
    centroids(i,:) = mean(X((idx==i),:));
end

