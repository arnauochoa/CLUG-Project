function [Result] = mlFitting(Data, Config)

    
    [m, n]      =   size(Data.X);
    
    % Build vector with features as unknowns
    Xvar    =   sym('x', [1 n]);
    Xvar    =   mapFeatures(Xvar, Config.Regression.GradDes.Deg);

    [Result.MLfit.thetaMean    , ...
     Result.MLfit.muMean       , ...
     Result.MLfit.sigmaMean    , ...
     Result.MLfit.J_historyMean, ...
     Result.MLfit.errorMean    , ...
     Result.MLfit.X_norm]   = gradientDescent(Data.X, Data.Y, Config);
 
    Result.MLfit.fmean  =   Xvar * Result.MLfit.thetaMean;
    
    Xmap        =   mapFeatures(Result.MLfit.X_norm, Config.Regression.GradDes.Deg);
    evalFMean   =   Xmap * Result.MLfit.thetaMean;
    Result.MLfit.meanRMSE   =   1/m * ((evalFMean - Data.Y)' * (evalFMean - Data.Y));
    
    [Result.MLfit.thetaStd    , ...
     Result.MLfit.muStd       , ...
     Result.MLfit.sigmaStd    , ...
     Result.MLfit.J_historyStd, ...
     Result.MLfit.errorStd    , ...
     ~]   = gradientDescent(Data.X, abs(Result.MLfit.errorMean), Config);
    
    Result.MLfit.fstd  =   Xvar * Result.MLfit.thetaStd;
                                
    evalFStd   =   Xmap * Result.MLfit.thetaStd;
    Result.MLfit.stdRMSE   =   1/m * ((evalFStd - abs(Result.MLfit.errorMean))' * (evalFStd - abs(Result.MLfit.errorMean)));
    
end