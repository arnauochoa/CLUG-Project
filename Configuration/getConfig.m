function [Config] = getConfig()
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
    Config.Data.Type                                =   2;  % 1: generated data
                                                    % 2: real data
    Config.Data.N_Vars                              =   1;  % For N = 2 --> poly22
    
    % Data options:
    % Elevation, PR error, CN0
    Config.Data.X{1}                                =   'CN0';
    Config.Data.X{2}                                =   'Elevation';
    Config.Data.Y                                   =   'PR error';
    Config.Data.Y_Upper_Threshold                   =   300;    % Threshold for PRE
    Config.Data.Y_Lower_Threshold                   =   -100;   % Threshold for PRE
    
    %% REGRESSION METHOD
    Config.Regression.Method                        =   1;  % TODO
    
    Config.Regression.Matlab_CF.Mean.Model          =   'exp1';    % poly2, exp1, poly22
    Config.Regression.Matlab_CF.Mean.StartPt        =   [0, 0];     % Only for NON-LINEAR models
    Config.Regression.Matlab_CF.Var.Model           =   'exp1';    % poly2, exp1, poly22
    Config.Regression.Matlab_CF.Var.StartPt         =   [0, 0];
    
    %% OUTPUT CONFIGURATIONS
    % CDF config
    Config.Output.Cdf.RefVarQuant                   =   .99;    % Quantile for the reference variance
    % Filtered quantile
    Config.Output.FData.XThreshold                  =   38;
    
    
    %% ERROR CONTROL
    nVarsMean   =   length(indepnames(fittype(Config.Regression.Matlab_CF.Mean.Model)));
    nVarsVar   =   length(indepnames(fittype(Config.Regression.Matlab_CF.Var.Model)));
    if Config.Data.N_Vars ~= nVarsMean || Config.Data.N_Vars ~= nVarsVar
        error('Please, choose a model with %d variables.', Config.Data.N_Vars);
    end 
end