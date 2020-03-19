function [Data] = readData(Config)
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
    switch Config.Data.Type
        case 1
            load('Data/data.mat');

            Data.X{1}     =   x';
            Data.Y      =   y';
            Data.Mean   =   trueMean';
            Data.Var    =   trueVar';
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
            
            nPts    =   length(alldata_cn0_clean);
            Data.X  =   nan(nPts, Config.Data.N_Vars);
            for i = 1:Config.Data.N_Vars
                switch Config.Data.X{i}
                    case 'Elevation',   Data.X(:, i)  =   alldata_el_clean;
                    case 'PR error',    Data.X(:, i)  =   alldata_pre_clean;
                    case 'CN0',         Data.X(:, i)  =   alldata_cn0_clean;
                end
            end
            switch Config.Data.Y
                case 'Elevation',   Data.Y      =   alldata_el_clean;
                case 'PR error',    Data.Y      =   alldata_pre_clean;
                case 'CN0',         Data.Y      =   alldata_cn0_clean;
            end
    end
end