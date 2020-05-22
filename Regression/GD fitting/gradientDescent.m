function [theta, mu, sigma, J_history, error, data_norm] = gradientDescent(X, y, Config)
% ----------------------------------------------------------------------------------------
% This function applies the gradient descent
%
% INPUT
%           DATA:       Struct. Input data
%           CONFIG:     Struct. Configuration parameters
%
% OUTPUT
%           result:     ....    
%
% ----------------------------------------------------------------------------------------
    % Initializations
    alpha       =   Config.Regression.GradDes.Alpha;
    m           =   size(X, 1); % num examples

    [X_norm, mu, sigma] = featureNormalize(X);
    X_norm = mapFeatures(X_norm, Config.Regression.GradDes.Deg);
    X_norm = [ones(m, 1) X_norm];
    
    nTheta      =   size(X_norm, 2);
    
    theta       =   zeros(nTheta, 1);
    
    iter = 1;
    while iter < Config.Regression.GradDes.MaxIter
        J_history(iter) = 1/(2*m) * (X_norm * theta - y)' * (X_norm*theta - y);
        grad    =   1/m * X_norm' * (X_norm * theta - y);
        theta   =   theta - alpha * grad;
        iter    =   iter+1;
    end
    
    error = (X_norm * theta - y);
    data_norm = X_norm(:, 2:Config.Data.N_Feat+1);
end