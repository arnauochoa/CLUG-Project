function [MeanOptions, VarOptions]     =   fgetFitOptions(Config)
% ----------------------------------------------------------------------------------------
% This function sets prior fitting options required for the classical regression.
%
% INPUT
%        Config:      Struct. Configuration parameters
% OUTPUT
%   MeanOptions:      fitoptions object. Contains starting point for mean estimation
%    VarOptions:      fitoptions object. Contains starting point for STD estimation

% ----------------------------------------------------------------------------------------

    MeanOptions     =    fitoptions(Config.Regression.Matlab_CF.Mean.Model);
    VarOptions      =    fitoptions(Config.Regression.Matlab_CF.Var.Model);
    
    if strcmp(MeanOptions.Method, 'NonlinearLeastSquares')
            MeanOptions.StartPoint  =   Config.Regression.Matlab_CF.Mean.StartPt;
    end

    if strcmp(VarOptions.Method, 'NonlinearLeastSquares')
            VarOptions.StartPoint   =   Config.Regression.Matlab_CF.Var.StartPt;
    end
end