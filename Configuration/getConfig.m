function [Config] = getConfig()
% ----------------------------------------------------------------------------------------
% This function reads the configuration file and generates a configuration
% structure.
%
% OUTPUT
%           CONFIG:     Struct. Configuration parameters
%
% ----------------------------------------------------------------------------------------
    
    %% FILE DIRECTORIES
    % Input file
    Config.Data.FileName        =   'Data/preparedData_MPE_41119.mat';
    % Output file
    Config.Data.SaveFile        =   'test.mat';
    
    %% DATA
    % Columns specifications (only for MPE data)
    [col, colnames] = col_feat();
    
    % Features to keep from Data.X structure
%     Config.Data.ColIndices      =   [1, 2]; % For PRE data
    Config.Data.ColIndices  =   [   col.s,          ...     % SNR
                                    col.el,         ...     % Elevation
                                    col.az,         ...     % Azimuth
                                    col.daz,        ...     % Relative azimuth
                                    col.maxtopo,    ...     % Max topo (global)
                                    col.maxtopor,   ...     % Maximum topo right
                                    col.maxtopol    ...     % Maximum topo left  
                                    col.visibility];        % Visibility (LOS or NLOS wrt vehicle)
    % Names of features for plots
    Config.Data.X           =   colnames(Config.Data.ColIndices);
    Config.Data.Y           =   'MP Error';
    % For PRE data. IMPORTANT: make coincide with config in 'prepareData.m'
%     Config.Data.X           =   {'CN0', 'Elevation'};
%     Config.Data.Y           =   'PR error';
    
    Config.Data.Type        =   2;  % 1: generated data 2: real data
    Config.Data.N_Feat      =   length(Config.Data.ColIndices); 

    
    %% REGRESSION METHOD
    % 1 - MATLAB fitting (only 2 features)
    % 2 - Gradient descent
    % 3 - Neural Network
    Config.Regression.Method                        =   2;
    
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
                                                            
    Config.Regression.ML.MaxIter            =   200;        % Number of iterations for the minimization 
    
    
    %% ERROR CONTROL
    if Config.Regression.Method == 1
        nVarsMean   =   length(indepnames(fittype(Config.Regression.Matlab_CF.Mean.Model)));
        nVarsVar   =   length(indepnames(fittype(Config.Regression.Matlab_CF.Var.Model)));
        if Config.Data.N_Feat ~= nVarsMean || Config.Data.N_Feat ~= nVarsVar
            error('Please, choose a model with %d variables.', Config.Data.N_Feat);
        end 
    end
end