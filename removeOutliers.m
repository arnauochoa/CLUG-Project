function DATA = removeOutliers(DATA, CONFIG)

    keepPoints  =   bitand( DATA.Y < CONFIG.DATA.Y_UPPER_THRESHOLD,     ...
                            DATA.Y > CONFIG.DATA.Y_LOWER_THRESHOLD      ...
                            );
    DATA.X      =   DATA.X(keepPoints);
    DATA.Y      =   DATA.Y(keepPoints);
end