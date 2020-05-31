function getOutput(Data, Config, Result)
% This function returns the results computed and plots corresponding to the 
% regression technique selected in configuration.
%
% INPUT
%           Data:       Struct. Prepared data
%           Config:     Struct. Configuration parameters
%           Result:     Struct. Results obtained from regression   
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
                    xlim(xLimits);
                    plot(Data.X, Data.Var, 'g')
                    legend('Squared error', 'STD fitting', 'Weighted STD fitting', 'True variance')
                case 2
                    disp('========== Fitting results: ==========');
                    disp(' >> Mean:');
                    disp(Result.CoeffMeanW);
                    fprintf(' >> Mean RMSE: %0.4f\n', Result.MeanRMSE);
                    fprintf(' >> Mean RMSE Weighted: %0.4f\n', Result.MeanRMSEW);
                    fprintf('---- Prediction RMSE : %0.4f ----\n', Result.PredRMSE);
                    fprintf('---- Prediction RMSE W: %0.4f ----\n', Result.PredRMSEW);

                    switch Config.Data.N_Feat
                        case 1
                            plots1var(Data, Config, Result);
                        case 2
                            plots2vars(Data, Config, Result);
                    end
            end
        case 2 % Gradient descent fitting
            plotsGD(Data, Config, Result)
        case 3 % Neural Network
            plotsNN(Data, Config, Result)
    end     
end
