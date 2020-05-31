function checkGradients(n, hiddenLayerSize, lambda)
%CHECKNNGRADIENTS Creates a small neural network to check the
%backpropagation gradients
%   CHECKNNGRADIENTS(lambda) Creates a small neural network to check the
%   backpropagation gradients, it will output the analytical gradients
%   produced by your backprop code and the numerical gradients (computed
%   using computeNumericalGradient). These two gradient computations should
%   result in very similar values.
%
% INPUT
%                n:     Scalar [1x1]. Number of features
%  hiddenLayerSize:     Scalar [1x1]. Size of the hidden layer
%           lambda:     Scalar [1x1]. Regularization parameter

% ----------------------------------------------------------------------------------------

if ~exist('lambda', 'var') || isempty(lambda)
    lambda = 0;
end

m = 5;

% We generate some 'random' test data
Theta1 = debugInitializeWeights(hiddenLayerSize, n);
Theta2 = debugInitializeWeights(1, hiddenLayerSize);
% Reusing debugInitializeWeights to generate X
X  = debugInitializeWeights(m, n - 1);
y  = 1 + mod(1:m, 1)';

% Unroll parameters
nn_params = [Theta1(:) ; Theta2(:)];

% Short hand for cost function
costFunction = @(params) nnCostFunction(params,             ...
                                        n,                  ...
                                        hlSize,             ...
                                        XTrain,             ...
                                        yTrain,             ...
                                        lambda,             ...
                                        Config.Regression.ML.ActivationFun);

[~, grad] = costFunction(nn_params);
numgrad = computeNumericalGradient(costFunction, nn_params);

% Visually examine the two gradient computations.  The two columns
% you get should be very similar. 
disp([numgrad grad]);
fprintf(['The above two columns you get should be very similar.\n' ...
         '(Right-Your Numerical Gradient, Left-Analytical Gradient)\n\n']);

% Evaluate the norm of the difference between two solutions.  
% If you have a correct implementation, and assuming you used EPSILON = 0.0001 
% in computeNumericalGradient.m, then diff below should be less than 1e-9
diff = norm(numgrad-grad)/norm(numgrad+grad);

fprintf(['If your backpropagation implementation is correct, then \n' ...
         'the relative difference will be small (less than 1e-9). \n' ...
         '\nRelative Difference: %g\n'], diff);

end
