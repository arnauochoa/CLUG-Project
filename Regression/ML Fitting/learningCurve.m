function [lambda] = learningCurve(XTrain, yTrain, XVal, yVal, Config, hlSize, initialParams)




%% Initializations
[nExamp, nFeat] = size(XTrain);
lambdaVals      = [0.01 0.03 0.1 0.3 1 3 10 30]; % Values of lambda to test
MSELambda       = zeros(length(lambdaVals), 1);

%% Find best configuration
parfor i = 1:length(lambdaVals)
    fprintf('--- Lambda = %f ---\n', lambdaVals(i));
    % Train Neural Network with i-th lambda
    [Theta1, Theta2, ~] = trainNN(  hlSize,             ...
                                    XTrain,             ...
                                    yTrain,             ...
                                    lambdaVals(i),      ...
                                    Config,             ...
                                    initialParams);
    
    predictions     =   nnPredict(Theta1, Theta2, XVal, Config.Regression.ML.ActivationFun);
    MSELambda(i)          =   mean((predictions - yVal).^2);
end

% Get best lambda
[minMSE, minInd] = min(MSELambda);
lambda = lambdaVals(minInd);

figure;
plot(lambdaVals, MSELambda);
xlabel('lambda'); ylabel('Mean Squared Error');
title(sprintf('Best lambda = %f. MSE = %f', lambda, minMSE));

%% Check over/underfitting
sizes = 100:100:nExamp;
MSETrain        = zeros(length(sizes), 1);
MSEVal          = zeros(length(sizes), 1);
parfor i = 1:length(sizes)
    m = sizes(i);
    fprintf('--- Size = %d/%d ---\n', m, nExamp);
    % Train Neural Network with m examples
    [Theta1, Theta2, ~] = trainNN(  hlSize,             ...
                                    XTrain(1:m, :),     ...
                                    yTrain(1:m),        ...
                                    lambda,             ...
                                    Config,             ...
                                    initialParams);
    
    % Error in training examples
    predictions     =   nnPredict(Theta1, Theta2, XTrain(1:m, :), Config.Regression.ML.ActivationFun);
    MSETrain(i)     =   mean((predictions - yTrain(1:m)).^2);
    
    % Error in cross-validation examples
    predictions     =   nnPredict(Theta1, Theta2, XVal, Config.Regression.ML.ActivationFun);
    MSEVal(i)       =   mean((predictions - yVal).^2);
end
figure;
plot(sizes, MSETrain); hold on;
plot(sizes, MSEVal);
xlabel('Training size'); ylabel('Mean Squared Error');
legend('Training', 'Cross-Validation');


end