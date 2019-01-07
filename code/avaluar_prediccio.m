function [ conf,order ] = avaluar_prediccio(pred, truth)
%Calcula las m�tricas sobre la precisi�n de la predicci�n por el nombre la
%variable que se quiere predecir.
%Parametre pred: Predicci�
%Parametre truth: Clase coneguda

    [conf,order] = confusionmat(pred,truth); %en valors reals
    %conf
    %order
    conf = conf/length(pred); %en tant per 1
    %conf
end

