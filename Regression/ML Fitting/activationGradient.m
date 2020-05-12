function gGrad = activationGradient(z, actFunType)


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