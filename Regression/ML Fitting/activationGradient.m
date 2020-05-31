function gGrad = activationGradient(z, actFunType)
% ----------------------------------------------------------------------------------------
% This function computes the gradient of the activation function to input data.
%
% INPUT
%                z:     Vector [nx1]. Weigthed inputs (theta^T)*x
%       actFunType:     String. Type of activation function to be applied
% OUTPUT
%            gGrad:     Vector [nx1]. Output of the gradient of the activation function
%           
% ----------------------------------------------------------------------------------------

    % TODO: implement other activation functions (?)
    switch actFunType
        case 'sigmoid'
            gGrad = sigmoid(z) .* (1 - sigmoid(z));
        case 'ReLU'
            gGrad = z > 0;
        otherwise
            error('Invalid activation function');
    end

end