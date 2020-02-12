function [CONFIG] = getConfig()
% ----------------------------------------------------------------------------------------
% This function reads the configuration file and generates a configuration
% structure.
%
% OUTPUT
%           CONFIG:     Configuration structure
%
% ----------------------------------------------------------------------------------------

    % Read config file
    
    % Regression method:
    %   1: MATLAB curve fitting function
    %   2: Custom classical regression model
    %   3: Machine learning
    
    CONFIG.REGRESSION_METHOD                =   1;  % TODO
    CONFIG.METHOD_PARAMS.MATLAB_CF.DEGREE   =   2;  % TODO
    
    CONFIG.METHOD_PARAMS.CLASSIC_REG.DEGREE =   2;  % TODO

    CONFIG.METHOD_PARAMS.ML.STEP            =   2;  % TODO
    
    CONFIG.FEATURES                         =   []; % TODO
    
end