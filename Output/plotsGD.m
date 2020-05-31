function plotsGD(Data, Config, Result)


    disp('========== Fitting results: ==========');
    disp(' >> Mean:');
    disp(Result.GD_Fit.ThetaMean);
    disp(' >> Var:');
    disp(Result.GD_Fit.ThetaVar);
    fprintf(' >> Mean RMSE: %0.4f\n', Result.GD_Fit.MeanRMSE);
    fprintf('---- Prediction RMSE: %0.4f ----\n', Result.GD_Fit.PredRMSE);
    
    figure;
    plot(Result.GD_Fit.CostFunVar);
    xlabel('Iteration'); ylabel('Cost function J(\theta)');
    title('Mean estimation');
    
    figure;
    plot(Result.GD_Fit.CostFunVar);
    xlabel('Iteration'); ylabel('Cost function J(\theta)');
    title('Standard deviation estimation');
    
    %% CDF
    mu      =   mean(Result.GD_Fit.PredError); 
    sigma   =   std(Result.GD_Fit.PredError);
    pd      =   makedist('Normal', 'mu', mu, 'sigma', sigma);
    figure;
    probplot(Result.GD_Fit.PredError, 'noref');
    probplot(gca, pd);
    grid on;
    xlabel('Test prediction error'); ylabel('Probability');
    title(sprintf('Normal Probability Plot. \\mu = %0.2f, \\sigma = %0.2f', mu, sigma));

    %% Surface
    if Config.Data.N_Feat == 2
        figure;
        fcontour(Result.GD_Fit.Fmean, 'Fill', 'on');
        xlim([min(Data.X(:, 1)) max(Data.X(:, 1))]);
        ylim([min(Data.X(:, 2)) max(Data.X(:, 2))]);
        xlabel(strcat(Config.Data.X{1})); 
        ylabel(strcat(Config.Data.X{2}));
        h = colorbar;
        caxis([-5 45]);
        h.Label.Interpreter = 'latex';
        h.Label.FontSize = 14;
        set(get(h,'label'),'string', '$\hat{\mu} (m)$');

        figure;
        fcontour(real(sqrt(Result.GD_Fit.Fvar)), 'Fill', 'on');
        xlim([min(Data.X(:, 1)) max(Data.X(:, 1))]);
        ylim([min(Data.X(:, 2)) max(Data.X(:, 2))]);
        xlabel(strcat(Config.Data.X{1})); 
        ylabel(strcat(Config.Data.X{2}));
        h = colorbar;
        caxis([0 40]);
        h.Label.Interpreter = 'latex';
        h.Label.FontSize = 14;
        set(get(h,'label'),'string', '$\hat{\sigma} (m)$');
    end
end