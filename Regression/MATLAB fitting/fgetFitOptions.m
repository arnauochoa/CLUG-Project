function [MeanOptions, VarOptions]     =   fgetFitOptions(Config)

    MeanOptions     =    fitoptions(Config.Regression.Matlab_CF.Mean.Model);
    VarOptions      =    fitoptions(Config.Regression.Matlab_CF.Var.Model);
    
    if strcmp(MeanOptions.Method, 'NonlinearLeastSquares')
            MeanOptions.StartPoint  =   Config.Regression.Matlab_CF.Mean.StartPt;
    end

    if strcmp(VarOptions.Method, 'NonlinearLeastSquares')
            VarOptions.StartPoint   =   Config.Regression.Matlab_CF.Var.StartPt;
    end
end