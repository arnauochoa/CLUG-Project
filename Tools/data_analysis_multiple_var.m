%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%     DATA ANALYSYS    %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% FOR MULTIPLE VARIABLES %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all; clc;
clear all:
addpath(genpath('./'));
%% Configuration
% CHOOSE DATA FILE HERE 'Data/preparedData_thres.mat'
Config.Data.FileName                =   './Data/preparedData_MPE_41119.mat';
Config.Data.Type    =   2; % DO NOT CHANGE
% DATA (MPN data)
[col, colnames] = col_feat();
% Feature to keep from Data.X structure
Config.Data.ColIndices  =   [   col.s,          ...     % SNR
                                col.el,         ...     % Elevation
                                col.az,         ...     % Azimuth
                                col.daz,        ...     % Relative azimuth
                                col.maxtopo,    ...     % Max topo (global)
                                col.maxtopor,   ...     % Maximum topo right
                                col.maxtopol    ...     % Maximum topo left  
                                col.visibility];        % Visibility (LOS or NLOS wrt vehicle)

%% PLOTS 2D

% READ DATA
Data        =   readData(Config);

% Join data sets
Data.X = [Data.X; Data.X_Val; Data.X_Test];
Data.Y = [Data.Y; Data.Y_Val; Data.Y_Test];
Data        =   rmfield(Data, {'X_Val', 'Y_Val', 'X_Test', 'Y_Test'});

% Divide azimuth in Right and Left
if sum(Config.Data.ColIndices == 5) > 0
    idxCol = find(Config.Data.ColIndices == 5);
    idxRowR = bitand(Data.X(:,idxCol) >= 0, Data.X(:,idxCol) <= 180);
    idxRowL = bitand(Data.X(:,idxCol) > 180, Data.X(:,idxCol) <= 360);
    X_azR = Data.X(idxRowR,[1 2 3 5 6 8]); % Keeping only MTHR
    X_azL = Data.X(idxRowL,[1 2 3 5 7 8]); % Keepeing only MTHL
    y_azR = Data.Y(idxRowR,1);
    y_azL = Data.Y(idxRowL,1);
    clear idxCol idxRowR idxRowL;
end  

% Divide relative azimuth in Right and Left
if sum(Config.Data.ColIndices == 6) > 0
    idxCol = find(Config.Data.ColIndices == 6);
    idxRowR = bitand(Data.X(:,idxCol) >= 0, Data.X(:,idxCol) <= 180);
    idxRowL = bitand(Data.X(:,idxCol) > 180, Data.X(:,idxCol) <= 360);
    X_dazR = Data.X(idxRowR,[1 2 4 5 6 8]);
    X_dazL = Data.X(idxRowL,[1 2 4 5 7 8]);
    y_dazR = Data.Y(idxRowR,1);
    y_dazL = Data.Y(idxRowL,1);
    clear idxCol idxRowR idxRowL;
end  
clear Data;

% Names of features for plots
Config.Data.X{1}            =   'Elevation';
Config.Data.X_units{1}      =   ' (deg)';
Config.Data.X{2}            =   'Relative Azimuth';
Config.Data.X_units{2}      =   ' (deg)';
Config.Data.Y               =   'MP error';
Config.Data.Y_units         =   ' (m)';

% Create Data again for plots
Data.X = [X_dazR(:,2) X_dazR(:,3)];
Data.Y = y_dazR;

%%%%%%%%%%%%%%%% Only 2 FEATURES AND MPE selected %%%%%%%%%%%%%%%%%%%%%%%%%
% Join data sets
% Data.X      =   [Data.X; Data.X_Val(:,1) Data.X_Val(:,2); Data.X_Test(:,1) Data.X_Test(:,2)];
% Data.Y      =   [Data.Y; Data.Y_Val; Data.Y_Test];
% Data        =   rmfield(Data, {'X_Val', 'Y_Val', 'X_Test', 'Y_Test'});
% 
% % Names of features for plots
% Config.Data.X{1}            =   'CN0';
% Config.Data.X_units{1}      =   ' (dB-Hz)';
% Config.Data.X{2}            =   'Relative azimuth';
% Config.Data.X_units{2}      =   ' (deg)';
% Config.Data.Y               =   'MP error';
% Config.Data.Y_units         =   ' (m)';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



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
load('colormap1.mat')
load('cmap.mat')

