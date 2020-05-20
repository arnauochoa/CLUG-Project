function [Theta1, Theta2, cost] = trainNN(hlSize, X, y, lambda, Config, initialParams)

    [nExamp, nFeat] = size(X);
    
    % Initialize cost function
    costFunction = @(params) nnCostFunction(params,             ...
                                            hlSize,             ...
                                            X,                  ...
                                            y,                  ...
                                            lambda,             ...
                                            Config.Regression.ML.ActivationFun);

    options = optimset('MaxIter', Config.Regression.ML.MaxIter);

    % Minimization
    fprintf('Training started\n');
    [nn_params, cost] = fmincg(costFunction, initialParams, options);
    fprintf('Training ended\n');


    % Obtain Theta1 and Theta2 back from nn_params
    Theta1 = reshape(nn_params(1:hlSize * (nFeat + 1)), ...
                     hlSize, (nFeat + 1));

    Theta2 = reshape(nn_params((1 + (hlSize * (nFeat + 1))):end), ...
                     1, (hlSize + 1));
             
end