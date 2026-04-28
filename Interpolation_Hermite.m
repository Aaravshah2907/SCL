function yq = Interpolation_Hermite(x, y, dy, xq)
    % x: independent points
    % y: function values f(x)
    % dy: derivative values f'(x)
    % xq: query points
    
    n = length(x);
    z = zeros(1, 2*n);
    Q = zeros(2*n, 2*n);
    
    % 1. Populate the doubled x-values and first column of Table
    for i = 1:n
        z(2*i-1) = x(i);
        z(2*i)   = x(i);
        Q(2*i-1, 1) = y(i);
        Q(2*i, 1)   = y(i);
        
        % 2. Use the given derivative for the "0/0" cases
        Q(2*i, 2) = dy(i);
        if i > 1
            % Standard divided difference for different x-values
            Q(2*i-1, 2) = (Q(2*i-1, 1) - Q(2*i-2, 1)) / (z(2*i-1) - z(2*i-2));
        end
    end
    
    % 3. Complete the Divided Difference Table
    for j = 3:2*n
        for i = j:2*n
            Q(i, j) = (Q(i, j-1) - Q(i-1, j-1)) / (z(i) - z(i-j+1));
        end
    end
    
    % 4. Evaluate using Newton Form (Horner's Method)
    coeffs = diag(Q); 
    yq = coeffs(2*n) * ones(size(xq));
    for i = 2*n-1:-1:1
        yq = coeffs(i) + (xq - z(i)) .* yq;
    end
end