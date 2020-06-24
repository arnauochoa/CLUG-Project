%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%     DATA ANALYSYS    %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% FOR MULTIPLE VARIABLES %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all; clc;
addpath(genpath('./'));
%% Configuration
% CHOOSE DATA FILE HERE 'Data/preparedData_thres.mat'
Config.Data.FileName                =   './Data/preparedData_MPN.mat';
Config.Data.Type    =   2; % DO NOT CHANGE
% DATA (MPN data)
[col, colnames] = col_feat();
% Feature to keep from Data.X structure
Config.Data.ColIndices  =   [   col.maxtopor,          ...     % Feature 1
                                col.maxtopol];          % Feature 2

%% PLOTS 2D

% Names of features for plots
Config.Data.X{1}            =   'MTHR';
Config.Data.X_units{1}      =   ' (m)';
Config.Data.X{2}            =   'MTHL';
Config.Data.X_units{2}      =   ' (m)';
Config.Data.Y               =   'MP error';
Config.Data.Y_units         =   ' (m)';

% READ DATA
Data        =   readData(Config);
% Join data sets
Data.X      =   [Data.X; Data.X_Val(:,1) Data.X_Val(:,2); Data.X_Test(:,1) Data.X_Test(:,2)];
Data.Y      =   [Data.Y; Data.Y_Val; Data.Y_Test];
Data        =   rmfield(Data, {'X_Val', 'Y_Val', 'X_Test', 'Y_Test'});

% IF Data.X contains Relative azimuth: Divide data into two parts: From 270
% to 90 deg, and from 90 to 270 deg
dazPart = 2; % 1 -> From 270 to 90 deg
             % 2 -> From 90 to 270 deg
% if sum(Config.Data.ColIndices == 6) > 0 && dazPart == 1
%     idx = bitor(Data.X(:,2) <= 90, Data.X(:,2) >= 270);
%     test = (Data.X(idx,2) >= 270) .* 360;
%     tmp2 = Data.X(idx,2) - test;
%     %tmpX = [Data.X(idx,1) Data.X(idx,2)];
%     tmpX = [Data.X(idx,1) tmp2];
%     
% else 
%     idx = bitand(Data.X(:,2) > 90, Data.X(:,2) < 270);
%     tmpX = [Data.X(idx,1) Data.X(idx,2)];
% 
% end

% if sum(Config.Data.ColIndices == 6) > 0 && dazPart == 1
%     idx = bitand(Data.X(:,2) >= 0, Data.X(:,2) <= 180);
%     tmpX = [Data.X(idx,1) Data.X(idx,2)];
%     tmpY = Data.Y(idx,1);
%     clearvars Data;
%     Data.X = tmpX;
%     Data.Y = tmpY;
%     
% else 
%     idx = bitand(Data.X(:,2) > 180, Data.X(:,2) < 360);
%     tmpX = [Data.X(idx,1) Data.X(idx,2)];
%     tmpY = Data.Y(idx,1);
%     clearvars Data;
%     Data.X = tmpX;
%     Data.Y = tmpY;
% end


%----------------------------- SCATTER PLOTS ----------------------------%
figure;
plot(Data.X(:,1), Data.Y, '.');
xlabel([Config.Data.X{1}, Config.Data.X_units{1}]); 
ylabel([Config.Data.Y, Config.Data.Y_units]);
xLimits = [ min( Data.X(:,1) ), max( Data.X(:,1) ) ];  %# Get the range of the x axis
xlim(xLimits);
yLimits = [ min( Data.Y ), max( Data.Y ) ];  %# Get the range of the y axis
ylim(yLimits);
title(['Distribution of the ', Config.Data.Y, ' with respect to the ', Config.Data.X{1}]);

figure;
plot(Data.X(:,2), Data.Y, '.');
xlabel([Config.Data.X{2}, Config.Data.X_units{2}]); 
ylabel([Config.Data.Y, Config.Data.Y_units]);
xLimits = [ min( Data.X(:,2) ), max( Data.X(:,2) ) ];  %# Get the range of the x axis
xlim(xLimits);
yLimits = [ min( Data.Y ), max( Data.Y ) ];  %# Get the range of the y axis
ylim(yLimits);
title(['Distribution of the ', Config.Data.Y, ' with respect to the ', Config.Data.X{2}]);

figure;
plot(Data.X(:,1), Data.X(:,2), '.');
xlabel([Config.Data.X{1}, Config.Data.X_units{1}]); 
ylabel([Config.Data.X{2}, Config.Data.X_units{2}]);
xLimits = [ min( Data.X(:,1) ), max( Data.X(:,1) ) ];  %# Get the range of the x axis
xlim(xLimits);
yLimits = [ min( Data.X(:,2) ), max( Data.X(:,2) ) ];  %# Get the range of the y axis
ylim(yLimits);
title(['Distribution of the ', Config.Data.X{2}, ' with respect to the ', Config.Data.X{1}]);

