function Xres = mapFeatures(X, degree)
% ----------------------------------------------------------------------------------------
% This function returns a matrix containing all the terms composing the
% polynomial model defined by the number of features and the degree of the
% polynomial. 
%
% INPUT
%           X:      Matrix [mxn]. Prepared data, features
%      degree:      Scalar [1x1]. Degree of the polynomial, set in config
% OUTPUT
%        Xres:      Matrix. Contains every term of the polynomial model   

% ----------------------------------------------------------------------------------------

    % Initializations
    [m, n]      =   size(X);
    Xres        =   [];
    for deg = 1:degree
        comb        =   combinator(n, deg, 'c', 'r');
        nComb       =   size(comb, 1);
        % Add columns of quadratic, cubic terms and other powers
        for iComb = 1:nComb
            ind     =   comb(iComb, :);
            Xres    =   [Xres, prod(X(:, ind), 2)];
        end
    end
end