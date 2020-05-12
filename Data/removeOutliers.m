function Data = removeOutliers(Data)


    initialSize         =   length(Data.Y);
    
    % Find and remove oultiers in Y
    [Data.Y, rmInd]     =   rmoutliers(Data.Y, 'quartiles');
    % Remove outliers in X
    Data.X(rmInd, :)    =   [];
    
    finalSize           =   length(Data.Y);
    
    removedPercentage   =   100-(100*finalSize/initialSize);
    
    fprintf('%0.2f %% of data was considered outlier and was removed.\n', removedPercentage);
end