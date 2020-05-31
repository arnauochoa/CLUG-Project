function [Theta1, Theta2, cost] = trainNN(hlSize, X, y, lambda, Config, initialParams)
% ----------------------------------------------------------------------------------------
% This function computes cost function and minimizes it to find the values
% of the coefficient model (theta parameters). 
%
% INPUT
%                hlSize:      Scalar [1x1]. Hidden layer size
%                     X:      Matrix [nExamp x nFeat]. Training dataset of features
%                     y:      Vector [nExamp x 1]. Training dataset of MP error
%                lambda:      Scalar [1x1]. Regularization paramete
%            actFunType:      String. Type of activation function to be applied
%                Config:      Struct. Configuration parameters
%         initialParams:      Matrix [outSizex(inSize+1)]. Weights assigned to input values.
% OUTPUT
%                Theta1:      Vector [nFeat x 1]. Theta parameters for computation of first activation
%                             function
%                Theta2:      Vector [nFeat x 1]. Theta parameters for computation of second activation
%                             function
%                  cost:      Scalar [1x1]. Computed cost function as a
%                             function of theta

% ---------------------------------------------------------------------------------------
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