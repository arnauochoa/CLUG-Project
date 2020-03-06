function [DATA] = readData(CONFIG)
% ----------------------------------------------------------------------------------------
% This function reads the data from data mat file
%
% INPUT
%           filename:   String. Name of the file
%
% OUTPUT
%           DATA:       Struct. Original data
%
% ----------------------------------------------------------------------------------------
    switch CONFIG.DATA.TYPE
        case 1
            load('data.mat');

            DATA.X      =   x';
            DATA.Y      =   y';
            DATA.MEAN   =   trueMean';
            DATA.VAR    =   trueVar';
        case 2
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
            alldata_pre_clean = alldata_pre(cleandata);
            alldata_el_clean  = rad2deg(alldata_el(cleandata));
            
            switch CONFIG.DATA.X
                case 'Elevation',   DATA.X      =   alldata_el_clean;
                case 'PR error',    DATA.X      =   alldata_pre_clean;
                case 'CN0',         DATA.X      =   alldata_cn0_clean;
            end
            switch CONFIG.DATA.Y
                case 'Elevation',   DATA.Y      =   alldata_el_clean;
                case 'PR error',    DATA.Y      =   alldata_pre_clean;
                case 'CN0',         DATA.Y      =   alldata_cn0_clean;
            end
    end
end