function [normError, normErrorW] = normalizeError(DATA,RESULT)
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
    normError = sort(DATA.Y./RESULT.coeffStd(DATA.X));
    normErrorW = sort(DATA.Y./RESULT.coeffStdW(DATA.X));

end