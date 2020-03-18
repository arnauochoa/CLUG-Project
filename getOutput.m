function getOutput(DATA, CONFIG, RESULT)
% This function applies the regression technique selected in configuration
%
% INPUT
%           DATA:       Struct. Input data
%           CONFIG:     Struct. Configuration parameters
%           result:     ....   
%           
% ----------------------------------------------------------------------------------------
        set(0, 'DefaultLineLineWidth', 1.5);
        xVals = min(DATA.X)-100:max(DATA.X)+100;
        switch CONFIG.DATA.TYPE
            case 1
                figure;
                plot(DATA.X, DATA.Y, '.');          hold on;
                plot(RESULT.coeffMean, 'r');        hold on;
                plot(RESULT.coeffMeanW, 'c');       hold on;
                plot(DATA.X, DATA.MEAN, 'g');
                legend('Data', 'Mean fitting', 'Weighted Mean fitting', 'True mean');

                figure;
                plot(DATA.X, RESULT.absErr, '.');                hold on;
                xLimits = get(gca,'XLim');  %# Get the range of the x axis
                plot(xVals, RESULT.coeffStd(xVals), 'r');         hold on;
                plot(xVals, RESULT.coeffStdW(xVals), 'c');        hold on;
                xlim(xLimits);
                plot(DATA.X, DATA.VAR, 'g')
                legend('Squared error', 'STD fitting', 'Weighted STD fitting', 'True variance')
            case 2
                %% MEAN FITTING
                figure;
                plot(DATA.X, DATA.Y, '.');          hold on;
                plot(RESULT.coeffMean, 'r');        hold on;
                plot(RESULT.coeffMeanW, 'c');       hold on;
                xlabel(CONFIG.DATA.X); ylabel(CONFIG.DATA.Y);
                legend('Data', 'Mean fitting', 'Weighted Mean fitting');
                title(['Fitting of the mean. f(x) = ' formula(RESULT.coeffMean)]);
                
                %% STD FITTING
                edges = floor(min(DATA.X)):1:ceil(max(DATA.X));
                xDisc = edges(discretize(DATA.X, edges));
                uniqueX = unique(xDisc);
                for i = 1:1:length(uniqueX)
                    numPointsX(i,1) = sum(xDisc == uniqueX(i));
                end
                
                normNumPointsX = numPointsX./length(DATA.X);
                for i = 1:1:length(uniqueX)
                    quantile95(i,1) = quantile(DATA.Y(xDisc == uniqueX(i)),0.95);
                end

                rmse     =   sqrt(mean((2*RESULT.coeffStd(uniqueX) - quantile95).^2));
                fprintf('2-sigma RMSE = %f\n', rmse);
                
                figure;
                yyaxis left
                plot(DATA.X, RESULT.absErr, '.');               hold on;
                xLimits = get(gca,'XLim');  %# Get the range of the x axis
                plot(xVals, RESULT.coeffStd(xVals), 'c-');
                plot(xVals, 2*RESULT.coeffStd(xVals), 'g-');
                plot(xVals, 3*RESULT.coeffStd(xVals), 'r-');
                plot(uniqueX,quantile95,'k-','Marker','.','MarkerSize',16);
                ylabel([CONFIG.DATA.Y ' \sigma']);
                yyaxis right
                ylim([0 10]);
                plot(uniqueX,normNumPointsX*100);                      hold off;
                xlim(xLimits);
                xlabel(CONFIG.DATA.X);
                ylabel('Number of points (%)');
                legend('y - \mu_y', '\sigma', '2\sigma', '3\sigma','Quantile 0.95');
                title(['Fitting of the standard deviation. f(x) = ' formula(RESULT.coeffStd)]);
                
                %% WEIGHTED STD FITTING
                edges = floor(min(DATA.X)):1:ceil(max(DATA.X));
                xDisc = edges(discretize(DATA.X, edges));
                uniqueX = unique(xDisc);
                for i = 1:1:length(uniqueX)
                    numPointsX(i,1) = sum(xDisc == uniqueX(i));
                end
                
                normNumPointsX = numPointsX./length(DATA.X);
                for i = 1:1:length(uniqueX)
                    quantile95(i,1) = quantile(DATA.Y(xDisc == uniqueX(i)),0.95);
                end
                
                rmseW     =   sqrt(mean((2*RESULT.coeffStdW(uniqueX) - quantile95).^2));
                fprintf('Weighted 2-sigma RMSE = %f\n', rmseW);

                figure;
                yyaxis left
                plot(DATA.X, RESULT.absErrW, '.');               hold on;
                xLimits = get(gca,'XLim');  %# Get the range of the x axis
                plot(xVals, RESULT.coeffStdW(xVals), 'c-');
                plot(xVals, 2*RESULT.coeffStdW(xVals), 'g-');
                plot(xVals, 3*RESULT.coeffStdW(xVals), 'r-');
                plot(uniqueX,quantile95,'k-','Marker','.','MarkerSize',16);
                ylabel([CONFIG.DATA.Y ' \sigma']);
                yyaxis right
                ylim([0 10]);
                plot(uniqueX,normNumPointsX*100);                      hold off;
                xlim(xLimits);
                xlabel(CONFIG.DATA.X);
                ylabel('Number of points (%)');
                legend('y - \mu_y', '\sigma', '2\sigma', '3\sigma','Quantile 0.95');
                title(['Fitting of the weighted standard deviation. f(x) = ' formula(RESULT.coeffStdW)]);               
                
                %% CDF PLOTS
                [normError, normErrorW] = normalizeError(DATA,RESULT);
                
%                 N       =   length(DATA.X);
                quant   =   .99;
                sigma   =   2 * (quantile(normError, quant) - quantile(normError, .5));
                pd      =   makedist('Normal', 'mu', mean(normError), 'sigma', sigma);
                
                figure;
                probplot(normError, 'noref');
                probplot(gca, pd);
                grid on;
                xlabel('PR Error normalized'); ylabel('Probability');
                title(sprintf('Normal Probability Plot, sigma at %.4f quantile', quant));
                
                sigmaW   =   2 * (quantile(normErrorW, quant) - quantile(normErrorW, .5));
                pdW      =   makedist('Normal', 'mu', mean(normErrorW), 'sigma', sigmaW);
                
                figure;
                probplot(normErrorW, 'noref');
                probplot(gca, pdW);
                grid on;
                xlabel('PR Error normalized'); ylabel('Probability');
                title(sprintf('Normal Probability Plot (Wheighted), sigma at %.4f quantile', quant));
        end
end
