function [Result] = fitting(Data, Config)
        N   =   length(Data.Y);

        [MeanOptions, VarOptions]     =   fgetFitOptions(Config);

        % Curve fitting for the mean
        Result.CoeffMean    =   fit(Data.X, Data.Y,                             ...
                            Config.Regression.Matlab_CF.Mean.Model,             ...
                            MeanOptions);

        % Curve fitting for the STD of the random noise
        meanReg             =   Result.CoeffMean(Data.X);
        Result.MeanRMSE     =   1/N * ((meanReg - Data.Y)' * (meanReg - Data.Y));

        Result.AbsErr       =   abs(Data.Y - meanReg);
        Result.CoeffStd     =   fit(Data.X, Result.AbsErr,                      ...
                            Config.Regression.Matlab_CF.Var.Model,              ...
                            VarOptions); 
                        
        stdReg              =   Result.CoeffStd(Data.X);
        Result.StdRMSE      =   1/N * ((stdReg - Result.AbsErr)' * (stdReg - Result.AbsErr));

        % Obtain weights
        weights             =   abs(1./Result.CoeffStd(Data.X));
        weights(isinf(weights)) = realmax;

        % Recompute regression for mean and STD
        MeanOptions.Weights = weights;
        VarOptions.Weights = weights;

        Result.CoeffMeanW   =   fit(Data.X, Data.Y,                             ...
                            Config.Regression.Matlab_CF.Mean.Model,             ...
                            MeanOptions);

        meanRegW            =   Result.CoeffMeanW(Data.X);
        Result.MeanRMSEW    =   sqrt(mean((meanRegW - Data.Y).^2));
        Result.AbsErrW      =   abs(Data.Y - meanRegW);
        
        Result.CoeffStdW    =   fit(Data.X, Result.AbsErrW,                     ...
                            Config.Regression.Matlab_CF.Var.Model,              ...
                            VarOptions);        
        
        stdRegW             =   Result.CoeffStdW(Data.X);
        Result.StdRMSEW     =   sqrt(mean((stdRegW - Result.AbsErr).^2));
        
        prediction          =   Result.CoeffMean(Data.X_Test);
        Result.PredRMSE     =   sqrt(mean((Data.Y_Test-prediction).^2));
        
        predictionW         =   Result.CoeffMeanW(Data.X_Test);
        Result.PredRMSEW    =   sqrt(mean((Data.Y_Test-predictionW).^2));
end