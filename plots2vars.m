function plots2vars(DATA, CONFIG, RESULT)
    
    N = length(DATA.Y);
    
    %% MEAN FITTING
    edgesX1 = floor(min(DATA.X(:,1))):1:ceil(max(DATA.X(:,1)));
    edgesX2 = floor(min(DATA.X(:,2))):1:ceil(max(DATA.X(:,2)));
    x1Disc = edgesX1(discretize(DATA.X(:,1), edgesX1));
    x2Disc = edgesX2(discretize(DATA.X(:,2), edgesX2));
    uniqueX1 = unique(x1Disc);
    uniqueX2 = unique(x2Disc);
    
    [X,Y] = meshgrid(uniqueX1,uniqueX2);
    C=cat(2,X',Y');
    D=reshape(C,[],2);
    
    numPointsX = nan(length(D), 1);
    for i = 1:length(D)
        tmp = sum(bitand(x1Disc == D(i, 1), x2Disc == D(i, 2)));
        if tmp > 0
            numPointsX(i) = 100*tmp/N;
        end
    end
    
    Z = griddata(D(:,1),D(:,2),numPointsX,X,Y);
    
    figure;
    surf(X, Y, Z);
    xlabel(CONFIG.DATA.X{1}); ylabel(CONFIG.DATA.X{2}); zlabel('Number of points (%)');
    colorbar;
    title('Distribution of points');
    
    figure;
    contourf(X, Y, Z);
    xlabel(CONFIG.DATA.X{1}); ylabel(CONFIG.DATA.X{2});
    h = colorbar;
    set(get(h,'label'),'string','Number of points (%)');
    title('Distribution of points');
    
    figure;
    ph = plot(RESULT.coeffMean, 'Style', 'Contour');
    set(ph, 'Fill', 'on', 'LineColor', 'auto');
    grid off;
    xlabel(CONFIG.DATA.X{1}); ylabel(CONFIG.DATA.X{2});
    h = colorbar;
    h.Label.Interpreter = 'latex';
    h.Label.FontSize = 14;
    set(get(h,'label'),'string', '$\hat{\mu} (m)$');
    title('Fitting of the mean');
    
    figure;
    ph = plot(RESULT.coeffMeanW, 'Style', 'Contour');
    set(ph, 'Fill', 'on', 'LineColor', 'auto');
    grid off;
    xlabel(CONFIG.DATA.X{1}); ylabel(CONFIG.DATA.X{2});
    h = colorbar;
    h.Label.Interpreter = 'latex';
    h.Label.FontSize = 14;
    set(get(h,'label'),'string', '$\hat{\mu} (m)$');
    title('Fitting of the mean (Weighted)');
    
    figure;
    ph = plot(RESULT.coeffStd, 'Style', 'Contour');
    set(ph, 'Fill', 'on', 'LineColor', 'auto');
    grid off;
    xlabel(CONFIG.DATA.X{1}); ylabel(CONFIG.DATA.X{2}); 
    h = colorbar;
    h.Label.Interpreter = 'latex';
    h.Label.FontSize = 14;
    set(get(h,'label'),'string', '$\hat{\sigma} (m)$');
    title('Fitting of the \sigma');
    
    figure;
    ph = plot(RESULT.coeffStdW, 'Style', 'Contour');
    set(ph, 'Fill', 'on', 'LineColor', 'auto');
    grid off;
    xlabel(CONFIG.DATA.X{1}); ylabel(CONFIG.DATA.X{2});
    h = colorbar;
    h.Label.Interpreter = 'latex';
    h.Label.FontSize = 14;
    set(get(h,'label'),'string', '$\hat{\sigma} (m)$');
    title('Fitting of the \sigma (Weighted)');
end