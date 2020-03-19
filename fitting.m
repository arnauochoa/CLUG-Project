function [RESULT] = fitting(DATA, CONFIG)

        [MEAN_OPTIONS, VAR_OPTIONS]     =   fgetFitOptions(CONFIG);

        % Curve fitting for the mean
        RESULT.coeffMean    =   fit(DATA.X, DATA.Y,                             ...
                            CONFIG.REGRESSION.MATLAB_CF.MEAN.MODEL,             ...
                            MEAN_OPTIONS);

        % Curve fitting for the STD of the random noise
        meanReg             =   RESULT.coeffMean(DATA.X);
        RESULT.absErr       =   abs(DATA.Y - meanReg);
        RESULT.coeffStd     =   fit(DATA.X, RESULT.absErr,                     ...
                            CONFIG.REGRESSION.MATLAB_CF.VAR.MODEL,              ...
                            VAR_OPTIONS); 

        % Obtain weights
        weights             =   abs(1./RESULT.coeffStd(DATA.X));
        weights(isinf(weights)) = realmax;

        % Recompute regression for mean and STD
        MEAN_OPTIONS.Weights = weights;
        VAR_OPTIONS.Weights = weights;

        RESULT.coeffMeanW   =   fit(DATA.X, DATA.Y,                             ...
                            CONFIG.REGRESSION.MATLAB_CF.MEAN.MODEL,             ...
                            MEAN_OPTIONS);

        meanRegW            =   RESULT.coeffMeanW(DATA.X);
        RESULT.absErrW      =   abs(DATA.Y - meanRegW);
        RESULT.coeffStdW    =   fit(DATA.X, RESULT.absErrW,                     ...
                            CONFIG.REGRESSION.MATLAB_CF.VAR.MODEL,              ...
                            VAR_OPTIONS);            
end