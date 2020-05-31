function g = activationFunction(z, actFunType)
% ----------------------------------------------------------------------------------------
% This function applies the activation function to input data.
%
% INPUT
%                z:     Vector [nx1]. Weigthed inputs (theta^T)*x
%       actFunType:     String. Type of activation function to be applied
% OUTPUT
%                g:     Vector [nx1]. Output of activation function
%           
% ----------------------------------------------------------------------------------------


    % TODO: implement other activation functions (?)
    switch actFunType
        case 'sigmoid'
            g = sigmoid(z);
        case 'ReLU'
            isPos = (z>0);
            g = z .* isPos;
        otherwise
            error('Invalid activation function');
    end
end