figure;
scatter3(Data.X(:,1), Data.X(:,2), Data.Y, [], Data.Y, '.');
xlabel([Config.Data.X{1}, Config.Data.X_units{1}]); 
ylabel([Config.Data.X{2}, Config.Data.X_units{2}]);
zlabel([Config.Data.Y, Config.Data.Y_units]);
u = colorbar;
colormap jet;
set(get(u,'label'),'string', [Config.Data.Y, Config.Data.Y_units]);
caxis( [ min( Data.Y(:) ), max( Data.Y(:) ) ] ); % Set the color limits for the colorbar
title(['Distribution of the ', Config.Data.Y, ' with respect to the ', Config.Data.X{1}, ' and ', Config.Data.X{2}]);

figure;
scatter(Data.X(:,1), Data.X(:,2), [], Data.Y, '.');
xlabel([Config.Data.X{1}, Config.Data.X_units{1}]); 
ylabel([Config.Data.X{2}, Config.Data.X_units{2}]);
xLimits = [ min( Data.X(:,1) ), max( Data.X(:,1) ) ];  %# Get the range of the x axis
xlim(xLimits);
yLimits = [ min( Data.X(:,2) ), max( Data.X(:,2) ) ];  %# Get the range of the y axis
ylim(yLimits);
caxis( [ min( Data.Y(:) ), max( Data.Y(:) ) ] ); % Set the color limits for the colorbar
u = colorbar;
colormap jet;
set(get(u,'label'),'string', [Config.Data.Y, Config.Data.Y_units]);
caxis( [ min( Data.Y(:) ), max( Data.Y(:) ) ] ); % Set the color limits for the colorbar
title(['Distribution of the ', Config.Data.Y, ' with respect to the ', Config.Data.X{1}, ' and ', Config.Data.X{2}]);

