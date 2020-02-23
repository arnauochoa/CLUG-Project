clear; close all; clc;
%% RANDOM DATA GENERATOR
step        =   0.1;
x           =   0:step:60;       % X Axis
incThres    =   52;
nSamples    =   round(0.9*length(x));
xSamples    =   datasample(x, nSamples, 'Replace', true);
indInc      =   find(x==incThres);
xInc        =   0:step:x(end)-incThres;

% Upper limit
uk          =   0.07;
ub          =   1;
uLimit      =   ub*exp(-uk*x)+0.08;  % 2-sigma
ruLimit     =   exp(1*(xInc+x(indInc)-60));   % Increase at end
ruLimit     =   ruLimit - ruLimit(1) + uLimit(indInc);
uLimit(indInc:end)      =   ruLimit;

% Lower limit
lk          =   0.07;
lb          =   -0.8;
lLimit      =   lb*exp(-lk*x)-0.08;  % 2-sigma
rlLimit     =   -exp(1*(xInc+x(indInc)-60)); % Increase at end
rlLimit     =   rlLimit - rlLimit(1) + lLimit(indInc);
lLimit(indInc:end)      =   rlLimit;

trueMean     =   (uLimit+lLimit)/2;

sigma       =   (uLimit-trueMean)./2;
trueVar     =   sigma.^2;
y           =   normrnd(trueMean, sigma);
y2          =   (y - trueMean).^2;

figure;
plot(x, uLimit); hold on;
plot(x, lLimit); hold on;
plot(x, trueMean); hold on;
plot(x, y, 'k.','MarkerSize',7);
%plot(x, y2, 'r*','MarkerSize',3);
% plot(x, y2, 'r-');
plot(x, trueVar, 'r-');
legend('\mu + 2\sigma', '\mu - 2\sigma', '\mu', 'Random noise', '\sigma^2'); 

save('data', 'x', 'y', 'y2', 'trueMean', 'trueVar');

