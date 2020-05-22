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

% TODO: remove this, reduced data for test purposes >>>>>>>
nData   = 1e4;          % Current max: 47317
Data.X  = Data.X(1:nData, :);
Data.Y  = Data.Y(1:nData);
% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

%% OBTAINIG REGRESSION
Result      =   regression(Data, Config);

%% GETTING OUTPUT AND PLOTS
getOutput(Data, Config, Result);