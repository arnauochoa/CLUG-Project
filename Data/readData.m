function [Data] = readData(Config)
% ----------------------------------------------------------------------------------------
% This function reads the data from data mat file.
%
% INPUT
%           Config:     Struct. Configuration parameters
%
% OUTPUT
%           Data:       Struct. Original data
%
% ----------------------------------------------------------------------------------------
    switch Config.Data.Type
        case 1
            load('Data/testData.mat');

            Data.X{1}   =   x';
            Data.Y      =   y';
            Data.Mean   =   trueMean';
            Data.Var    =   trueVar';
        case 2
            % Only load data if it is not already loaded.
            if ~exist('Data','var')
                load(Config.Data.FileName, 'Data');
            end
            
            % Keep selected columns of X
            if isfield(Config.Data, 'ColIndices')
                Data.X      =   Data.X(:, Config.Data.ColIndices);
                Data.X_Val  =   Data.X_Val(:, Config.Data.ColIndices);
                Data.X_Test =   Data.X_Test(:, Config.Data.ColIndices);
            end
    end
end