figure;
edgesX1i     =   min(Data.X(:,1)):1:max(Data.X(:,1));
edgesX2i     =   min(Data.X(:,2)):1:max(Data.X(:,2));
[Xi,Yi]       =   meshgrid(edgesX1i,edgesX2i);
Zi = griddata(Data.X(:,1), Data.X(:,2), Data.Y, Xi, Yi);
surf(Xi, Yi, Zi);
view(0, 90);
xlabel([Config.Data.X{1}, Config.Data.X_units{1}]); 
ylabel([Config.Data.X{2}, Config.Data.X_units{2}]);
xLimits = [ min( Data.X(:,1) ), max( Data.X(:,1) ) ];  %# Get the range of the x axis
xlim(xLimits);
yLimits = [ min( Data.X(:,2) ), max( Data.X(:,2) ) ];  %# Get the range of the y axis
ylim(yLimits);
u = colorbar;
colormap jet;
set(get(u,'label'),'string', [Config.Data.Y, Config.Data.Y_units]);
caxis( [ min( Data.Y(:) ), max( Data.Y(:) ) ] ); % Set the color limits for the colorbar
title(['Distribution of the ', Config.Data.Y, ' with respect to the ', Config.Data.X{1}, ' and ', Config.Data.X{2}]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%------------------------ DISTRIBUTION OF POINTS ------------------------%
N           =   length(Data.Y);
edgesX1     =   floor(min(Data.X(:,1))):1:ceil(max(Data.X(:,1)))+1;
edgesX2     =   floor(min(Data.X(:,2))):1:ceil(max(Data.X(:,2)));
x1Disc      =   edgesX1(discretize(Data.X(:,1), edgesX1));
x2Disc      =   edgesX2(discretize(Data.X(:,2), edgesX2));
uniqueX1    =   unique(x1Disc);
uniqueX2    =   unique(x2Disc);

[X,Y]       =   meshgrid(uniqueX1,uniqueX2);
C           =   cat(2,X',Y');
D           =   reshape(C,[],2);

numPointsX  =   nan(length(D), 1);
mpeMean  =   nan(length(D), 1);
mpeWorst  =   nan(length(D), 1);
for i = 1:length(D)
    tmp = bitand(x1Disc == D(i, 1), x2Disc == D(i, 2));
    tmpSum = sum(tmp);
    if tmpSum > 0
        numPointsX(i) = 100*tmpSum/N;
        mpeMean(i) = sum(Data.Y(tmp,1))/tmpSum;
        mpeWorst(i) = max(Data.Y(tmp,1));
    end
end

Z = griddata(D(:,1),D(:,2),numPointsX,X,Y);
C = griddata(D(:,1),D(:,2),mpeMean,X,Y);
C1 = griddata(D(:,1),D(:,2),mpeWorst,X,Y);

% 3D view - Surface plot: Distribution of points
figure;
surf(X, Y, Z);
xlabel([Config.Data.X{1}, Config.Data.X_units{1}]); 
ylabel([Config.Data.X{2}, Config.Data.X_units{2}]); 
zlabel('Number of points (%)');
u = colorbar;
colormap jet;
set(get(u,'label'),'string', 'Number of points (%)');
caxis( [ min( Z(:) ), max( Z(:) ) ] ); % Set the color limits for the colorbar
title('3D view - Distribution of points');

% 2D view - Surface plot: Distribution of points
figure;
surf(X, Y, Z);
view(0, 90);
xlabel([Config.Data.X{1}, Config.Data.X_units{1}]); 
ylabel([Config.Data.X{2}, Config.Data.X_units{2}]);
xLimits = [ min( Data.X(:,1) ), max( Data.X(:,1) ) ];  %# Get the range of the x axis
xlim(xLimits);
yLimits = [ min( Data.X(:,2) ), max( Data.X(:,2) ) ];  %# Get the range of the y axis
ylim(yLimits);
zlabel('Number of points (%)');
u = colorbar;
colormap jet;
set(get(u,'label'),'string', 'Number of points (%)');
caxis( [ min( Z(:) ), max( Z(:) ) ] ); % Set the color limits for the colorbar
title('2D view - Distribution of points');

% 3D view - Surface plot: Distribution of points with MEAN MPE
figure;
surf(X, Y, Z, C);
xlabel([Config.Data.X{1}, Config.Data.X_units{1}]); 
ylabel([Config.Data.X{2}, Config.Data.X_units{2}]); 
zlabel('Number of points (%)');
u = colorbar;
colormap jet;
set(get(u,'label'),'string', ['Mean ', Config.Data.Y, Config.Data.Y_units]);
caxis( [ min( C(:) ), max( C(:) ) ] ); % Set the color limits for the colorbar
title('3D view - Distribution of points with MEAN MPE');

% 2D view - Surface plot: Distribution of points with MEAN MPE
figure;
surf(X, Y, Z, C);
view(0, 90);
xlabel([Config.Data.X{1}, Config.Data.X_units{1}]); 
ylabel([Config.Data.X{2}, Config.Data.X_units{2}]);
xLimits = [ min( Data.X(:,1) ), max( Data.X(:,1) ) ];  %# Get the range of the x axis
xlim(xLimits);
yLimits = [ min( Data.X(:,2) ), max( Data.X(:,2) ) ];  %# Get the range of the y axis
ylim(yLimits); 
zlabel('Number of points (%)');
u = colorbar;
colormap jet;
set(get(u,'label'),'string', ['Mean ', Config.Data.Y, Config.Data.Y_units]);
caxis( [ min( C(:) ), max( C(:) ) ] ); % Set the color limits for the colorbar
title('2D view - Distribution of points with MEAN MPE');

% 3D view - Surface plot: Distribution of points with WORST MPE
figure;
surf(X, Y, Z, C1);
xlabel([Config.Data.X{1}, Config.Data.X_units{1}]); 
ylabel([Config.Data.X{2}, Config.Data.X_units{2}]); 
zlabel('Number of points (%)');
u = colorbar;
colormap jet;
set(get(u,'label'),'string', ['Worst ', Config.Data.Y, Config.Data.Y_units]);
caxis( [ min( C1(:) ), max( C1(:) ) ] ); % Set the color limits for the colorbar
title('3D view - Distribution of points with WORST MPE');

% 2D view - Surface plot: Distribution of points with WORST MPE
figure;
surf(X, Y, Z, C1);
view(0, 90);
xlabel([Config.Data.X{1}, Config.Data.X_units{1}]); 
ylabel([Config.Data.X{2}, Config.Data.X_units{2}]);
xLimits = [ min( Data.X(:,1) ), max( Data.X(:,1) ) ];  %# Get the range of the x axis
xlim(xLimits);
yLimits = [ min( Data.X(:,2) ), max( Data.X(:,2) ) ];  %# Get the range of the y axis
ylim(yLimits);
zlabel('Number of points (%)');
u = colorbar;
colormap jet;
set(get(u,'label'),'string', ['Worst ', Config.Data.Y, Config.Data.Y_units]);
caxis( [ min( C1(:) ), max( C1(:) ) ] ); % Set the color limits for the colorbar
title('2D view - Distribution of points with WORST MPE');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
contourf(X, Y, Z, 20);
xlabel(Config.Data.X{1}); ylabel(Config.Data.X{2});
u = colorbar;
colormap jet;
set(get(u,'label'),'string','Number of points (%)');
caxis( [ min( Z(:) ), max( Z(:) ) ] ); % Set the color limits for the colorbar
title('2D view (Contour) - Distribution of points');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


