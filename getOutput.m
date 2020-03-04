function getOutput(DATA, CONFIG, result, coeffMean, coeffVar, sqrdErr, coeffMean2, coeffVar2)
% This function applies the regression technique selected in configuration
%
% INPUT
%           DATA:       Struct. Input data
%           CONFIG:     Struct. Configuration parameters
%           result:     ....   
%           
% ----------------------------------------------------------------------------------------
        set(0, 'DefaultLineLineWidth', 1.2);
        
        f1     =   coeffMean(DATA.X);
        figure;
        plot(DATA.X, DATA.Y, '.'); hold on;
        plot(DATA.X, f1, 'r'); hold on;
        plot(DATA.X, coeffMean2(DATA.X), 'm');hold on;
        plot(DATA.X, DATA.MEAN, 'g');
        legend('Random noise', 'Mean estimation', 'Weighted Mean Estimation', 'True mean');
        
        figure;
        plot(coeffVar, DATA.X, sqrdErr); hold on;
        plot(DATA.X, coeffVar2(DATA.X), 'm');hold on;
        plot(DATA.X, DATA.VAR, 'g')
        legend('Squared error', 'Variance estimation', 'Weighted Variance Estimation', 'True variance')
        
        

end
