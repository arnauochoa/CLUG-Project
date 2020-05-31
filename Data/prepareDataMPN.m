function prepareDataMPN()

    set(0, 'DefaultLineLineWidth', 2);
    %% Load file
    directory = 'Data/feat_saved.mat';
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
    
    % Train data: 60%
    Data.X      =   DataTmp.X(indices(1:fix(0.6*nExamp)), :);
    Data.Y      =   DataTmp.Y(indices(1:fix(0.6*nExamp)));
    
    % Cross validation data: 20%
    Data.X_Val  =   DataTmp.X(indices(fix(0.6*nExamp)+1 : fix(0.6*nExamp)+fix(0.2*nExamp)), :);
    Data.Y_Val  =   DataTmp.Y(indices(fix(0.6*nExamp)+1 : fix(0.6*nExamp)+fix(0.2*nExamp)));
    
    % Test data: 20%
    Data.X_Test =   DataTmp.X(indices(fix(0.6*nExamp)+fix(0.2*nExamp)+1:end), :);
    Data.Y_Test =   DataTmp.Y(indices(fix(0.6*nExamp)+fix(0.2*nExamp)+1:end));
    
    save('Data/preparedData_MPN', 'Data');
end