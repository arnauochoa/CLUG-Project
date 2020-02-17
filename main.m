function main()
% ----------------------------------------------------------------------------------------
% Main function that reads data, sets parameters and computes regression
% ----------------------------------------------------------------------------------------

    %% GETTING DATA
    filename    =   'data.mat';
    DATA        =   readData(filename);
    
    %% GETTING CONFIG
    CONFIG      =   getConfig();
    
    %% OBTAINIG REGRESSION
    [result, coeff, coeffVar, coeffVar2]     =   regression(DATA, CONFIG);
    
    %% GETTING OUTPUT AND PLOTS
    getOutput(DATA, CONFIG, result, coeff, coeffVar, coeffVar2);

end