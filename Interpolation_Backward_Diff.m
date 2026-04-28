function yq = Interpolation_Backward_Diff(x, y, xq)
    n = length(x);
    h = x(2) - x(1);
    p = (xq - x(n)) / h;
    
    % Build Backward Difference Table (Bottom-up logic)
    diffs = zeros(n, n);
    diffs(:, 1) = y(:);
    for j = 2:n
        for i = n:-1:j
            diffs(i, j) = diffs(i, j-1) - diffs(i-1, j-1);
        end
    end
    
    % Evaluate using the last row: diffs(n, :)
    yq = diffs(n, 1);
    term = 1;
    for j = 1:n-1
        term = term .* (p + j - 1) / j;
        yq = yq + term * diffs(n, j+1);
    end
end