clear; close all; clc;
%% RANDOM DATA GENERATOR

x           =   0:0.1:60;       % X Axis
nSamples    =   round(0.9*length(x));
xSamples    =   datasample(x, nSamples, 'Replace', true);

% Upper limit
uk          =   0.08;
ub          =   0.8;
uLimit      =   ub*exp(-uk*x);  % 2-sigma

% Lower limit
lk          =   0.08;
lb          =   -0.6;
lLimit      =   lb*exp(-lk*x);  % 2-sigma

limMean     =   (uLimit+lLimit)/2;

sigma       =   (uLimit-limMean)./2;
y           =   normrnd(limMean, sigma);

figure;
plot(x, uLimit); hold on;
plot(x, lLimit); hold on;
plot(x, limMean); hold on;
plot(x, y, '.');

