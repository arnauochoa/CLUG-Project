% ----------------------------------------------------------------------------------------
% Main script that reads data, sets parameters and computes regression
% ----------------------------------------------------------------------------------------
close all; clear; clc;

%% GETTING CONFIG
CONFIG      =   getConfig();

%% GETTING DATA
DATA        =   readData(CONFIG);

%% OBTAINIG REGRESSION
[result, coeffMean, coeffVar, sqrdErr, coeffMean2, coeffVar2]     =   regression(DATA, CONFIG);

%% GETTING OUTPUT AND PLOTS
getOutput(DATA, CONFIG, result, coeffMean, coeffVar, sqrdErr, coeffMean2, coeffVar2);