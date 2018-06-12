function [probabilidad] = multigaussiana(X,media,covarianza)
    [numEjemplos,numAtr] = size(X);
    probabilidad = zeros(1,numEjemplos);
    for i=1:numEjemplos
        numerador = exp( -(1/2) * (X(i,:)-media) * inv(covarianza) * (X(i,:)-media)'    );
        denominador = ( (2*pi).^(numAtr/2) ) * sqrt(det(covarianza));
        probabilidad(i) = numerador/denominador ;
    end
end

