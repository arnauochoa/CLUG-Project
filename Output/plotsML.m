function plotsML(Data, Config, Result)


    disp('========== Fitting results: ==========');
    disp(' >> Mean:');
    disp(Result.MLfit.thetaMean);
    disp(' >> STD:');
    disp(Result.MLfit.thetaStd);
    disp(' >> Mean RMSE:');
    disp(Result.MLfit.meanRMSE);
    disp(' >> STD RMSE:');
    disp(Result.MLfit.stdRMSE);

    figure;
    plot(Result.MLfit.J_historyMean);
    xlabel('Iteration'); ylabel('Cost function J(\theta)');
    title('Mean estimation');

    figure;
    fcontour(Result.MLfit.fmean, 'Fill', 'on');
    xlim([min(Result.MLfit.X_norm(:, 1)) max(Result.MLfit.X_norm(:, 1))]);
    ylim([min(Result.MLfit.X_norm(:, 2)) max(Result.MLfit.X_norm(:, 2))]);
    xlabel(strcat(Config.Data.X{1}, ' normalized')); 
    ylabel(strcat(Config.Data.X{2}, ' normalized'));
    h = colorbar;
    h.Label.Interpreter = 'latex';
    h.Label.FontSize = 14;
    set(get(h,'label'),'string', '$\hat{\mu} (m)$');

    figure;
    plot(Result.MLfit.J_historyStd);
    xlabel('Iteration'); ylabel('Cost function J(\theta)');
    title('Standard deviation estimation');

    figure;
    fcontour(Result.MLfit.fstd, 'Fill', 'on');
    xlim([min(Result.MLfit.X_norm(:, 1)) max(Result.MLfit.X_norm(:, 1))]);
    ylim([min(Result.MLfit.X_norm(:, 2)) max(Result.MLfit.X_norm(:, 2))]);
    xlabel(strcat(Config.Data.X{1}, ' normalized')); 
    ylabel(strcat(Config.Data.X{2}, ' normalized'));
    h = colorbar;
    h.Label.Interpreter = 'latex';
    h.Label.FontSize = 14;
    set(get(h,'label'),'string', '$\hat{\sigma} (m)$');
end