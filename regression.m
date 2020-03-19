function [RESULT] = regression(DATA, CONFIG)
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
    
    RESULT = struct;

    switch CONFIG.REGRESSION.METHOD
        case 1 % MATLAB curve fitting function
            [RESULT] = fitting(DATA, CONFIG);
        case 2 % Custom classical regression model
            % TODO
            
        case 3 % Machine learning
            % TODO
            
    end
    
end