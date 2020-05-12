function g = activationFunction(z, actFunType)



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
