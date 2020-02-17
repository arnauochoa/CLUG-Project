function getOutput(DATA, CONFIG, result, coeff, coeffVar, coeffVar2)
% This function applies the regression technique selected in configuration
%
% INPUT
%           DATA:       Struct. Input data
%           CONFIG:     Struct. Configuration parameters
%           result:     ....   
%           
% ----------------------------------------------------------------------------------------
        
        f1 = polyval(coeff, DATA.X);
        plot(DATA.X, DATA.Y, '.'); hold on;
        plot(DATA.X, f1);
        legend('Random noise', 'Fitting Curve');
        
        figure;
        f2 = polyval(coeffVar, DATA.X);
        plot(DATA.X, DATA.Y2, '.'); hold on;
        plot(DATA.X, f2);       
        plot(coeffVar2,'g-')
        legend('\sigma^2', 'Fitting Curve poly','Fitting Curve exp')
        
        
        
        % TODO

end
