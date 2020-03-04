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
    
    %% DATA
    CONFIG.DATA.TYPE                        =   2;  % 1: generated data
                                                    % 2: real data
    % Data options:
    % Elevation, PR error, CN0
    CONFIG.DATA.X                           =   'Elevation';
    CONFIG.DATA.Y                           =   'PR error';
    
    %% REGRESSION METHOD
    CONFIG.REGRESSION.METHOD                =   1;  % TODO
    
    CONFIG.REGRESSION.MATLAB_CF.MEAN_MODEL   =   'poly2';  % poly2, exp1
    CONFIG.REGRESSION.MATLAB_CF.VAR_MODEL    =   'exp1';   % poly2, exp1
    
    
end