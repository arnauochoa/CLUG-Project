function plotsNN(Data, Config, Result)


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