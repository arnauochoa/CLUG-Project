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
    Config.Data.N_Vars                              =   2;  % For N = 2 --> poly22
    Config.Data.FileName                            =   'Data/preparedData_thres.mat';

    % Data options:
    % Elevation, PR error, CN0
    % IMPORTANT: make coincide with config in 'prepareData.m'
    Config.Data.X{1}                                =   'CN0';
    Config.Data.X{2}                                =   'Elevation';
    Config.Data.Y                                   =   'PR error';
    
    %% REGRESSION METHOD
    Config.Regression.Method                        =   3;  % TODO
    
    %% MATLAB FITTING
    Config.Regression.Matlab_CF.Mean.Model          =   'poly22';    % poly2, exp1, poly22
    Config.Regression.Matlab_CF.Mean.StartPt        =   [0, 0];     % Only for NON-LINEAR models
    Config.Regression.Matlab_CF.Var.Model           =   'poly22';    % poly2, exp1, poly22
    Config.Regression.Matlab_CF.Var.StartPt         =   [0, 0];
    
    %% GRADIENT DESCENT METHOD
    Config.Regression.GradDes.Deg           =   2;          % Degree of the hypothesis equation
    Config.Regression.GradDes.MaxIter       =   100;
    Config.Regression.GradDes.Alpha         =   0.1;
    
    %% NEURAL NETWORK METHOD
    Config.Regression.ML.HiddenLayerSize    =   0;          % Number of neurons in the hidden layer
                                                            % If 0 --> same size as input layer
    Config.Regression.ML.Deg                =   2;          % Degree of the hypothesis equation
    Config.Regression.ML.ActivationFun      =   'ReLU';     % Activation function for the neurons in the
                                                            % hidden layer (for output layer it is linear)
                                                            % Possible options:
                                                            % - 'ReLU'
                                                            % - 'Sigmoid'
    
    %% OUTPUT CONFIGURATIONS
    % CDF config
    Config.Output.Cdf.RefVarQuant                   =   .99;    % Quantile for the reference variance
    % Filtered quantile
    Config.Output.FData.XThreshold                  =   38;
    
    
    %% ERROR CONTROL
%     if Config.Regression.Method == 1
%         nVarsMean   =   length(indepnames(fittype(Config.Regression.Matlab_CF.Mean.Model)));
%         nVarsVar   =   length(indepnames(fittype(Config.Regression.Matlab_CF.Var.Model)));
%         if Config.Data.N_Vars ~= nVarsMean || Config.Data.N_Vars ~= nVarsVar
%             error('Please, choose a model with %d variables.', Config.Data.N_Vars);
%         end 
%     end
end