% figure;
% plot(Data.X(:,1), Data.Y, '.');
% xlabel([Config.Data.X{1}, Config.Data.X_units{1}]); 
% ylabel([Config.Data.Y, Config.Data.Y_units]);
% xLimits = [ min( Data.X(:,1) ), max( Data.X(:,1) ) ];  %# Get the range of the x axis
% xlim(xLimits);
% yLimits = [ min( Data.Y ), max( Data.Y ) ];  %# Get the range of the y axis
% ylim(yLimits);
% title(['Distribution of the ', Config.Data.Y, ' with respect to the ', Config.Data.X{1}]);
% 
% figure;
% plot(Data.X(:,2), Data.Y, '.');
% xlabel([Config.Data.X{2}, Config.Data.X_units{2}]); 
% ylabel([Config.Data.Y, Config.Data.Y_units]);
% xLimits = [ min( Data.X(:,2) ), max( Data.X(:,2) ) ];  %# Get the range of the x axis
% xlim(xLimits);
% yLimits = [ min( Data.Y ), max( Data.Y ) ];  %# Get the range of the y axis
% ylim(yLimits);
% title(['Distribution of the ', Config.Data.Y, ' with respect to the ', Config.Data.X{2}]);
% 
% figure;
% plot(Data.X(:,1), Data.X(:,2), '.');
% xlabel([Config.Data.X{1}, Config.Data.X_units{1}]); 
% ylabel([Config.Data.X{2}, Config.Data.X_units{2}]);
% xLimits = [ min( Data.X(:,1) ), max( Data.X(:,1) ) ];  %# Get the range of the x axis
% xlim(xLimits);
% yLimits = [ min( Data.X(:,2) ), max( Data.X(:,2) ) ];  %# Get the range of the y axis
% ylim(yLimits);
% title(['Distribution of the ', Config.Data.X{2}, ' with respect to the ', Config.Data.X{1}]);
% 
% figure;
% scatter3(Data.X(:,1), Data.X(:,2), Data.Y, [], Data.Y, '.');
% xLimits = [ min( Data.X(:,1) ), max( Data.X(:,1) ) ];  %# Get the range of the x axis
% xlim(xLimits);
% yLimits = [ min( Data.X(:,2) ), max( Data.X(:,2) ) ];  %# Get the range of the y axis
% ylim(yLimits);
% xlabel([Config.Data.X{1}, Config.Data.X_units{1}]); 
% ylabel([Config.Data.X{2}, Config.Data.X_units{2}]);
% zlabel([Config.Data.Y, Config.Data.Y_units]);
% u = colorbar;
% % colormap jet;
% colormap(cmap);
% set(get(u,'label'),'string', [Config.Data.Y, Config.Data.Y_units]);
% caxis( [ min( Data.Y(:) ), max( Data.Y(:) ) ] ); % Set the color limits for the colorbar
% title(['Distribution of the ', Config.Data.Y, ' with respect to the ', Config.Data.X{1}, ' and ', Config.Data.X{2}]);
% 
% figure;
% scatter3(Data.X(:,1), Data.X(:,2), Data.Y, [], Data.Y, '.');
% view(0, 90);
% xLimits = [ min( Data.X(:,1) ), max( Data.X(:,1) ) ];  %# Get the range of the x axis
% xlim(xLimits);
% yLimits = [ min( Data.X(:,2) ), max( Data.X(:,2) ) ];  %# Get the range of the y axis
% ylim(yLimits);
% xlabel([Config.Data.X{1}, Config.Data.X_units{1}]); 
% ylabel([Config.Data.X{2}, Config.Data.X_units{2}]);
% zlabel([Config.Data.Y, Config.Data.Y_units]);
% u = colorbar;
% % colormap jet;
% colormap(cmap);
% set(get(u,'label'),'string', [Config.Data.Y, Config.Data.Y_units]);
% caxis( [ min( Data.Y(:) ), max( Data.Y(:) ) ] ); % Set the color limits for the colorbar
% title(['Distribution of the ', Config.Data.Y, ' with respect to the ', Config.Data.X{1}, ' and ', Config.Data.X{2}]);
% 
% 
% figure;
% scatter(Data.X(:,1), Data.X(:,2), [], Data.Y, '.');
% xlabel([Config.Data.X{1}, Config.Data.X_units{1}]); 
% ylabel([Config.Data.X{2}, Config.Data.X_units{2}]);
% xLimits = [ min( Data.X(:,1) ), max( Data.X(:,1) ) ];  %# Get the range of the x axis
% xlim(xLimits);
% yLimits = [ min( Data.X(:,2) ), max( Data.X(:,2) ) ];  %# Get the range of the y axis
% ylim(yLimits);
% u = colorbar;
% % colormap jet;
% colormap(cmap);
% set(get(u,'label'),'string', [Config.Data.Y, Config.Data.Y_units]);
% caxis( [ min( Data.Y(:) ), max( Data.Y(:) ) ] ); % Set the color limits for the colorbar
% title(['Distribution of the ', Config.Data.Y, ' with respect to the ', Config.Data.X{1}, ' and ', Config.Data.X{2}]);
% 
% % Visibility
% figure;
% scatter(Data.X((X_dazR(:, 6) == 1), 1), Data.X((X_dazR(:, 6) == 1), 2), [], [0 0 0.55], '.');
% hold on;
% scatter(Data.X((X_dazR(:, 6) == 0), 1), Data.X((X_dazR(:, 6) == 0), 2), [], [1 0.85 0.11], '.');
% xlabel([Config.Data.X{1}, Config.Data.X_units{1}]); 
% ylabel([Config.Data.X{2}, Config.Data.X_units{2}]);
% xLimits = [ min( Data.X(:,1) ), max( Data.X(:,1) ) ];  %# Get the range of the x axis
% xlim(xLimits);
% yLimits = [ min( Data.X(:,2) ), max( Data.X(:,2) ) ];  %# Get the range of the y axis
% ylim(yLimits);
% title(['Visibility with respect to the ', Config.Data.X{1}, ' and ', Config.Data.X{2}]);
% legend('LOS','NLOS')
% 
% figure;
% edgesX1i     =   min(Data.X(:,1)):0.5:max(Data.X(:,1));
% edgesX2i     =   min(Data.X(:,2)):0.5:max(Data.X(:,2));
% [Xi,Yi]       =   meshgrid(edgesX1i,edgesX2i);
% Zi = griddata(Data.X(:,1), Data.X(:,2), Data.Y, Xi, Yi);
% surf(Xi, Yi, Zi);
% view(0, 90);
% xlabel([Config.Data.X{1}, Config.Data.X_units{1}]); 
% ylabel([Config.Data.X{2}, Config.Data.X_units{2}]);
% xLimits = [ min( Data.X(:,1) ), max( Data.X(:,1) ) ];  %# Get the range of the x axis
% xlim(xLimits);
% yLimits = [ min( Data.X(:,2) ), max( Data.X(:,2) ) ];  %# Get the range of the y axis
% ylim(yLimits);
% u = colorbar;
% % colormap jet;
% colormap(cmap);
% set(get(u,'label'),'string', [Config.Data.Y, Config.Data.Y_units]);
% caxis( [ min( Data.Y(:) ), max( Data.Y(:) ) ] ); % Set the color limits for the colorbar
% title(['Distribution of the ', Config.Data.Y, ' with respect to the ', Config.Data.X{1}, ' and ', Config.Data.X{2}]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%------------------------ DISTRIBUTION OF POINTS ------------------------%
N           =   length(Data.Y);
edgesX1     =   floor(min(Data.X(:,1))):0.5:ceil(max(Data.X(:,1)))+1;
edgesX2     =   floor(min(Data.X(:,2))):0.5:ceil(max(Data.X(:,2)));
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
        mpePointsX = Data.Y(tmp,1);
        mpeMean(i) = sum(mpePointsX)/tmpSum;
        m = max(abs(Data.Y(tmp,1)));
        mpeWorst(i) = mpePointsX(abs(Data.Y(tmp,1)) == m,1);
        clear mpePointsX m;
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
% colormap jet;
colormap(colormap1);
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
% colormap jet;
colormap(colormap1);
set(get(u,'label'),'string', 'Number of points (%)');
caxis( [ min( Z(:) ), max( Z(:) ) ] ); % Set the color limits for the colorbar
title('2D view - Distribution of points');

% 3D view - Surface plot: Distribution of points with MEAN MPE
% figure;
% surf(X, Y, Z, C);
% xlabel([Config.Data.X{1}, Config.Data.X_units{1}]); 
% ylabel([Config.Data.X{2}, Config.Data.X_units{2}]); 
% zlabel('Number of points (%)');
% u = colorbar;
% % colormap jet;
% colormap(colormap2);
% set(get(u,'label'),'string', ['Mean ', Config.Data.Y, Config.Data.Y_units]);
% caxis( [ min( C(:) ), max( C(:) ) ] ); % Set the color limits for the colorbar
% title('3D view - Distribution of points with MEAN MPE');

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
% colormap jet;
colormap(cmap);
set(get(u,'label'),'string', ['Mean ', Config.Data.Y, Config.Data.Y_units]);
caxis( [ min( C(:) ), max( C(:) ) ] ); % Set the color limits for the colorbar
title('2D view - Distribution of points with MEAN MPE');

% 3D view - Surface plot: Distribution of points with WORST MPE
% figure;
% surf(X, Y, Z, C1);
% xlabel([Config.Data.X{1}, Config.Data.X_units{1}]); 
% ylabel([Config.Data.X{2}, Config.Data.X_units{2}]); 
% zlabel('Number of points (%)');
% u = colorbar;
% % colormap jet;
% colormap(colormap2);
% set(get(u,'label'),'string', ['Worst ', Config.Data.Y, Config.Data.Y_units]);
% caxis( [ min( C1(:) ), max( C1(:) ) ] ); % Set the color limits for the colorbar
% title('3D view - Distribution of points with WORST MPE');

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
% colormap jet;
colormap(cmap);
set(get(u,'label'),'string', ['Worst ', Config.Data.Y, Config.Data.Y_units]);
caxis( [ min( C1(:) ), max( C1(:) ) ] ); % Set the color limits for the colorbar
title('2D view - Distribution of points with WORST MPE');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% figure;
% contourf(X, Y, Z, 20);
% xlabel([Config.Data.X{1}, Config.Data.X_units{1}]); 
% ylabel([Config.Data.X{2}, Config.Data.X_units{2}]);
% u = colorbar;
% % colormap jet;
% colormap(colormap2);
% set(get(u,'label'),'string','Number of points (%)');
% caxis( [ min( Z(:) ), max( Z(:) ) ] ); % Set the color limits for the colorbar
% title('2D view (Contour) - Distribution of points');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


