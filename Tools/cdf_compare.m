%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%   COMPARING CDF   %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all; clc;
clearvars -except Data;
addpath(genpath('./'));

% load('Results/res_fit_pre');
% errLS   =   Result.PredError;
% errWLS  =   Result.PredErrorW;
% clear Config Data Result
% 
% load('Results/res_gd_pre');
% errGD   =   Result.GD_Fit.PredError;
% clear Config Data Result
% 
% load('Results/res_ml_pre');
% errNN   =   Result.MLFit.PredError;
% clear Config Data Result
% 
% mu      =   mean([mean(errLS), mean(errWLS), mean(errGD), mean(errNN)]); 
% sigma   =   mean([std(errLS), std(errWLS), std(errGD), std(errNN)]);
% pd      =   makedist('Normal', 'mu', mu, 'sigma', sigma);
% figure;
% h1 = probplot(errLS, 'noref');        hold on;
% h2 = probplot(errWLS, 'noref');
% h3 = probplot(errGD, 'noref');
% h4 = probplot(errNN, 'noref');
% h2.Color = 'r';
% h3.Color = 'g';
% h4.Color = 'c';
% probplot(gca, pd);
% grid on;
% xlabel('Test prediction error'); ylabel('Probability');
% legend({'LS', 'WLS', 'GD', 'NN','Normal'}, 'Location', 'best');
% title('');
% 
% load('Results/res_gd_mpe');
% errGD   =   Result.GD_Fit.PredError;
% clear Config Data Result
% 
% load('Results/res_ml_mpe');
% errNN   =   Result.MLFit.PredError;
% clear Config Data Result
% 
% mu      =   mean([mean(errGD), mean(errNN)]); 
% sigma   =   mean([std(errGD), std(errNN)]);
% pd      =   makedist('Normal', 'mu', mu, 'sigma', sigma);
% figure;
% h1 = probplot(errGD, 'noref');        hold on;
% h2 = probplot(errNN, 'noref');
% h2.Color = 'r';
% probplot(gca, pd);
% grid on;
% xlabel('Test prediction error'); ylabel('Probability');
% legend({'GD', 'NN','Normal'}, 'Location', 'best');
% title('');


load('Results/fit_cno_exp');
errCN0expLS   =   Result.PredError;
errCN0expWLS   =   Result.PredErrorW;
clear Config Data Result

load('Results/fit_cno_poly');
errCN0polLS   =   Result.PredError;
errCN0polWLS   =   Result.PredErrorW;
clear Config Data Result

load('Results/fit_el_exp');
errElexpLS   =   Result.PredError;
errElexpWLS   =   Result.PredErrorW;
clear Config Data Result

load('Results/fit_el_poly');
errElpolLS   =   Result.PredError;
errElpolWLS   =   Result.PredErrorW;
clear Config Data Result

mu      =   mean([  mean(errCN0expLS),  ...
                    mean(errCN0expWLS), ...
                    mean(errCN0polLS),  ...
                    mean(errCN0polWLS)  ]); 
sigma   =   mean([  std(errCN0expLS),   ...
                    std(errCN0expWLS),  ...
                    std(errCN0polLS),   ...
                    std(errCN0polWLS)   ]);
pd      =   makedist('Normal', 'mu', mu, 'sigma', sigma);


figure;
h1 = probplot(errCN0expLS, 'noref');        hold on;
h2 = probplot(errCN0expWLS, 'noref');
h3 = probplot(errCN0polLS, 'noref');
h4 = probplot(errCN0polWLS, 'noref');
h2.Color = 'r'; h3.Color = 'g'; h4.Color = 'c';
probplot(gca, pd);
grid on;
xlabel('Test prediction error'); ylabel('Probability');
legend({'CN0 exp LS', 'CN0 exp WLS','CN0 pol LS', 'CN0 pol WLS'}, 'Location', 'best');
title('');

mu      =   mean([  mean(errElexpLS),   ...
                    mean(errElexpWLS),  ...
                    mean(errElpolLS),   ...
                    mean(errElpolWLS)   ]); 
sigma   =   mean([  std(errElexpLS),    ...
                    std(errElexpWLS),   ...
                    std(errElpolLS),    ...
                    std(errElpolWLS)    ]);
pd      =   makedist('Normal', 'mu', mu, 'sigma', sigma);
figure;
h1 = probplot(errElexpLS, 'noref');        hold on;
h2 = probplot(errElexpWLS, 'noref');
h3 = probplot(errElpolLS, 'noref');
h4 = probplot(errElpolWLS, 'noref');
h2.Color = 'r'; h3.Color = 'g'; h4.Color = 'c';
probplot(gca, pd);
grid on;
xlabel('Test prediction error'); ylabel('Probability');
legend({'Elev exp LS', 'Elev exp WLS','Elev pol LS', 'Elev pol WLS'}, 'Location', 'best');
title('');









% load('../Results/res_gd_mpe');
% errGD   =   Result.GD_Fit.PredError;
% clear Config Data Result
% 
% load('../Results/res_ml_mpe');
% errNN   =   Result.MLFit.PredError;
% clear Config Data Result
