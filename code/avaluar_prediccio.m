function [ conf,order ] = avaluar_prediccio(pred, truth)
%Calcula las métricas sobre la precisión de la predicción por el nombre la
%variable que se quiere predecir.
%Parametre pred: Predicció
%Parametre truth: Clase coneguda

    [conf,order] = confusionmat(pred,truth); %en valors reals
    %conf
    %order
    conf = conf/length(pred); %en tant per 1
    %conf
end

