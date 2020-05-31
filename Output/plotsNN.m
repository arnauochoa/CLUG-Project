function plotsNN(Data, Config, Result)
% This function displays the results computed and plots corresponding to 
% Neural Network Regression: Multipath error estimation.
%
% INPUT
%           Data:       Struct. Prepared data
%           Config:     Struct. Configuration parameters
%           Result:     Struct. Results obtained from regression   
%           
% ----------------------------------------------------------------------------------------


    fprintf('---- Prediction RMSE: %0.4f ----\n', Result.MLFit.PredRMSE);

    %% CDF
    mu      =   mean(Result.MLFit.PredError); 
    sigma   =   std(Result.MLFit.PredError);
    pd      =   makedist('Normal', 'mu', mu, 'sigma', sigma);
    figure;
    probplot(Result.MLFit.PredError, 'noref');
    probplot(gca, pd);
    grid on;
    xlabel('Test prediction error'); ylabel('Probability');
    title(sprintf('Normal Probability Plot. \\mu = %0.2f, \\sigma = %0.2f', mu, sigma));
    
end