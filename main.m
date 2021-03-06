% ----------------------------------------------------------------------------------------
% Main script that reads data, sets parameters and computes regression.
% ----------------------------------------------------------------------------------------
close all; clc;
clearvars -except Data;
addpath(genpath('./'));

set(0, 'DefaultLineLineWidth', 2);

%% GETTING CONFIG
Config      =   getConfig();

%% GETTING DATA
Data        =   readData(Config);

% Reduce data for test purposes >>>>>>>>>>>>>>>>>>>
% nData   = 100;
% Data.X  = Data.X(1:nData, :);
% Data.Y  = Data.Y(1:nData);
% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

%% OBTAINIG REGRESSION
Result      =   regression(Data, Config);

%% GETTING OUTPUT AND PLOTS
getOutput(Data, Config, Result);
save(Config.Data.SaveFile, 'Config', 'Data', 'Result')
