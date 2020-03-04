function getOutput(DATA, CONFIG, RESULT)
% This function applies the regression technique selected in configuration
%
% INPUT
%           DATA:       Struct. Input data
%           CONFIG:     Struct. Configuration parameters
%           result:     ....   
%           
% ----------------------------------------------------------------------------------------
        set(0, 'DefaultLineLineWidth', 1.5);
        
        switch CONFIG.DATA.TYPE
            case 1
                figure;
                plot(DATA.X, DATA.Y, '.');          hold on;
                plot(RESULT.coeffMean, 'r');        hold on;
                plot(RESULT.coeffMeanW, 'c');       hold on;
                plot(DATA.X, DATA.MEAN, 'g');
                legend('Data', 'Mean estimation', 'Weighted Mean Estimation', 'True mean');

                figure;
                plot(DATA.X, RESULT.sqrdErr, '.');  hold on;
                plot(RESULT.coeffVar, 'r');         hold on;
                plot(RESULT.coeffVarW, 'c');        hold on;
                plot(DATA.X, DATA.VAR, 'g')
                legend('Squared error', 'Variance estimation', 'Weighted Variance Estimation', 'True variance')
            case 2
                figure;
                plot(DATA.X, DATA.Y, '.');          hold on;
                plot(RESULT.coeffMean, 'r');        hold on;
                plot(RESULT.coeffMeanW, 'c');       hold on;
                xlabel(CONFIG.DATA.X); ylabel(CONFIG.DATA.Y);
                legend('Data', 'Mean estimation', 'Weighted Mean Estimation');

                figure;
                plot(DATA.X, RESULT.sqrdErr, '.');  hold on;
                plot(RESULT.coeffVar, 'r');         hold on;
                plot(RESULT.coeffVarW, 'c');        hold on;
                xlabel(CONFIG.DATA.X); ylabel('Squared error');
                legend('Squared error', 'Variance estimation', 'Weighted Variance Estimation')
        end
end
