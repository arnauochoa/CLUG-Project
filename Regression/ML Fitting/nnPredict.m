function h2 = nnPredict(Theta1, Theta2, X, actFunType)

m = size(X, 1);

z1 = [ones(m, 1) X] * Theta1';
h1 = activationFunction(z1, actFunType);
z2 = [ones(m, 1) h1] * Theta2';
h2 = activationFunction(z2, actFunType);

end