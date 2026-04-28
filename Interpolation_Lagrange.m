function yq = Interpolation_Lagrange(x, y, xq)
    % x: vector of known data points
    % y: vector of function values f(x)
    % xq: the point(s) where you want to evaluate the polynomial
    
    n = length(x);
    % L = ones(size(xq)); % Initialize basis polynomials
    yq = zeros(size(xq)); % Initialize final result
    
    for i = 1:n
        % Reset basis polynomial for each i
        li = ones(size(xq));
        for j = 1:n
            if i ~= j
                li = li .* (xq - x(j)) / (x(i) - x(j));
            end
        end
        % Add the contribution of this basis to the total
        yq = yq + y(i) * li;
    end
end