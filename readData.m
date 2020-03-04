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
    
    if ~(   exist('x','var')         &&     ...
            exist('y','var')         &&     ...
            exist('trueMean', 'var') &&     ...
            exist('trueVar', 'var')         ...
        )
        
        error('Variables x, y do not exist');
    end
    DATA.X      =   x;
    DATA.Y      =   y;
    DATA.MEAN   =   trueMean;
    DATA.VAR    =   trueVar;
end