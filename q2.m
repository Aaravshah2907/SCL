% Revised Simplex Method for the given LPP
% min f = 2x1 + 3x2 + 2x3 - x4 + x5
% s.t. 3x1 - 3x2 + 4x3 + 2x4 - x5 + s1 = 0
%      x1 + x2 + x3 + 3x4 + x5 + s2 = 2

% 1. Problem Setup (Standard Form)
c = [2; 3; 2; -1; 1; 0; 0]; % Objective coefficients (including slacks)
A = [3 -3 4 2 -1 1 0; 
     1  1 1 3  1 0 1];      % Constraint matrix
b = [0; 2];

[m, n] = size(A);
basis = [6, 7];             % Indices of slack variables (s1, s2)
non_basis = [1, 2, 3, 4, 5];
B_inv = eye(m);             % Initial B inverse
iter = 0;

while iter < 10
    iter = iter + 1;
    fprintf('\n--- Iteration %d ---\n', iter);
    
    % Basic and Non-basic variables
    cb = c(basis)';
    xb = B_inv * b;         % Equivalent to A_inv * b
    
    % Display required variables
    disp('Current Basis:'), disp(basis);
    disp('Non-Basic Variables:'), disp(non_basis);
    disp('A_inv * b:'), disp(xb);
    
    % 2. Calculate Dual Variables (pi) and Reduced Costs
    pi_vec = cb * B_inv;
    cf_bar = zeros(1, length(non_basis));
    for j = 1:length(non_basis)
        idx = non_basis(j);
        cf_bar(j) = c(idx) - pi_vec * A(:, idx);
    end
    
    disp('Dual Variables (pi):'), disp(pi_vec);
    disp('Reduced Costs (cf_bar):'), disp(cf_bar);
    
    % 3. Check for Optimality
    [min_val, enter_idx_in_nb] = min(cf_bar);
    if min_val >= -1e-9
        disp('Optimal Solution Found.');
        break;
    end
    
    % 4. Entering Variable
    entering_var = non_basis(enter_idx_in_nb);
    d = B_inv * A(:, entering_var); % Entering column updated
    
    % 5. Ratio Test
    if all(d <= 0)
        error('Problem is Unbounded');
    end
    
    ratios = inf(m, 1);
    for i = 1:m
        if d(i) > 0
            ratios(i) = xb(i) / d(i);
        end
    end
    [~, p] = min(ratios); % p is the pivot row index
    leaving_var = basis(p);
    
    % 6. Matrix E (Eta Matrix)
    eta = d;
    eta_column = -eta / eta(p);
    eta_column(p) = 1 / eta(p);
    
    E = eye(m);
    E(:, p) = eta_column;
    
    disp('Pivot row (p):'), disp(p);
    disp('Matrix E:'), disp(E);
    
    % 7. Update for next iteration
    B_inv = E * B_inv;
    basis(p) = entering_var;
    non_basis(enter_idx_in_nb) = leaving_var;
end

% Final Output
final_x = zeros(n, 1);
final_x(basis) = B_inv * b;
fprintf('\n==========================\n');
fprintf('Optimal Objective Value: %f\n', c' * final_x);
disp('Optimal x:'), disp(final_x(1:5)');