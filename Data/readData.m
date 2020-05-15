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
    end
end