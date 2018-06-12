function [ matricesCov,medias ] = EM(X,numClusters,numAtr,numEjemplos,matricesCov,medias,probZ)
    mediasAnt =  Inf*ones(numClusters,numAtr);
    while sum(sum(abs(medias-mediasAnt))) > 10^-5
        %ESTIMAR
        %prob de un ejemplo para cada clase
        probabilidades = zeros(numClusters,numEjemplos);
        for i=1:numClusters
            probabilidades(i,:) = multigaussiana(X,medias(i,:),matricesCov{i});
        end
        %probabilidad de pertenencia de un ejemplo a cada clase
        probPertenencia = zeros(numClusters,numEjemplos);
        for i=1:numClusters
            for j=1:numEjemplos
                probPertenencia(i,j) = probZ(i) * probabilidades(i,j) / sum( probZ(1:end)*probabilidades(1:end,j) ) ;
            end
        end

        %MAXIMIZAR
        %recalculamos la prob de cada clase
        for i=1:numClusters
            probZ(i) = (1./numEjemplos) * sum(probPertenencia(i,:));
        end
        %recalculamos la media de cada atributo para cada clase
        mediasAnt = medias;
        for j=1:numClusters
            medias(j,:) = (probPertenencia(j,1:end)*X(1:end,:)) / sum(probPertenencia(j,1:end));
        end
        %recalculamos la matriz de covarianzas
        %matricesCov = cell(numClusters,1);
        for i=1:numClusters
            resta = bsxfun(@minus,X,medias(i,:));
            aux = ( probPertenencia(i,:) * (resta).^2 ) / ( sum(probPertenencia(i,:)) );   
            for j=1:numAtr
                matricesCov{i}(j,j) = aux(j);
            end
        end
    end
end

