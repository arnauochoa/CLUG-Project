function [Result] = regression(Data, Config)
% ----------------------------------------------------------------------------------------
% This function applies the regression technique selected in configuration
%
% INPUT
%           DATA:       Struct. Input data
%           CONFIG:     Struct. Configuration parameters
%
% OUTPUT
%           Result:     ....    
%
% ----------------------------------------------------------------------------------------
    
    Result = struct;

    switch Config.Regression.Method
        case 1 % MATLAB curve fitting function
            [Result] = fitting(Data, Config);
        case 2 % Gradient Descent
            [Result] = gdFitting(Data, Config);
        case 3 % Machine Learning (Neural Network)
            [Result] = mlFitting(Data, Config);
    end
    
end