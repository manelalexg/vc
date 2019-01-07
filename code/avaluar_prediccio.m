function [ conf,order ] = avaluar_prediccio(pred, truth)
% EVAL_PREDICTION compute evaluating metrics about the prediction
    % precision by class name

    [conf,order] = confusionmat(pred,truth); %en valors reals
    %conf
    %order
    conf = conf/length(pred); %en tant per 1
    %conf
end

