function [RESULT] = regression(DATA, CONFIG)
% ----------------------------------------------------------------------------------------
% This function applies the regression technique selected in configuration
%
% INPUT
%           DATA:       Struct. Input data
%           CONFIG:     Struct. Configuration parameters
%
% OUTPUT
%           result:     ....    
%
% ----------------------------------------------------------------------------------------
    
    RESULT = struct;

    switch CONFIG.REGRESSION.METHOD
        case 1 % MATLAB curve fitting function
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
            weights             =   1./RESULT.coeffStd(DATA.X);
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
        case 2 % Custom classical regression model
            % TODO
            
        case 3 % Machine learning
            % TODO
            
    end
    
end