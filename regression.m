function [result, coeff] = regression(DATA, CONFIG)
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
            coeff = polyfit(DATA.X, DATA.Y, 2);
        case 2 % Custom classical regression model
            % TODO
            
        case 3 % Machine learning
            % TODO
            
    end
    
end