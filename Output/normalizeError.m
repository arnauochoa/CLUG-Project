function [normError, normErrorW] = normalizeError(Data, Result)
% ----------------------------------------------------------------------------------------
% This function normalizes the squared error by dividing by its STD.
%
% INPUT
%           Data:           Struct. Prepared data
%           Result:         Struct. Results obtained from regression
% OUTPUT
%           normError:      Normalized error for LS regression   
%           normErrorW:     Normalized error for WLS regression
% ----------------------------------------------------------------------------------------
    normError = sort(Data.Y./Result.CoeffStd(Data.X));
    normErrorW = sort(Data.Y./Result.CoeffStdW(Data.X));

end