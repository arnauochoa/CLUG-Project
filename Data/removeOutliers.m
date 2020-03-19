function Data = removeOutliers(Data, Config)

    keepPoints  =   bitand( Data.Y < Config.Data.Y_Upper_Threshold,     ...
                            Data.Y > Config.Data.Y_Lower_Threshold      ...
                            );
    
    Data.X      =   Data.X(keepPoints, :);
    Data.Y      =   Data.Y(keepPoints);
end