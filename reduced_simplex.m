function [x, fval, exitflag] = reduced_simplex(c, A, b, method)
    % REDUCED_SIMPLEX Solve linear programming problem using reduced simplex method
    % min c'*x subject to A*x = b, x >= 0
    %
    % Inputs:
    %   c       - Cost vector (n x 1)
    %   A       - Constraint matrix (m x n)
    %   b       - Right-hand side vector (m x 1)
    %   method  - 'primal' or 'dual' (optional, default: 'primal')
    %
    % Outputs:
    %   x       - Optimal solution
    %   fval    - Optimal objective value
    %   exitflag - 1: optimal, 0: max iterations, -1: infeasible/unbounded
    
    if nargin < 4
        method = 'primal';
    end
    
    [m, n] = size(A);
    max_iter = 1000;
    tol = 1e-6;
    
    % Initialize with artificial variables for feasibility
    [A_phase1, c_phase1, basis] = phase1_simplex(A, b, m, n);
    
    if ~is_feasible(A_phase1, c_phase1, basis, m, n)
        exitflag = -1;
        x = [];
        fval = [];
        return;
    end
    
    % Phase 2: Optimize original objective
    for iter = 1:max_iter
        c_B = c(basis);
        B = A(:, basis);
        
        % Compute reduced costs
        y = (c_B' / B)';
        r = c' - A' * y;
        
        % Check optimality
        if all(r(setdiff(1:n, basis)) >= -tol)
            x = zeros(n, 1);
            x(basis) = B \ b;
            fval = c' * x;
            exitflag = 1;
            return;
        end
        
        % Find entering variable
        [~, j] = min(r);
        
        % Compute direction
        d = B \ A(:, j);
        
        % Check unboundedness
        if all(d <= tol)
            exitflag = -1;
            x = [];
            fval = [];
            return;
        end
        
        % Find leaving variable
        theta = inf;
        leave_idx = -1;
        for i = 1:m
            if d(i) > tol
                ratio = (B \ b)(i) / d(i);
                if ratio < theta
                    theta = ratio;
                    leave_idx = i;
                end
            end
        end
        
        % Update basis
        basis(leave_idx) = j;
    end
    
    exitflag = 0;
    x = [];
    fval = [];
end

function [A_phase1, c_phase1, basis] = phase1_simplex(A, b, m, n)
    % Add artificial variables for Phase 1
    A_phase1 = [A, eye(m)];
    c_phase1 = [zeros(n, 1); ones(m, 1)];
    basis = (n+1):(n+m);
end

function feasible = is_feasible(A, c, basis, m, n)
    % Check if current basis is feasible
    feasible = all(A(:, basis) \ c >= -1e-6);
end