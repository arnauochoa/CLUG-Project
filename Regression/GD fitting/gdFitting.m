function [Result] = gdFitting(Data, Config)

    % Initializations
    [nExamp, nVars]      =   size(Data.X);
    
    %% Obtain fitting for the mean
    [Result.GD_Fit.ThetaMean    , ...
     Result.GD_Fit.MuMean       , ...
     Result.GD_Fit.SigmaMean    , ...
     Result.GD_Fit.CostFunMean,   ...
     Result.GD_Fit.ErrorMean    , ...
     Result.GD_Fit.X_norm]   = gradientDescent(Data.X, Data.Y, Config);
 
    % Build vector with features as unknowns
    Xvar    =   sym('x', [1 nVars]);
    Xvar    =   (Xvar - Result.GD_Fit.MuMean) ./ Result.GD_Fit.SigmaMean;
    Xvar    =   mapFeatures(Xvar, Config.Regression.GradDes.Deg);
    % Add bias term to X
    Xvar    =   [1, Xvar];
    % Generate function with the obtained parameters
    Result.GD_Fit.Fmean  =   Xvar * Result.GD_Fit.ThetaMean;
    
    % Find error for the mean
    Xmap        =   mapFeatures(Result.GD_Fit.X_norm, Config.Regression.GradDes.Deg);
    Xmap        =   [ones(nExamp, 1) Xmap];
    evalFMean   =   Xmap * Result.GD_Fit.ThetaMean;
    Result.GD_Fit.MeanRMSE   =   1/nExamp * ((evalFMean - Data.Y)' * (evalFMean - Data.Y));
    
    %% Obtain fitting for the standard deviation
    [Result.GD_Fit.ThetaStd    , ...
     Result.GD_Fit.MuStd       , ...
     Result.GD_Fit.SigmaStd    , ...
     Result.GD_Fit.CostFunStd,   ...
     Result.GD_Fit.ErrorStd    , ...
     ~]   = gradientDescent(Data.X, abs(Result.GD_Fit.ErrorMean), Config);
    
    % Build vector with features as unknowns
    Xvar    =   sym('x', [1 nVars]);
    Xvar    =   (Xvar - Result.GD_Fit.MuStd) ./ Result.GD_Fit.SigmaStd;
    Xvar    =   mapFeatures(Xvar, Config.Regression.GradDes.Deg);
    % Add bias term to X
    Xvar    =   [1, Xvar];
    % Generate function with the obtained parameters
    Result.GD_Fit.Fstd  =   Xvar * Result.GD_Fit.ThetaStd;
                                
    evalFStd   =   Xmap * Result.GD_Fit.ThetaStd;
    Result.GD_Fit.StdRMSE   =   1/nExamp * ((evalFStd - abs(Result.GD_Fit.ErrorMean))' ...
        * (evalFStd - abs(Result.GD_Fit.ErrorMean)));
    
    %% Evaluate result on test data
    nTest       =   size(Data.X_Test, 1);
    % Normalize test data
    XTestNorm   =   (Data.X_Test - Result.GD_Fit.MuMean) ./ Result.GD_Fit.SigmaMean;
    % Add polynimoial components map data to evaluate
    XTestEval   =   mapFeatures(XTestNorm, Config.Regression.GradDes.Deg);
    XTestEval   =   [ones(nTest, 1), XTestEval];
    % Evaluate test data and find RMSE
    prediction              =   XTestEval * Result.GD_Fit.ThetaMean;
    Result.GD_Fit.PredRMSE  =   sqrt(mean((Data.Y_Test - prediction).^2));
    
end