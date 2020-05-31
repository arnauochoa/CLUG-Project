function [X_norm, mu, sigma] = featureNormalize(X)
% ----------------------------------------------------------------------------------------
%FEATURENORMALIZE Normalizes the features in X 
%   FEATURENORMALIZE(X) returns a normalized version of X where
%   the mean value of each feature is 0 and the standard deviation
%   is 1. This is often a good preprocessing step to do when
%   working with learning algorithms.
%
% INPUT
%           X:      Matrix [mxn]. Prepared data, features
% OUTPUT   
%          mu:      Scalar [1x1]. Mean's feature
%       sigma:      Scalar [1x1]. STD's feature    
%      X_norm:      Matrix [mx(n-1)]. Normalized features data

% ----------------------------------------------------------------------------------------

    mu      =   mean(X, 1);
    sigma   =   std(X, 1);
    X_norm  =   (X-mu)./sigma;
end