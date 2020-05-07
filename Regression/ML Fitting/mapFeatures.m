function Xres = mapFeatures(X, degree)

    [m, n]      =   size(X);
    % Add intercept term to X
    Xres        =   ones(m, 1);
    for deg = 1:degree
        comb        =   combinator(n, deg, 'c', 'r');
        nComb       =   size(comb, 1);
        % Add columns of quadratic, cubic terms and other powers
        for iComb = 1:nComb
            ind     =   comb(iComb, :);
            Xres    =   [Xres, prod(X(:, ind), 2)];
        end
    end
end