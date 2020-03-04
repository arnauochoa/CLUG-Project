% ----------------------------------------------------------------------------------------
% Main script that reads data, sets parameters and computes regression
% ----------------------------------------------------------------------------------------
close all; clear; clc;

%% GETTING CONFIG
CONFIG      =   getConfig();

%% GETTING DATA
DATA        =   readData(CONFIG);

%% OBTAINIG REGRESSION
RESULT     =   regression(DATA, CONFIG);

%% GETTING OUTPUT AND PLOTS
getOutput(DATA, CONFIG, RESULT);