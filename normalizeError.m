function [normError, normErrorW] = normalizeError(DATA,RESULT)
% ----------------------------------------------------------------------------------------
% This function normalizes the squared error by dividing by its variance.
%
% INPUT
%           DATA:     Struct. Input data
%           RESULT:     
% OUTPUT
%           normError   Normalized error for fitting   
%           normErrorW  Normalized error for weighting fitting
% ----------------------------------------------------------------------------------------
    normError = sort(DATA.Y./sqrt(RESULT.coeffVar(DATA.X)));
    normErrorW = sort(DATA.Y./sqrt(RESULT.coeffVarW(DATA.X)));

end