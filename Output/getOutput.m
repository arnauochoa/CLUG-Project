function getOutput(Data, Config, Result)
% This function applies the regression technique selected in configuration
%
% INPUT
%           Data:       Struct. Input data
%           CONFIG:     Struct. Configuration parameters
%           result:     ....   
%           
% ----------------------------------------------------------------------------------------
        set(0, 'DefaultLineLineWidth', 1.5);
        
        switch Config.Data.Type
            case 1
                xVals = min(Data.X)-100:max(Data.X)+100;
                figure;
                plot(Data.X, Data.Y, '.');          hold on;
                plot(Result.CoeffMean, 'r');        hold on;
                plot(Result.CoeffMeanW, 'c');       hold on;
                plot(Data.X, Data.Mean, 'g');
                legend('Data', 'Mean fitting', 'Weighted Mean fitting', 'True mean');

                figure;
                plot(Data.X, Result.AbsErr, '.');                hold on;
                xLimits = get(gca,'XLim');  %# Get the range of the x axis
                plot(xVals, Result.CoeffStd(xVals).^2, 'r');         hold on;
                plot(xVals, Result.CoeffStdW(xVals).^2, 'c');        hold on;
                xlim(xLimits);
                plot(Data.X, Data.Var, 'g')
                legend('Squared error', 'STD fitting', 'Weighted STD fitting', 'True variance')
            case 2
                switch Config.Data.N_Vars
                    case 1
                        plots1var(Data, Config, Result);
                    case 2
                        plots2vars(Data, Config, Result);
                end
        end
end
