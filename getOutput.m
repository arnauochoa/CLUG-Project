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
        
        switch CONFIG.DATA.TYPE
            case 1
                xVals = min(DATA.X)-100:max(DATA.X)+100;
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
                switch CONFIG.DATA.N_VARS
                    case 1
                        plots1var(DATA, CONFIG, RESULT)
                    case 2
                        plots2vars(DATA, CONFIG, RESULT)
                end
        end
end
