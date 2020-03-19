function [Result] = fitting(Data, Config)

        [MeanOptions, VarOptions]     =   fgetFitOptions(Config);

        % Curve fitting for the mean
        Result.CoeffMean    =   fit(Data.X, Data.Y,                             ...
                            Config.Regression.Matlab_CF.Mean.Model,             ...
                            MeanOptions);

        % Curve fitting for the STD of the random noise
        meanReg             =   Result.CoeffMean(Data.X);
        Result.AbsErr       =   abs(Data.Y - meanReg);
        Result.CoeffStd     =   fit(Data.X, Result.AbsErr,                      ...
                            Config.Regression.Matlab_CF.Var.Model,              ...
                            VarOptions); 

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
        Result.AbsErrW      =   abs(Data.Y - meanRegW);
        Result.CoeffStdW    =   fit(Data.X, Result.AbsErrW,                     ...
                            Config.Regression.Matlab_CF.Var.Model,              ...
                            VarOptions);            
end