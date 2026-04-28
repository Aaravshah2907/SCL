function yq = Interpolation_Forward_Diff(x, y, xq)
    n = length(x);
    h = x(2) - x(1); % Step size
    p = (xq - x(1)) / h;
    
    % Build Forward Difference Table
    diffs = zeros(n, n);
    diffs(:, 1) = y(:);
    for j = 2:n
        for i = 1:n-j+1
            diffs(i, j) = diffs(i+1, j-1) - diffs(i, j-1);
        end
    end
    
    % Evaluate using the top row: diffs(1, :)
    yq = diffs(1, 1);
    term = 1;
    for j = 1:n-1
        term = term .* (p - j + 1) / j;
        yq = yq + term * diffs(1, j+1);
    end
end