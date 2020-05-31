function h2 = nnPredict(Theta1, Theta2, X, actFunType)
% ----------------------------------------------------------------------------------------
% This function performs forward propagation of Neural Network regression.
%
% INPUT
%                Theta1:      Vector [nFeat x 1]. Theta parameters for computation of first activation
%                             function
%                Theta2:      Vector [nFeat x 1]. Theta parameters for computation of second activation
%                             function
%                     X:      Matrix [nExamp x nFeat]. Training dataset of features
%            actFunType:      String. Type of activation function to be applied
% OUTPUT
%                    h2:      Vector [nExamp x 1]. Output of last
%                             activation function computation. 

% ---------------------------------------------------------------------------------------
m = size(X, 1);

z1 = [ones(m, 1) X] * Theta1';
h1 = activationFunction(z1, actFunType);
z2 = [ones(m, 1) h1] * Theta2';
h2 = activationFunction(z2, actFunType);

end