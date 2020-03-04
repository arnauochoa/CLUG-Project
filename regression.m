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
            % Curve fitting for the mean
            RESULT.coeffMean    =   fit(DATA.X, DATA.Y, CONFIG.REGRESSION.MATLAB_CF.MEAN_MODEL);
            
            % Curve fitting for the variance of the random noise
            meanReg             =   RESULT.coeffMean(DATA.X);
            RESULT.sqrdErr      =   (DATA.Y - meanReg).^2;
            RESULT.coeffVar     =   fit(DATA.X, RESULT.sqrdErr, CONFIG.REGRESSION.MATLAB_CF.VAR_MODEL); 
            
            % Obtain weights
            weigths     =   1./sqrt(RESULT.coeffVar(DATA.X));
            
            % Recompute regression for mean and variance
            RESULT.coeffMeanW  =   fit(DATA.X, DATA.Y, CONFIG.REGRESSION.MATLAB_CF.MEAN_MODEL, 'Weights', weigths);
            RESULT.coeffVarW   =   fit(DATA.X, RESULT.sqrdErr, CONFIG.REGRESSION.MATLAB_CF.VAR_MODEL, 'Weights', weigths);
        case 2 % Custom classical regression model
            % TODO
            
        case 3 % Machine learning
            % TODO
            
    end
    
end