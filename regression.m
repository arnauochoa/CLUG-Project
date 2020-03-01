function [result, coeffMean, coeffVar, sqrdErr, coeffMean2, coeffVar2] = regression(DATA, CONFIG)
% ----------------------------------------------------------------------------------------
% This function applies the regression technique selected in configuration
%
% INPUT
%           DATA:       Struct. Input data
%           CONFIG:     Struct. Configuration parameters
%
% OUTPUT
%           result:     ....    
%
% ----------------------------------------------------------------------------------------
    
    result = 0;

    switch CONFIG.REGRESSION_METHOD
        case 1 % MATLAB curve fitting function
            % Curve fitting for the mean of the random noise
%             coeffMean   =   polyfit(DATA.X, DATA.Y, 2);
            coeffMean    =   fit(DATA.X', DATA.Y','exp1');
            
            % Curve fitting for the variance of the random noise
%             meanReg     =   polyval(coeffMean, DATA.X);
            meanReg     =   coeffMean(DATA.X)';
            sqrdErr     =   (DATA.Y - meanReg).^2;
            coeffVar    =   fit(DATA.X', sqrdErr','exp1');  % 	Y = a*exp(b*x)
            
            % Obtain weights
            weigths     =   1./sqrt(coeffVar(DATA.X));
            
            % Recompute regression for mean and variance
            coeffMean2  =   fit(DATA.X', DATA.Y', 'exp1', 'Weights', weigths);
            coeffVar2   =   fit(DATA.X', sqrdErr', 'exp1', 'Weights', weigths);
            
        case 2 % Custom classical regression model
            % TODO
            
        case 3 % Machine learning
            % TODO
            
    end
    
end