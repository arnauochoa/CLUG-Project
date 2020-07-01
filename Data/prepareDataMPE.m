function prepareDataMPE()
% ----------------------------------------------------------------------------------------
% This function reads Multipath error and other input features data from an extenal
% directory, removes outliers and invalid data and separates data. 
%
% OUTPUT
%           preparedData_MPN:     Struct. Prepared data
%
% ----------------------------------------------------------------------------------------
    saveDirectory   =    'Data/preparedData_MPE_51119';
    
    %% Load file
    directory = 'Data/feat_saved_51119.mat';
    load(directory, 'feat', 'colnames');

    if ~( exist('feat','var') && exist('colnames','var') )
        error('Some variable(s) do not exist');
    end
    
    %% Initializations
    [col, ~] = col_feat();

    %% Remove invalid values
    % Remove nan values
    feat(any(isnan(feat) , 2), :) = [];
    
    % Assign independent and dependent variables
    DataTmp.X   =   feat(:, 2:end);
    DataTmp.Y   =   feat(:, 1);
    
    % Remove SNR = 0
    removeInd   =   DataTmp.X(:, col.s) == 0;
    DataTmp.X(removeInd,:) = [];
    DataTmp.Y(removeInd) = [];
    
    % Remove outliers 
    DataTmp     =   removeOutliers(DataTmp);
    
    nExamp      =   length(DataTmp.Y);
    
    %% Split Data: Train and Test
    indices     =   randperm(nExamp); % Used to split data randomly
    
    % Train data: 90%
    Data.X      =   DataTmp.X(indices(1:fix(0.9*nExamp)), :);
    Data.Y      =   DataTmp.Y(indices(1:fix(0.9*nExamp)));
    
    % Cross validation data: 5%
    Data.X_Val  =   DataTmp.X(indices(fix(0.9*nExamp)+1 : fix(0.9*nExamp)+fix(0.05*nExamp)), :);
    Data.Y_Val  =   DataTmp.Y(indices(fix(0.9*nExamp)+1 : fix(0.9*nExamp)+fix(0.05*nExamp)));
    
    % Test data: 5%
    Data.X_Test =   DataTmp.X(indices(fix(0.9*nExamp)+fix(0.05*nExamp)+1:end), :);
    Data.Y_Test =   DataTmp.Y(indices(fix(0.9*nExamp)+fix(0.05*nExamp)+1:end));
    
    save(saveDirectory, 'Data');
end