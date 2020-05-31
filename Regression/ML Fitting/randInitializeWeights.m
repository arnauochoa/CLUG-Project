function [W] = randInitializeWeights(inSize, outSize)
% ----------------------------------------------------------------------------------------
% This function initializes model coefficients (theta parameters) randomly.
%
% INPUT
%        inSize:      Scalar [1x1]. Number of features
%       outSize:      Scalar [1x1]. Hidden layer size
% OUTPUT
%             W:      Matrix [outSizex(inSize+1)]. Weights assigned to
%             input values. 

% ----------------------------------------------------------------------------------------

epsilonInit = sqrt(6/(inSize + outSize));
W = rand(outSize, 1 + inSize) * 2 * epsilonInit - epsilonInit;

end