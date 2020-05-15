function Data = removeOutliers(Data)


    initialSize         =   length(Data.Y);
    
    method = 1;
    
    upperThres = 300;
    lowerThres = -100;
    
    switch method
        case 1 % IQR
            % Find and remove oultiers in Y
            [Data.Y, rmInd]     =   rmoutliers(Data.Y, 'quartiles');
            % Remove outliers in X
            Data.X(rmInd, :)    =   [];
        case 2 % Thresholds
            keepPoints  =   bitand( Data.Y < upperThres,     ...
                                    Data.Y > lowerThres     ...
                                    );
            Data.X      =   Data.X(keepPoints, :);
            Data.Y      =   Data.Y(keepPoints);
    end
    
    finalSize           =   length(Data.Y);
    
    removedPercentage   =   100-(100*finalSize/initialSize);
    
    fprintf('%0.2f %% of data was considered outlier and was removed.\n', removedPercentage);
end