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

    switch Config.Regression.Method
        case 1 % MATLAB Curve fitting
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
                    disp('========== Fitting results: ==========');
                    disp(' >> Mean:');
                    disp(Result.CoeffMeanW);
                    disp(' >> STD:');
                    disp(Result.CoeffStdW);
                    fprintf(' >> Mean RMSE: %0.4f\n', Result.MeanRMSE);
                    fprintf(' >> Mean RMSE Weighted: %0.4f\n', Result.MeanRMSEW);
                    fprintf(' >> STD RMSE: %0.4f\n', Result.StdRMSE);
                    fprintf(' >> STD RMSE Weighted: %0.4f\n', Result.StdRMSEW);
                    fprintf('---- Prediction RMSE : %0.4f ----\n', Result.PredRMSE);
                    fprintf('---- Prediction RMSE W: %0.4f ----\n', Result.PredRMSEW);

                    switch Config.Data.N_Vars
                        case 1
                            plots1var(Data, Config, Result);
                        case 2
                            plots2vars(Data, Config, Result);
                    end
            end
        case 2 % Gradient descent fitting
            plotsGD(Data, Config, Result)
    end     
end
