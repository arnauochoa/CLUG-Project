function [Result] = mlFitting(Data, Config)




    [thetaMean, muMean, sigmaMean, J_historyMean, errorMean] = gradientDescent(Data.X, Data.Y, Config);
    figure;
    plot(J_historyMean);
    xlabel('Iteration'); ylabel('Cost function J(\theta)');
    title('Mean estimation');
    
    f = @(x, y) thetaMean(1) + thetaMean(2)*x + thetaMean(3)*y + thetaMean(4)*x^2 + thetaMean(5)*x*y + thetaMean(6)*y^2;
    figure;
    fcontour(f, 'Fill', 'on');
    xlabel(strcat(Config.Data.X{1}, ' normalized')); ylabel(strcat(Config.Data.X{2}, ' normalized'));
    h = colorbar;
    h.Label.Interpreter = 'latex';
    h.Label.FontSize = 14;
    set(get(h,'label'),'string', '$\hat{\mu} (m)$');
    
    
    [thetaStd, muStd, sigmaStd, J_historyStd, errorStd] = gradientDescent(Data.X, abs(errorMean), Config);
    figure;
    plot(J_historyStd);
    xlabel('Iteration'); ylabel('Cost function J(\theta)');
    title('Standard deviation estimation');
    
    f = @(x, y) thetaStd(1) + thetaStd(2)*x + thetaStd(3)*y + thetaStd(4)*x^2 + thetaStd(5)*x*y + thetaStd(6)*y^2;
    figure;
    fcontour(f, 'Fill', 'on');
    xlabel(strcat(Config.Data.X{1}, ' normalized')); ylabel(strcat(Config.Data.X{2}, ' normalized'));
    h = colorbar;
    h.Label.Interpreter = 'latex';
    h.Label.FontSize = 14;
    set(get(h,'label'),'string', '$\hat{\sigma} (m)$');
    
end