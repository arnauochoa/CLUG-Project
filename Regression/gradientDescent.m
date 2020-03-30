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
    % Constants
    alpha       =   Config.Regression.GradDes.Alpha;
    [m, n]      =   size(X);
    comb        =   combinator(n, Config.Regression.GradDes.Deg, 'c', 'r');
    nComb       =   size(comb, 1);
    nTheta      =   1 + n + nComb;
    theta       =   zeros(nTheta, 1);

    [X_norm, mu, sigma] = featureNormalize(X);
    
    % Add intercept term to X
    for iComb = 1:nComb
        ind     =   comb(iComb, :);
        X_norm  =   [X_norm, X_norm(:, ind(1)) .* X_norm(:, ind(2))];
    end
    X_norm  =   [ones(m, 1) X_norm];
    
    iter = 1;
    while iter < Config.Regression.GradDes.MaxIter
        J_history(iter) = 1/(2*m) * (X_norm * theta - y)' * (X_norm*theta - y);
        grad    =   1/m * X_norm' * (X_norm * theta - y);
        theta   =   theta - alpha * grad;
        iter    =   iter+1;
    end
    
    error = (X_norm * theta - y);
    data_norm = [X_norm(:, 2) X_norm(:, 3)];
end