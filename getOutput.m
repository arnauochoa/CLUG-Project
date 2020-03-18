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
                plot(DATA.X, sqrt(RESULT.sqrdErr), '.');                hold on;
                xLimits = get(gca,'XLim');  %# Get the range of the x axis
                plot(xVals, sqrt(RESULT.coeffVar(xVals)), 'r');         hold on;
                plot(xVals, sqrt(RESULT.coeffVarW(xVals)), 'c');        hold on;
                xlim(xLimits);
                plot(DATA.X, DATA.VAR, 'g')
                legend('Squared error', 'Variance fitting', 'Weighted Variance fitting', 'True variance')
            case 2
                figure;
                plot(DATA.X, DATA.Y, '.');          hold on;
                plot(RESULT.coeffMean, 'r');        hold on;
                plot(RESULT.coeffMeanW, 'c');       hold on;
                xlabel(CONFIG.DATA.X); ylabel(CONFIG.DATA.Y);
                legend('Data', 'Mean fitting', 'Weighted Mean fitting');
                title(['Fitting of the mean. f(x) = ' formula(RESULT.coeffMean)]);
                
                figure;
                plot(DATA.X, sqrt(RESULT.sqrdErr), '.');               hold on;
                xLimits = get(gca,'XLim');  %# Get the range of the x axis
                plot(xVals, sqrt(RESULT.coeffVar(xVals)), 'c');        hold on;
                plot(xVals, 2*sqrt(RESULT.coeffVar(xVals)), 'g');      hold on;
                plot(xVals, 3*sqrt(RESULT.coeffVar(xVals)), 'r');      hold on;
                xlim(xLimits);
                xlabel(CONFIG.DATA.X); ylabel([CONFIG.DATA.Y ' \sigma']);
                legend('y - \mu_y', '\sigma', '2\sigma', '3\sigma');
                title(['Fitting of the standard deviation. f(x) = ' formula(RESULT.coeffVar)]);
                
                figure;
                plot(DATA.X, sqrt(RESULT.sqrdErr), '.');               hold on;
                xLimits = get(gca,'XLim');  %# Get the range of the x axis
                plot(xVals, sqrt(RESULT.coeffVarW(xVals)), 'c');       hold on;
                plot(xVals, 2*sqrt(RESULT.coeffVarW(xVals)), 'g');     hold on;
                plot(xVals, 3*sqrt(RESULT.coeffVarW(xVals)), 'r');     hold on;
                xlim(xLimits);
                xlabel(CONFIG.DATA.X); ylabel([CONFIG.DATA.Y ' \sigma']);
                legend('y - \mu_y', '\sigma', '2\sigma', '3\sigma');
                title(['Weighted fitting of the standard deviation. f(x) = ' formula(RESULT.coeffVar)]);
        
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
