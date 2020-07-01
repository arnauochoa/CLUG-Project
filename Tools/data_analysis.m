%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%   DATA ANALYSYS   %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% close all; clc;
clearvars -except Data;
addpath(genpath('./'));
%% Configuration
% CHOOSE DATA FILE HERE 'Data/preparedData_thres.mat'
Config.Data.FileName                =   './Data/preparedData_MPN.mat';
Config.Data.Type    =   2; % DO NOT CHANGE
% DATA (MPN data)
[col, colnames] = col_feat();
% Feature to keep from Data.X structure
Config.Data.ColIndices  =   col.maxtopor; % For PRE data: 1: CN0, 2: Elevation
                               % For MPN data: col.s, col.el, col.az, ...

FigName   = 'mpn_maxtopor';
% Names of features for plots
Config.Data.X           =   'CN0';
Config.Data.X_units     =   ' (m)';
Config.Data.Y           =   'MP error';
Config.Data.Y_units     =   ' (m)';

%% READ DATA
Data        =   readData(Config);
% Join data sets
Data.X      =   [Data.X; Data.X_Val; Data.X_Test];
Data.Y      =   [Data.Y; Data.Y_Val; Data.Y_Test];
Data        =   rmfield(Data, {'X_Val', 'Y_Val', 'X_Test', 'Y_Test'});

% nData   = 1e5;          
% Data.X  = Data.X(1:nData, :);
% Data.Y  = Data.Y(1:nData);

%% Plots
edges       =   floor(min(Data.X)):1:ceil(max(Data.X))+1;
xDisc       =   edges(discretize(Data.X, edges));
uniqueX     =   unique(xDisc);
numPointsX  =   nan(length(uniqueX), 1);
deviationY  =   nan(length(Data.Y), 1);
for i = 1:length(uniqueX)
    indices = xDisc == uniqueX(i);
    numPointsX(i) = sum(indices);
    deviationY(indices) = abs(Data.Y(indices) - mean(Data.Y(indices)));
end
normNumPointsX = numPointsX./length(Data.X);
quantile95  =   nan(length(uniqueX), 1);
quantile05  =   nan(length(uniqueX), 1);
for i = 1:length(uniqueX)
    quantile95(i) = quantile(Data.Y(xDisc == uniqueX(i)),0.95);
    quantile05(i) = quantile(Data.Y(xDisc == uniqueX(i)),0.05);
end

figure('Renderer', 'painters', 'Position', [300 150 700 500]);
subplot(2,1,1)
plot(Data.X, Data.Y, '.');                       hold on;
xLimits = get(gca,'XLim');  %# Get the range of the x axis
plot(uniqueX,quantile95,'k-','Marker','.','MarkerSize',16);
plot(uniqueX,quantile05,'r-','Marker','.','MarkerSize',16);
ylabel([Config.Data.Y, Config.Data.Y_units]);
xlabel([Config.Data.X, Config.Data.X_units]);
legend({Config.Data.Y,'Quantile 0.95', 'Quantile 0.05'}, 'Location', 'best');
title(['Distribution of the ', Config.Data.Y, ' with respect to the ', Config.Data.X]);
subplot(2,1,2)
plot(uniqueX,normNumPointsX*100, 'k-');
xlim(xLimits);
ylim([0 ceil(max(normNumPointsX*100))]);
% ylim([0 10]);
xlabel([Config.Data.X, Config.Data.X_units]);
ylabel('Number of points (%)');

%% SAVE PLOT
FolderName = '../Figures_auto/';   % Your destination folder
FigList = findobj(allchild(0), 'flat', 'Type', 'figure');
for iFig = 1:length(FigList)
  FigHandle = FigList(iFig);
  saveas(FigHandle, fullfile(FolderName, [FigName, '.png']));
  saveas(FigHandle, fullfile(FolderName, [FigName, '.fig']));
end

%% CDF PLOTS
% mu      =   mean(Data.Y); 
% sigma   =   std(Data.Y);
% pd      =   makedist('Normal', 'mu', mu, 'sigma', sigma);
% 
% figure;
% probplot(Data.Y, 'noref');
% probplot(gca, pd);
% grid on;
% xlabel(Config.Data.Y ); ylabel('Probability');
% title(sprintf('Normal Probability Plot. \\mu = %0.2f, \\sigma = %0.2f', mu, sigma));
