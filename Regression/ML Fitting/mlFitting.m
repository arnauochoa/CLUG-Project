function [Result] = mlFitting(Data, Config)





%% Prepare data
% Normalize features
[X_train_norm, muTrain, sigmaTrain] = featureNormalize(Data.X);
X_val_norm      =   (Data.X_Val - muTrain) ./ sigmaTrain;
X_test_norm     =   (Data.X_Test - muTrain) ./ sigmaTrain;
% Add polynomial terms
X_train_norm    =   mapFeatures(X_train_norm, Config.Regression.ML.Deg);
X_val_norm      =   mapFeatures(X_val_norm, Config.Regression.ML.Deg);
X_test_norm     =   mapFeatures(X_test_norm, Config.Regression.ML.Deg);


%% Initializations
% Initialize parallel pool w/ default config. If no parallel pool exists,
% gcp starts a new one
gcp();

[nExamp, nFeat]  = size(X_train_norm);

% Set size of hidden layer depending on configuration
if Config.Regression.ML.HiddenLayerSize == 0
    hlSize = nFeat; 
else
    hlSize = Config.Regression.ML.HiddenLayerSize;
end


%% Initialize parameters
initialTheta1 = randInitializeWeights(nFeat, hlSize);
initialTheta2 = randInitializeWeights(hlSize, 1);
% Unroll parameters
initialParams = [initialTheta1(:) ; initialTheta2(:)];


%% Gradient checking: Check that backprop is computing gradient correctly
% This section is used for test purposes only
% checkGradients(nFeat, nFeat, lambda);
% fprintf('Program paused. Press enter to continue.\n');
% pause;

%% Learning curves: Find best configuration and check overfitting
tic
lambda = learningCurve( X_train_norm,                       ...
                        Data.Y,                             ...
                        X_val_norm,                         ...
                        Data.Y_Val,                         ...
                        Config,                             ...
                        hlSize,                             ...
                        initialParams);
toc
% fprintf('Program paused. Press enter to continue.\n');
% pause;


%% Training: Minimizing cost function
tic
% Minimize cost function
[Result.Theta1, Result.Theta2, Result.cost] = trainNN(  hlSize,         ...
                                X_train_norm,                           ...
                                Data.Y,                                 ...
                                lambda,                                 ...
                                Config,                                 ...
                                initialParams);
toc


figure;         
plot(Result.cost);
xlabel('Iteration'); ylabel('Cost');

%% Prediction with test data
predictions     =   nnPredict(  Result.Theta1,  ...
                                Result.Theta2,  ...
                                X_test_norm,    ...
                                Config.Regression.ML.ActivationFun);
Result.MLFit.PredError =   Data.Y_Test - predictions;
Result.MLFit.PredRMSE =   sqrt(mean((Data.Y_Test - predictions).^2));
end