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
    CONFIG.DATA.N_VARS                              =   2;  % For N = 2 --> poly22
    
    % Data options:
    % Elevation, PR error, CN0
    CONFIG.DATA.X{1}                                =   'CN0';
    CONFIG.DATA.X{2}                                =   'Elevation';
    CONFIG.DATA.Y                                   =   'PR error';
    CONFIG.DATA.Y_UPPER_THRESHOLD                   =   300;    % Threshold for PRE
    CONFIG.DATA.Y_LOWER_THRESHOLD                   =   -100;   % Threshold for PRE
    
    %% REGRESSION METHOD
    CONFIG.REGRESSION.METHOD                        =   1;  % TODO
    
    CONFIG.REGRESSION.MATLAB_CF.MEAN.MODEL          =   'poly22';    % poly2, exp1, poly22
    CONFIG.REGRESSION.MATLAB_CF.MEAN.START_PT       =   [0, 0];     % Only for NON-LINEAR models
    CONFIG.REGRESSION.MATLAB_CF.VAR.MODEL           =   'poly22';    % poly2, exp1, poly22
    CONFIG.REGRESSION.MATLAB_CF.VAR.START_PT        =   [0, 0];
    
    
    %% ERROR CONTROL
    nVarsMean   =   length(indepnames(fittype(CONFIG.REGRESSION.MATLAB_CF.MEAN.MODEL)));
    nVarsVar   =   length(indepnames(fittype(CONFIG.REGRESSION.MATLAB_CF.VAR.MODEL)));
    if CONFIG.DATA.N_VARS ~= nVarsMean || CONFIG.DATA.N_VARS ~= nVarsVar
        fprintd('Please, choose a model with %d variables.', CONFIG.DATA.N_VARS);
    end 
end