function prepareData()
    directory = '../PR_data/';
    AllFiles = dir([directory '*.mat']);
    for f = 1:length(AllFiles)
        load([directory AllFiles(f).name]);
    end

    if ~(   exist('CN0_joint','var')       &&     ...
            exist('EL_joint','var')        &&     ...
            exist('res_joint','var')               ...
        )

        error('Some variable(s) do not exist');
    end

    %% Remove invalid values
    index_data = CN0_joint == 0 | isnan(res_joint);
    data_temp = res_joint; data_temp(index_data) = NaN;
    alldata_pre = data_temp(:);
    data_temp = EL_joint; data_temp(index_data) = NaN;
    alldata_el = data_temp(:);
    data_temp = CN0_joint; data_temp(index_data) = NaN;
    alldata_cn0 = data_temp(:);

    cleandata = bitand(alldata_cn0 ~= 0, ~isnan(alldata_pre));
    cleandata = bitand(cleandata, ~isnan(alldata_cn0));

    alldata_cn0_clean = alldata_cn0(cleandata);
    alldata_el_clean  = rad2deg(alldata_el(cleandata));
    alldata_pre_clean = alldata_pre(cleandata);
    
    %% Assign independent and dependent variables
    DataTmp.X   =   [alldata_cn0_clean, alldata_el_clean];
    DataTmp.Y   =   alldata_pre_clean;
    
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
    
    save('Data/preparedData_thres', 'Data');
end