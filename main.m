% ----------------------------------------------------------------------------------------
% Main script that reads data, sets parameters and computes regression
% ----------------------------------------------------------------------------------------
close all; clear; clc;
addpath(genpath('./'));

%% GETTING CONFIG
Config      =   getConfig();

%% GETTING DATA
Data        =   readData(Config);

%% REMOVE OUTLIERS
Data        =   removeOutliers(Data, Config);

%% OBTAINIG REGRESSION
Result      =   regression(Data, Config);

%% GETTING OUTPUT AND PLOTS
getOutput(Data, Config, Result);