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
    CONFIG.DATA.TYPE                                =   2;  % 1: generated data
                                                    % 2: real data
    % Data options:
    % Elevation, PR error, CN0
    CONFIG.DATA.X                                   =   'CN0';
    CONFIG.DATA.Y                                   =   'PR error';
    CONFIG.DATA.Y_UPPER_THRESHOLD                   =   300;
    CONFIG.DATA.Y_LOWER_THRESHOLD                   =   -100;
    
    %% REGRESSION METHOD
    CONFIG.REGRESSION.METHOD                        =   1;  % TODO
    
    CONFIG.REGRESSION.MATLAB_CF.MEAN.MODEL          =   'poly2';  % poly2, exp1
    CONFIG.REGRESSION.MATLAB_CF.MEAN.START_PT       =   [0, 0];  % Only for NON-LINEAR models
    CONFIG.REGRESSION.MATLAB_CF.VAR.MODEL           =   'poly2';   % poly2, exp1
    CONFIG.REGRESSION.MATLAB_CF.VAR.START_PT        =   [0, 0];
    
end