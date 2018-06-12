%Práctica 3: Aprendizaje no supervisado EM
%% 1.Algoritmo Maximización-Expectación
%limpiamos el workspace y cargamos los datos
clear;
load('ex7data2.mat');
%plot(X(:,1), X(:,2), '+')
numClusters = 3;
[numEjemplos,numAtr] = size(X);
%INICIALIZAMOS TODOS LOS PARÁMETROS
%inicializamos las matrices de covarianza aleatoriamente
matricesCov = cell(numClusters,1);
for i=1:numClusters
    matricesCov{i} = zeros(numAtr,numAtr);
    for j=1:numAtr
        matricesCov{i}(j,j) = rand;
    end
end
%inicializamos las probabilidades de cada cluster aleatoriamente (suman 1)
probZ = [1/numClusters 1/numClusters 1/numClusters];
%inicializamos medias,la media de cada atributo para cada clase
medias = rand(numClusters,numAtr);
%Ejecutamos el algoritmo EM
[matricesCov,medias] = EM(X,numClusters,numAtr,numEjemplos,matricesCov,medias,probZ);
%Calculamos la distribución correspondiente a la solución
probabilidades = zeros(numClusters,numEjemplos);
for i=1:numClusters
    probabilidades(i,:) = multigaussiana(X,medias(i,:),matricesCov{i});
end
[~,prediccion] = max(probabilidades);
%Calculamos el porcentaje de aciertos
%[~,RI,~,~] = RandIndex(y,prediccion')

%% 2.Gráfico de los ejemplos y las líneas de contorno de cada distribución
%Gráfico con los ejemplos clasificados
%obtenemos la distribución gaussiana multivariable
x1 = (-1:0.1:9);
x2 = (-1:0.1:9);
prob = zeros(length(x1));
figure;
plot(X(:,1),X(:,2),'or');
hold on;
for z=1:numClusters
    for i=1:length(x1)
        for j=1:length(x2)
            prob(i,j) = multigaussiana([x1(i),x2(j)],medias(z,:),matricesCov{z});  
        end 
    end
    contour(x1,x2,prob');
end
%contour(x1,x2,prob); 
%surf(x1,x2,prob);

%% 3.Comparación k-means, clustering jerárquico y EM
clear all;
load('datos3.mat');
plot(X(:,1), X(:,2), '+')
numClusters = 3;
[numEjemplos,numAtr] = size(X);

%Llamada k-means
plot_progress = 1;
max_iters = 10;
initial_centroids =  kMeansInitCentroids(X, numClusters);
[centroids, idx] = runkMeans(X, initial_centroids, max_iters, 0);%plot_progress
gscatter(X(:,1), X(:,2), idx);
[~,RIkmeans,~,~] = RandIndex(y,idx);

%Llamada clustering jerárquico
% single-link
Z = linkage(X, 'single');
P = cluster(Z, 'maxclust', numClusters) ;
gscatter(X(:,1), X(:,2), P);
[~,RIsingleL,~,~] = RandIndex(y,P);
% complete-link
Z = linkage(X, 'complete');
P = cluster(Z, 'maxclust', numClusters);
gscatter(X(:,1), X(:,2), P);
[~,RIcompleteL,~,~] = RandIndex(y,P);
% average-link
Z = linkage(X, 'average');
P = cluster(Z, 'maxclust', numClusters);
gscatter(X(:,1), X(:,2), P);
[~,RIaverageL,~,~] = RandIndex(y,P);
%Llamada EM
%inicializamos las matrices de covarianza aleatoriamente
matricesCov = cell(numClusters,1);
for i=1:numClusters
    matricesCov{i} = zeros(numAtr,numAtr);
    for j=1:numAtr
        matricesCov{i}(j,j) = rand;
    end
end
%inicializamos las probabilidades de cada cluster aleatoriamente (suman 1)
probZ = [1/numClusters 1/numClusters 1/numClusters];
%inicializamos medias,la media de cada atributo para cada clase
medias = rand(numClusters,numAtr);
%Ejecutamos el algoritmo EM
[matricesCov,medias] = EM(X,numClusters,numAtr,numEjemplos,matricesCov,medias,probZ);
%Calculamos la distribución correspondiente a la solución
probabilidades = zeros(numClusters,numEjemplos);
for i=1:numClusters
    probabilidades(i,:) = multigaussiana(X,medias(i,:),matricesCov{i});
end
[~,prediccion] = max(probabilidades);
[~,RIEM,~,~] = RandIndex(y,prediccion');
x1 = (-5:0.1:4);
x2 = (-5:0.1:4);
prob = zeros(length(x1));
figure;
gscatter(X(:,1), X(:,2), prediccion);
hold on;
for z=1:numClusters
    for i=1:length(x1)
        for j=1:length(x2)
            prob(i,j) = multigaussiana([x1(i),x2(j)],medias(z,:),matricesCov{z});  
        end 
    end
    contour(x1,x2,prob');
end