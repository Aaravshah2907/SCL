function [x_opt, fval] = revised_simplex_general(A, b, c, B)
    % A : m×n matrix
    % b : m×1 RHS
    % c : n×1 cost vector
    % B : initial basis indices (size m)
    [m, n] = size(A);
    N = setdiff(1:n, B);
    max_iter = 50;

    for iter = 1:max_iter
        fprintf('\n--- Iteration %d ---\n', iter);
        % Basis matrices
        AB = A(:, B);
        AN = A(:, N);
        % Inverse of basis
        AB_inv = inv(AB);
        % Basic solution
        xB = AB_inv * b;
        % Costs
        cB = c(B);
        cN = c(N);
        % Multipliers
        p = (cB' * AB_inv);
        % Reduced costs
        c_bar = cN' - p * AN;
        % Display required values
        fprintf('Basic variables B: '); disp(B);
        fprintf('Non-basic variables N: '); disp(N);
        fprintf('A_B^{-1}:\n'); disp(AB_inv);
        fprintf('x_B:\n'); disp(xB);
        fprintf('p:\n'); disp(p');
        fprintf('Reduced costs c_bar:\n'); disp(c_bar');
        % Optimality check (minimization)
        [min_val, enter_idx] = min(c_bar);
        if min_val >= 0
            fprintf('Optimal solution reached.\n');
            break;
        end
        % Entering variable
        entering = N(enter_idx);
        % Direction vector
        d = AB_inv * A(:, entering);
        % Ratio test
        ratios = inf(m,1);
        for i = 1:m
            if d(i) > 0
                ratios(i) = xB(i) / d(i);
            end
        end
        [~, leave_idx] = min(ratios);
        if isinf(ratios(leave_idx))
            error('Unbounded solution.');
        end
        leaving = B(leave_idx);
        fprintf('Entering variable: x%d\n', entering);
        fprintf('Leaving variable: x%d\n', leaving);
        % --- Eta matrix (E) ---
        E = eye(m);
        E(:, leave_idx) = d;
        fprintf('Eta matrix E:\n'); disp(E);
        % Update basis
        B(leave_idx) = entering;
        N = setdiff(1:n, B);
    end
    % Construct full solution
    x_opt = zeros(n,1);
    x_opt(B) = xB;
    % Objective value
    fval = c' * x_opt;
    fprintf('\nOptimal solution:\n');
    disp(x_opt);
    fprintf('Optimal value:\n');
    disp(fval);
end