%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%  NEURAL NETWORK MATLAB TOOLBOX  %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all; clc;
clearvars -except Data;
addpath(genpath('./'));

set(0, 'DefaultLineLineWidth', 2);

%% Getting config
Config      =   getConfig();

%% Getting data
Data        =   readData(Config);

%% Prepare data
% Normalize features
[X_train_norm, muTrain, sigmaTrain] = featureNormalize(Data.X);
X_val_norm      =   (Data.X_Val - muTrain) ./ sigmaTrain;
X_test_norm     =   (Data.X_Test - muTrain) ./ sigmaTrain;

% Add polynomial terms
X_train_norm    =   mapFeatures(X_train_norm, Config.Regression.ML.Deg);
X_val_norm      =   mapFeatures(X_val_norm, Config.Regression.ML.Deg);
X_test_norm     =   mapFeatures(X_test_norm, Config.Regression.ML.Deg);

% X = [X_train_norm; X_val_norm; X_test_norm]'; % Input data to the nn
% y = [Data.Y; Data.Y_Val; Data.Y_Test]'; % Target data

[nFeat, nExamp]  = size(X_train_norm);

% Set size of hidden layer depending on configuration
if Config.Regression.ML.HiddenLayerSize == 0
    hlSize = nFeat; 
else
    hlSize = Config.Regression.ML.HiddenLayerSize;
end 

% Construct a function fitting neural network with one hidden layer 
net = fitnet(hlSize,'trainscg');

% Train neural network
%net.trainFcn = 'trainscg';
holdout = 0.05;
c = cvpartition(m,'HoldOut',holdout); % Choose 5% of training examples
tinds = training(c); % Selects random Training indices


[net,tr] = train(net,X,y);
