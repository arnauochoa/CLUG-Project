% ----------------------------------------------------------------------------------------
% Main script that reads data, sets parameters and computes regression
% ----------------------------------------------------------------------------------------
% close all;

%% GETTING DATA
filename    =   'data.mat';
DATA        =   readData(filename);

%% GETTING CONFIG
CONFIG      =   getConfig();

%% OBTAINIG REGRESSION
[result, coeffMean, coeffVar, sqrdErr, coeffMean2, coeffVar2]     =   regression(DATA, CONFIG);

%% GETTING OUTPUT AND PLOTS
getOutput(DATA, CONFIG, result, coeffMean, coeffVar, sqrdErr, coeffMean2, coeffVar2);