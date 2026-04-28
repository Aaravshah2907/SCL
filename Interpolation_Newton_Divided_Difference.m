function yq = Interpolation_Newton_Divided_Difference(x, y, xq)
    n = length(x);
    % 1. Initialize the divided difference table
    F = zeros(n, n);
    F(:,1) = y(:); % First column is just the y values
    
    % 2. Fill the table
    for j = 2:n
        for i = 1:n-j+1
            F(i,j) = (F(i+1,j-1) - F(i,j-1)) / (x(i+j-1) - x(i));
        end
    end
    
    % The coefficients are the top row of the table
    coeffs = F(1,:);
    
    % 3. Evaluate the polynomial at xq using Nested Multiplication (Horner-like)
    yq = coeffs(n) * ones(size(xq));
    for i = n-1:-1:1
        yq = coeffs(i) + (xq - x(i)) .* yq;
    end
end