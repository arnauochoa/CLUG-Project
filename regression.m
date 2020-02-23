function [result, coeff, coeffVar, coeffVar2, sqrtErr, coeffVar3] = regression(DATA, CONFIG)
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
            coeff       = polyfit(DATA.X, DATA.Y, 2);
            % Curve fitting for the variance of the random noise
            coeffVar    = polyfit(DATA.X, DATA.Y2, 2);
            coeffVar2   = fit(DATA.X', DATA.Y2','exp1');
            
            meanReg     =   polyval(coeff, DATA.X);
            sqrtErr     =   (DATA.Y - meanReg).^2;
            coeffVar3   =   polyfit(DATA.X, sqrtErr, 2);
        case 2 % Custom classical regression model
            % TODO
            
        case 3 % Machine learning
            % TODO
            
    end
    
end