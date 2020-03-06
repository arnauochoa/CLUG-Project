function [MEAN_OPTIONS, VAR_OPTIONS]     =   fgetFitOptions(CONFIG)

    MEAN_OPTIONS     =    fitoptions(CONFIG.REGRESSION.MATLAB_CF.MEAN.MODEL);
    VAR_OPTIONS      =    fitoptions(CONFIG.REGRESSION.MATLAB_CF.VAR.MODEL);
    
    if strcmp(MEAN_OPTIONS.Method, 'NonlinearLeastSquares')
            MEAN_OPTIONS.StartPoint = CONFIG.REGRESSION.MATLAB_CF.MEAN.START_PT;
    end

    if strcmp(VAR_OPTIONS.Method, 'NonlinearLeastSquares')
            VAR_OPTIONS.StartPoint = CONFIG.REGRESSION.MATLAB_CF.VAR.START_PT;
    end
end