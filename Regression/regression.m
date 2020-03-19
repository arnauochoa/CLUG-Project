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
        case 2 % Custom classical regression model
            % TODO
            
        case 3 % Machine learning
            % TODO
            
    end
    
end