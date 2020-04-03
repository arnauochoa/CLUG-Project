function [Result] = regression(Data, Config)
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
    
    Result = struct;

    switch Config.Regression.Method
        case 1 % MATLAB curve fitting function
            [Result] = fitting(Data, Config);
        case 2 % Gradient Descent
            [Result] = mlFitting(Data, Config);
    end
    
end