function [Result] = fitting(Data, Config)
        N   =   length(Data.Y);

        [MeanOptions, VarOptions]     =   fgetFitOptions(Config);

        % Curve fitting for the mean
        Result.CoeffMean    =   fit(Data.X, Data.Y,                             ...
                            Config.Regression.Matlab_CF.Mean.Model,             ...
                            MeanOptions);

        % Curve fitting for the STD
        meanReg             =   Result.CoeffMean(Data.X);
        Result.MeanRMSE     =   sqrt(mean((meanReg - Data.Y).^2));

        Result.AbsErr       =   abs(Data.Y - meanReg);
        Result.CoeffVar     =   fit(Data.X, Result.AbsErr.^2,                   ...
                            Config.Regression.Matlab_CF.Var.Model,              ...
                            VarOptions); 
                        
        varReg              =   Result.CoeffVar(Data.X);
        Result.VarRMSE      =   sqrt(mean((varReg - Result.AbsErr.^2).^2));

        % Obtain weights
        weights             =   abs(1./Result.CoeffVar(Data.X));
        weights(isinf(weights)) = realmax;

        % Recompute regression for mean and STD
        MeanOptions.Weights = weights;
        VarOptions.Weights  = weights;

        Result.CoeffMeanW   =   fit(Data.X, Data.Y,                             ...
                            Config.Regression.Matlab_CF.Mean.Model,             ...
                            MeanOptions);

        meanRegW            =   Result.CoeffMeanW(Data.X);
        Result.MeanRMSEW    =   sqrt(mean((meanRegW - Data.Y).^2));
        
        Result.AbsErrW      =   abs(Data.Y - meanRegW);
        Result.CoeffVarW    =   fit(Data.X, Result.AbsErrW.^2,                   ...
                            Config.Regression.Matlab_CF.Var.Model,              ...
                            VarOptions); 
        
        
        prediction          =   Result.CoeffMean(Data.X_Test);
        Result.PredRMSE     =   sqrt(mean((Data.Y_Test-prediction).^2));
        
        predictionW         =   Result.CoeffMeanW(Data.X_Test);
        Result.PredError    =   Data.Y_Test - prediction;
        Result.PredErrorW   =   Data.Y_Test - predictionW;
        Result.PredRMSEW    =   sqrt(mean((Data.Y_Test-predictionW).^2));
end