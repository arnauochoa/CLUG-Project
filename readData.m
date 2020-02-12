function [DATA] = readData(filename)
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
    load(filename);
    
    if ~(exist('x','var') && exist('y','var'))
        error('Variables x and/or y do not exist');
    end
    DATA.X = x;
    DATA.Y = y;
end