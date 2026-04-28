function [x, fval] = dual_simplex(c, A, b)
% DUAL_SIMPLEX Solves linear programming problem using dual simplex method
% min c'*x subject to A*x >= b, x >= 0
% 
% Inputs:
%   c - Coefficient vector for objective function
%   A - Constraint matrix
%   b - Right-hand side vector
% Outputs:
%   x - Optimal solution
%   fval - Optimal objective value

    [m, n] = size(A);
    
    % Convert to standard form: A*x - s = b, where s >= 0 (slack variables)
    A_std = [A, -eye(m)];
    c_std = [c; zeros(m, 1)];
    
    % Initial basis (artificial variables)
    basis = (n+1):(n+m);
    non_basis = 1:n;
    
    max_iterations = 1000;
    iteration = 0;
    
    while iteration < max_iterations
        iteration = iteration + 1;
        
        % Extract basis and non-basis columns
        B = A_std(:, basis);
        N = A_std(:, non_basis);
        c_B = c_std(basis);
        c_N = c_std(non_basis);
        
        % Compute reduced costs
        y = (B' \ c_B')';
        reduced_costs = c_N' - y * N;
        
        % Check optimality for dual simplex
        if all(b >= -1e-10)
            break; % Optimal solution found
        end
        
        % Select leaving variable (most negative RHS)
        [~, leaving_idx] = min(b);
        
        if b(leaving_idx) >= -1e-10
            break;
        end
        
        % Compute ratios for entering variable
        row = (B \ A_std(:, non_basis))';
        ratios = zeros(1, length(non_basis));
        
        for j = 1:length(non_basis)
            if row(j, leaving_idx) < -1e-10
                ratios(j) = reduced_costs(j) / row(j, leaving_idx);
            else
                ratios(j) = inf;
            end
        end
        
        [~, entering_local_idx] = min(ratios);
        entering_idx = non_basis(entering_local_idx);
        
        % Update basis
        basis_local_idx = find(basis == basis(leaving_idx));
        basis(basis_local_idx) = entering_idx;
        non_basis(non_basis == entering_idx) = basis(basis_local_idx);
        
        % Update RHS
        pivot = (B \ A_std(:, entering_idx));
        B = B / pivot(leaving_idx);
        b = B \ b';
    end
    
    % Extract solution
    x = zeros(n+m, 1);
    x(basis) = b;
    x = x(1:n);
    fval = c' * x;
end