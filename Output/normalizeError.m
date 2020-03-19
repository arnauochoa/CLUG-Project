function [normError, normErrorW] = normalizeError(Data, Result)
% ----------------------------------------------------------------------------------------
% This function normalizes the squared error by dividing by its STD.
%
% INPUT
%           DATA:     Struct. Input data
%           RESULT:     
% OUTPUT
%           normError   Normalized error for fitting   
%           normErrorW  Normalized error for weighting fitting
% ----------------------------------------------------------------------------------------
    normError = sort(Data.Y./Result.CoeffStd(Data.X));
    normErrorW = sort(Data.Y./Result.CoeffStdW(Data.X));

end