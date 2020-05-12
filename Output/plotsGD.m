function plotsGD(Data, Config, Result)


    disp('========== Fitting results: ==========');
    disp(' >> Mean:');
    disp(Result.GD_Fit.ThetaMean);
    disp(' >> STD:');
    disp(Result.GD_Fit.ThetaStd);
    fprintf(' >> Mean RMSE: %0.4f\n', Result.GD_Fit.MeanRMSE);
    fprintf(' >> STD RMSE: %0.4f\n', Result.GD_Fit.StdRMSE);
    fprintf('---- Prediction RMSE: %0.4f ----\n', Result.GDfit.PredRMSE);

    figure;
    plot(Result.GD_Fit.CostFunStd);
    xlabel('Iteration'); ylabel('Cost function J(\theta)');
    title('Mean estimation');

    figure;
    fcontour(Result.GD_Fit.Fmean, 'Fill', 'on');
    xlim([min(Data.X(:, 1)) max(Data.X(:, 1))]);
    ylim([min(Data.X(:, 2)) max(Data.X(:, 2))]);
    xlabel(strcat(Config.Data.X{1}, ' normalized')); 
    ylabel(strcat(Config.Data.X{2}, ' normalized'));
    h = colorbar;
    h.Label.Interpreter = 'latex';
    h.Label.FontSize = 14;
    set(get(h,'label'),'string', '$\hat{\mu} (m)$');

    figure;
    plot(Result.GD_Fit.CostFunStd);
    xlabel('Iteration'); ylabel('Cost function J(\theta)');
    title('Standard deviation estimation');

    figure;
    fcontour(Result.GD_Fit.Fstd, 'Fill', 'on');
    xlim([min(Data.X(:, 1)) max(Data.X(:, 1))]);
    ylim([min(Data.X(:, 2)) max(Data.X(:, 2))]);
    xlabel(strcat(Config.Data.X{1}, ' normalized')); 
    ylabel(strcat(Config.Data.X{2}, ' normalized'));
    h = colorbar;
    h.Label.Interpreter = 'latex';
    h.Label.FontSize = 14;
    set(get(h,'label'),'string', '$\hat{\sigma} (m)$');
end