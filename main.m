% ----------------------------------------------------------------------------------------
% Main script that reads data, sets parameters and computes regression
% ----------------------------------------------------------------------------------------
close all; clc;
clearvars -except Data;
addpath(genpath('./'));

%% GETTING CONFIG
Config      =   getConfig();

%% GETTING DATA
Data        =   readData(Config);

%% OBTAINIG REGRESSION
Result      =   regression(Data, Config);

%% GETTING OUTPUT AND PLOTS
getOutput(Data, Config, Result);