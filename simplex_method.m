function [x_opt, z_opt, table] = simplex_method(A, b, c)
    % What we want to Maximize:
    % Z = cx
    % Subject to the conditions : 
    % Ax <= b; 
    % x >= 0
    
    [m,n] = size(A);

    % S1 : Add Slack Variables
    I = eye(m);
    A_aug = [A I];

    % Cost Vector
    Cost_vector_aug = [c ; zeros(m,1)];

    % Initial Table
    table = [A_aug b ; - Cost_vector_aug' 0];

    % Initial Basis (Slack)
    basis = n+1:n+m;

    while true
        %S2 : Check Optimality - No negative number in last row
        last_row = table(end, 1:end-1);
        [min_val, pivot_col] = min(last_row);

        if min_val >= 0
            break; % We have reached optimal solution
        end

        % S3 : Ratio Test
        col = table(1:end-1, pivot_col);
        rhs = table(1:end-1, end);

        ratios = rhs ./ col;
        ratios(col <=0) = inf;

        [min_ratio, pivot_row] = min(ratios);

        if isinf(min_ratio)
            error('Unbounded Solution')
        end

        % S4 : Pivot Operation
        pivot_element = table(pivot_row, pivot_col);
        table(pivot_row,:) = table(pivot_row,:) / pivot_element;

        for i = 1:size(table,1)
            if i ~= pivot_row
                table(i,:) = table(i,:) - table(i, pivot_col)*table(pivot_row, :);
            end
        end

        % Updating basis:
        basis(pivot_row) = pivot_col;
    end

    % Step 5: Extract solution
    x_opt = zeros(n+m,1);
    x_opt(basis) = table(1:m, end);
    
    x_opt = x_opt(1:n); % original variables
    z_opt = table(end, end);
end