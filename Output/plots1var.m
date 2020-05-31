function plots1var(Data, Config, Result)
    xVals = min(Data.X)-100:max(Data.X)+100;
    
    %% MEAN FITTING
    figure;
    plot(Data.X_Test, Data.Y_Test, '.');        hold on;
    plot(Result.CoeffMean, 'r');                hold on;
    plot(Result.CoeffMeanW, 'c');               hold on;
    xlabel(Config.Data.X); ylabel(Config.Data.Y);
    legend('Data', 'Mean fitting', 'Weighted Mean fitting');
%     title(['Fitting of the mean. f(x) = ' formula(Result.CoeffMean)]);

    %% VAR FITTING
    edges       =   floor(min(Data.X_Test)):1:ceil(max(Data.X_Test));
    xDisc       =   edges(discretize(Data.X_Test, edges));
    uniqueX     =   unique(xDisc);
    numPointsX  =   nan(length(uniqueX), 1);
    for i = 1:length(uniqueX)
        numPointsX(i) = sum(xDisc == uniqueX(i));
    end

    normNumPointsX = numPointsX./length(Data.X_Test);
    quantile95  =   nan(length(uniqueX), 1);
    for i = 1:length(uniqueX)
        quantile95(i) = quantile(Data.Y_Test(xDisc == uniqueX(i)),0.95);
    end

    rmse        =   sqrt(mean((2*sqrt(Result.CoeffVar(uniqueX)) - quantile95).^2));
    fprintf('2-sigma RMSE LS = %f\n', rmse);

    figure;
%     yyaxis left
    plot(Data.X_Test, abs(Result.PredError), '.');                       hold on;
    xLimits = get(gca,'XLim');  %# Get the range of the x axis
    plot(xVals, sqrt(abs(Result.CoeffVar(xVals))), 'c-');
    plot(xVals, 2*sqrt(abs(Result.CoeffVar(xVals))), 'g-');
    plot(xVals, 3*sqrt(abs(Result.CoeffVar(xVals))), 'r-');
    plot(uniqueX,quantile95,'k-','Marker','.','MarkerSize',16);
    ylabel([Config.Data.Y ' \sigma']);
    xlim(xLimits);
    xlabel(Config.Data.X);
%     yyaxis right
%     ylim([0 10]);
%     plot(uniqueX,normNumPointsX*100);                      hold off;
%     ylabel('Number of points (%)');
    legend('y - \mu_{y,LS}', '\sigma', '2\sigma', '3\sigma','Quantile 0.95');
%     title(['Fitting of the standard deviation. f(x) = ' formula(Result.CoeffStd)]);

    %% WEIGHTED VAR FITTING
%     edges = floor(min(Data.X_Test)):1:ceil(max(Data.X_Test));
%     xDisc = edges(discretize(Data.X_Test, edges));
%     uniqueX = unique(xDisc);
%     for i = 1:1:length(uniqueX)
%         numPointsX(i,1) = sum(xDisc == uniqueX(i));
%     end
% 
%     normNumPointsX = numPointsX./length(Data.X_Test);
%     for i = 1:1:length(uniqueX)
%         quantile95(i,1) = quantile(Data.Y_Test(xDisc == uniqueX(i)),0.95);
%     end

    rmseW        =   sqrt(mean((2*sqrt(Result.CoeffVarW(uniqueX)) - quantile95).^2));
    fprintf('2-sigma RMSE WLS = %f\n', rmse);

    figure;
%     yyaxis left
    plot(Data.X_Test, abs(Result.PredErrorW), '.');                       hold on;
    xLimits = get(gca,'XLim');  %# Get the range of the x axis
    plot(xVals, sqrt(abs(Result.CoeffVarW(xVals))), 'c-');
    plot(xVals, 2*sqrt(abs(Result.CoeffVarW(xVals))), 'g-');
    plot(xVals, 3*sqrt(abs(Result.CoeffVarW(xVals))), 'r-');
    plot(uniqueX,quantile95,'k-','Marker','.','MarkerSize',16);
    ylabel([Config.Data.Y ' \sigma']);
    xlim(xLimits);
    xlabel(Config.Data.X);
%     yyaxis right
%     ylim([0 10]);
%     plot(uniqueX,normNumPointsX*100);                      hold off;
%     ylabel('Number of points (%)');
    legend('y - \mu_{y,WLS}', '\sigma', '2\sigma', '3\sigma','Quantile 0.95');
%     title(['Fitting of the standard deviation. f(x) = ' formula(Result.CoeffStd)]);               

    %% CDF PLOTS
    mu      =   mean(Result.PredError); 
    sigma   =   std(Result.PredError);
    pd      =   makedist('Normal', 'mu', mu, 'sigma', sigma);
    figure;
    probplot(Result.PredError, 'noref');
    probplot(gca, pd);
    grid on;
    xlabel('Test prediction error'); ylabel('Probability');
    title('');
%     title(sprintf('Normal Probability Plot for LS. \\mu = %0.2f, \\sigma = %0.2f', mu, sigma));
    
    mu      =   mean(Result.PredErrorW); 
    sigma   =   std(Result.PredErrorW);
    pd      =   makedist('Normal', 'mu', mu, 'sigma', sigma);
    figure;
    probplot(Result.PredErrorW, 'noref');
    probplot(gca, pd);
    grid on;
    xlabel('Test prediction error'); ylabel('Probability');
    title('');
%     title(sprintf('Normal Probability Plot for WLS. \\mu = %0.2f, \\sigma = %0.2f', mu, sigma));
    
    
%     %% SAVE DATA
%     % Filtered quantile
%     xData               =   Config.Data.X{1};
%     xThreshold          =   Config.Output.FData.XThreshold;
%     filtQuantile        =   quantile95(uniqueX >= xThreshold);
%     xFiltered           =   uniqueX(uniqueX >= xThreshold);
%     save('percentile95.mat', 'xData', 'xThreshold', 'xFiltered', 'filtQuantile');
    
end