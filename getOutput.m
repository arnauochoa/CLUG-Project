function getOutput(DATA, CONFIG, result, coeff)
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
        
        % TODO

end
