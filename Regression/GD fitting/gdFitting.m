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
    Result.GD_Fit.MeanRMSE   =   sqrt(mean((evalFMean - Data.Y).^2));
    
    %% Obtain fitting for the standard deviation
    [Result.GD_Fit.ThetaVar    , ...
     Result.GD_Fit.MuVar       , ...
     Result.GD_Fit.SigmaVar    , ...
     Result.GD_Fit.CostFunVar  , ...
     Result.GD_Fit.ErrorVar    , ...
     ~]   = gradientDescent(Data.X, abs(Result.GD_Fit.ErrorMean).^2, Config);
    
    % Build vector with features as unknowns
    Xvar    =   sym('x', [1 nVars]);
    Xvar    =   (Xvar - Result.GD_Fit.MuVar) ./ Result.GD_Fit.SigmaVar;
    Xvar    =   mapFeatures(Xvar, Config.Regression.GradDes.Deg);
    % Add bias term to X
    Xvar    =   [1, Xvar];
    % Generate function with the obtained parameters
    Result.GD_Fit.Fvar  =   Xvar * Result.GD_Fit.ThetaVar;
                                

    %% Evaluate result on test data
    nTest       =   size(Data.X_Test, 1);
    % Normalize test data
    XTestNorm   =   (Data.X_Test - Result.GD_Fit.MuMean) ./ Result.GD_Fit.SigmaMean;
    % Add polynimoial components map data to evaluate
    XTestEval   =   mapFeatures(XTestNorm, Config.Regression.GradDes.Deg);
    XTestEval   =   [ones(nTest, 1), XTestEval];
    % Evaluate test data and find RMSE
    prediction              =   XTestEval * Result.GD_Fit.ThetaMean;
    Result.GD_Fit.PredError =   Data.Y_Test - prediction;
    Result.GD_Fit.PredRMSE  =   sqrt(mean((Data.Y_Test - prediction).^2));
    
end