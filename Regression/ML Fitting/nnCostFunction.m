function [J, grad] = nnCostFunction(params, hiddenLayerSize, X, y, lambda, actFunType)
% ----------------------------------------------------------------------------------------
% This function computes the cost function and its gradient for the Neural Network
% regression.
%
% INPUT
%                params:      Function variable. Cost function as a function of theta parameters.
%       hiddenLayerSize:      Scalar [1x1]. Hidden layer size
%                     X:      Matrix [nExamp x nFeat]. Training dataset of features
%                     y:      Vector [nExamp x 1]. Training dataset of MP error
%                lambda:      Scalar [1x1]. Regularization paramete
%            actFunType:      String. Type of activation function to be applied
% OUTPUT
%                     J:      Scalar [1x1]. Computed cost function as a
%                             function of theta
%                  grad:      Matrix. Gradient of cost function J

% ---------------------------------------------------------------------------------------

    [nExamp, nFeat]  =   size(X);
    % Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
    % for our 2 layer neural network
    Theta1 = reshape(params(1:hiddenLayerSize * (nFeat + 1)), ...
                     hiddenLayerSize, (nFeat + 1));

    Theta2 = reshape(params((1 + (hiddenLayerSize * (nFeat + 1))):end), ...
                     1, (hiddenLayerSize + 1));
                 
     % Initializations
    J       =   0;
    Theta1grad = zeros(size(Theta1));
    Theta2grad = zeros(size(Theta2));

    
    parfor i = 1:nExamp
        % Feed forward to return the cost J
        a1  =   [1; X(i, :)'];
        z2  =   Theta1 * a1;
        a2  =   activationFunction(z2, actFunType);
        a2  =   [1; a2];
        z3  =   Theta2 * a2;
        a3  =   z3;             % TODO: check if we should apply some act fun

        J   =   J + 1/(2*nExamp) * (a3 - y(i))^2;
        
        % Backpropagation to compute the gradients
        d3  =   a3 - y(i);      % Error at hidden layer
        d2  =   Theta2(:, 2:end)' * d3 .* activationGradient(z2, actFunType);
        % Accumulate gradient
        Theta1grad = Theta1grad + d2 * a1';
        Theta2grad = Theta2grad + d3 * a2';
    end
    
    % Regularization
    J = J + (lambda/(2*nExamp)) * (sum(sum(Theta1(:, 2:end).^2)) + sum(sum(Theta2(:, 2:end).^2)));
    
    Theta1grad(:, 1)       = (1/nExamp) .* Theta1grad(:, 1);
    Theta1grad(:, 2:end)   = (1/nExamp) .* Theta1grad(:, 2:end) + (lambda/nExamp) .* Theta1(:, 2:end);
    Theta2grad(:, 1)       = (1/nExamp) .* Theta2grad(:, 1);
    Theta2grad(:, 2:end)   = (1/nExamp) .* Theta2grad(:, 2:end) + (lambda/nExamp) .* Theta2(:, 2:end);
    
    % Unroll theta
    grad = [Theta1grad(:) ; Theta2grad(:)];
end