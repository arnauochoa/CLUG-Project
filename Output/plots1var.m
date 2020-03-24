function plots1var(Data, Config, Result)
    xVals = min(Data.X)-100:max(Data.X)+100;
    
    %% MEAN FITTING
    figure;
    plot(Data.X, Data.Y, '.');          hold on;
    plot(Result.CoeffMean, 'r');        hold on;
    plot(Result.CoeffMeanW, 'c');       hold on;
    xlabel(Config.Data.X); ylabel(Config.Data.Y);
    legend('Data', 'Mean fitting', 'Weighted Mean fitting');
    title(['Fitting of the mean. f(x) = ' formula(Result.CoeffMean)]);

    %% STD FITTING
    edges       =   floor(min(Data.X)):1:ceil(max(Data.X));
    xDisc       =   edges(discretize(Data.X, edges));
    uniqueX     =   unique(xDisc);
    numPointsX  =   nan(length(uniqueX), 1);
    for i = 1:length(uniqueX)
        numPointsX(i) = sum(xDisc == uniqueX(i));
    end

    normNumPointsX = numPointsX./length(Data.X);
    quantile95  =   nan(length(uniqueX), 1);
    for i = 1:length(uniqueX)
        quantile95(i) = quantile(Data.Y(xDisc == uniqueX(i)),0.95);
    end

    rmse        =   sqrt(mean((2*Result.CoeffStd(uniqueX) - quantile95).^2));
    fprintf('2-sigma RMSE = %f\n', rmse);

    figure;
    yyaxis left
    plot(Data.X, Result.AbsErr, '.');                       hold on;
    xLimits = get(gca,'XLim');  %# Get the range of the x axis
    plot(xVals, Result.CoeffStd(xVals), 'c-');
    plot(xVals, 2*Result.CoeffStd(xVals), 'g-');
    plot(xVals, 3*Result.CoeffStd(xVals), 'r-');
    plot(uniqueX,quantile95,'k-','Marker','.','MarkerSize',16);
    ylabel([Config.Data.Y ' \sigma']);
    yyaxis right
    ylim([0 10]);
    plot(uniqueX,normNumPointsX*100);                      hold off;
    xlim(xLimits);
    xlabel(Config.Data.X);
    ylabel('Number of points (%)');
    legend('y - \mu_y', '\sigma', '2\sigma', '3\sigma','Quantile 0.95');
    title(['Fitting of the standard deviation. f(x) = ' formula(Result.CoeffStd)]);

    %% WEIGHTED STD FITTING
    edges = floor(min(Data.X)):1:ceil(max(Data.X));
    xDisc = edges(discretize(Data.X, edges));
    uniqueX = unique(xDisc);
    for i = 1:1:length(uniqueX)
        numPointsX(i,1) = sum(xDisc == uniqueX(i));
    end

    normNumPointsX = numPointsX./length(Data.X);
    for i = 1:1:length(uniqueX)
        quantile95(i,1) = quantile(Data.Y(xDisc == uniqueX(i)),0.95);
    end

    rmseW     =   sqrt(mean((2*Result.CoeffStdW(uniqueX) - quantile95).^2));
    fprintf('Weighted 2-sigma RMSE = %f\n', rmseW);

    figure;
    yyaxis left
    plot(Data.X, Result.AbsErrW, '.');                      hold on;
    xLimits = get(gca,'XLim');  %# Get the range of the x axis
    plot(xVals, Result.CoeffStdW(xVals), 'c-');
    plot(xVals, 2*Result.CoeffStdW(xVals), 'g-');
    plot(xVals, 3*Result.CoeffStdW(xVals), 'r-');
    plot(uniqueX,quantile95,'k-','Marker','.','MarkerSize',16);
    ylabel([Config.Data.Y ' \sigma']);
    yyaxis right
    ylim([0 10]);
    plot(uniqueX,normNumPointsX*100);                      hold off;
    xlim(xLimits);
    xlabel(Config.Data.X);
    ylabel('Number of points (%)');
    legend('y - \mu_y', '\sigma', '2\sigma', '3\sigma','Quantile 0.95');
    title(['Fitting of the weighted standard deviation. f(x) = ' formula(Result.CoeffStdW)]);               

    %% CDF PLOTS
    [normError, normErrorW] = normalizeError(Data,Result);

%                 N       =   length(Data.X);
    sigma   =   2 * (quantile(normError, Config.Output.Cdf.RefVarQuant) - quantile(normError, .5));
    pd      =   makedist('Normal', 'mu', mean(normError), 'sigma', sigma);

    figure;
    probplot(normError, 'noref');
    probplot(gca, pd);
    grid on;
    xlabel('PR Error normalized'); ylabel('Probability');
    title(sprintf('Normal Probability Plot, sigma at %.4f quantile', Config.Output.Cdf.RefVarQuant));

    sigmaW   =   2 * (quantile(normErrorW, Config.Output.Cdf.RefVarQuant) - quantile(normErrorW, .5));
    pdW      =   makedist('Normal', 'mu', mean(normErrorW), 'sigma', sigmaW);

    figure;
    probplot(normErrorW, 'noref');
    probplot(gca, pdW);
    grid on;
    xlabel('PR Error normalized'); ylabel('Probability');
    title(sprintf('Normal Probability Plot (Wheighted), sigma at %.4f quantile', Config.Output.Cdf.RefVarQuant));
end