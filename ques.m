function solve_LP_Q4()
    disp('--- Question 4: Dual Simplex Method ---');
    
    % Problem formulation: Minimize Z = 3x1 + 2x2 -> Maximize -Z = -3x1 - 2x2
    % Constraints (>= converted to <= for Dual Simplex):
    % -x1 - x2 <= -4
    % -2x1 - x2 <= -5
    
    % Columns: [Z, x1, x2, s1, s2, RHS]
    % Initial Tableau
    tableau_init = [
        1,  3,  2,  0,  0,  0;  % Objective row (Z)
        0, -1, -1,  1,  0, -4;  % Constraint 1
        0, -2, -1,  0,  1, -5   % Constraint 2
    ];
    
    % Tracking basic variables for updating tableaux later (rows 2 and 3)
    % Initial basic variables: col 4 (s1) and col 5 (s2)
    bv = [4, 5]; 
    
    disp('Initial Problem Optimization:');
    [opt_tableau, bv_opt] = run_dual_simplex(tableau_init, bv);
    display_solution(opt_tableau, bv_opt, {'Z', 'x1', 'x2', 's1', 's2', 'RHS'});
    
    % --- Part (f): Add new constraint x1 + 2x2 >= 6 ---
    % Standardized: -x1 - 2x2 <= -6 -> -x1 - 2x2 + s3 = -6
    disp('--- Part (f): Adding New Constraint ---');
    
    % Expand tableau: Add s3 column (before RHS) and new row
    [rows, cols] = size(opt_tableau);
    new_tableau = zeros(rows + 1, cols + 1);
    
    % Copy old tableau into new structure (shifting RHS right)
    new_tableau(1:rows, 1:cols-1) = opt_tableau(:, 1:cols-1);
    new_tableau(1:rows, cols+1) = opt_tableau(:, cols); % RHS
    
    % Add new constraint row: [0 for Z, -1 for x1, -2 for x2, 0 for s1/s2, 1 for s3, -6 for RHS]
    new_row = [0, -1, -2, 0, 0, 1, -6];
    new_tableau(rows+1, :) = new_row;
    
    % New basic variable for the new row is s3 (column 6)
    bv_f = [bv_opt, 6]; 
    
    % Restore canonical form: substitute out basic variables from the new row
    for i = 1:length(bv_opt)
        basic_col = bv_opt(i);
        coeff = new_tableau(rows+1, basic_col);
        if coeff ~= 0
            % Subtract (coeff * the row where this basic variable is 1)
            new_tableau(rows+1, :) = new_tableau(rows+1, :) - coeff * new_tableau(i+1, :);
        end
    end
    
    % Re-run Dual Simplex
    [opt_tableau_f, bv_opt_f] = run_dual_simplex(new_tableau, bv_f);
    display_solution(opt_tableau_f, bv_opt_f, {'Z', 'x1', 'x2', 's1', 's2', 's3', 'RHS'});
    
    % --- Part (g): Changing RHS of Constraint 1 from 4 to 6 ---
    disp('--- Part (g): Changing RHS ---');
    % The original RHS changes from [-4; -5] to [-6; -5]. The change delta_b = [-2; 0]
    % We apply B^-1 * delta_b to the optimal RHS.
    % B^-1 is located under the initial slack variables (cols 4 and 5) in opt_tableau
    
    tableau_g = opt_tableau;
    B_inv = tableau_g(2:3, 4:5); 
    delta_b = [-2; 0];
    
    % Update the RHS of the constraints
    tableau_g(2:3, end) = tableau_g(2:3, end) + B_inv * delta_b;
    
    % Objective value might also change: delta_Z = C_B * B^-1 * delta_b
    % We can get the change directly from the objective row coefficients under s1, s2
    obj_change_coeffs = tableau_g(1, 4:5);
    tableau_g(1, end) = tableau_g(1, end) + obj_change_coeffs * delta_b;
    
    % Re-run Dual Simplex if feasibility is lost
    [opt_tableau_g, bv_opt_g] = run_dual_simplex(tableau_g, bv_opt);
    display_solution(opt_tableau_g, bv_opt_g, {'Z', 'x1', 'x2', 's1', 's2', 'RHS'});
end

function [tableau, bv] = run_dual_simplex(tableau, bv)
    % Helper function to execute Dual Simplex loop
    iter = 1;
    while any(tableau(2:end, end) < -1e-6) % Check for negative RHS
        % (a) Identify leaving variable (most negative RHS)
        [~, leave_idx] = min(tableau(2:end, end));
        pivot_row = leave_idx + 1; % Adjust index for obj row
        
        % (b) Ratio test using only negative elements in pivot row
        ratios = inf(1, size(tableau, 2) - 1);
        for j = 2:size(tableau, 2)-1 % Skip Z and RHS
            if tableau(pivot_row, j) < -1e-6
                ratios(j) = abs(tableau(1, j) / tableau(pivot_row, j));
            end
        end
        
        [min_ratio, enter_col] = min(ratios);
        
        if isinf(min_ratio)
            error('Problem is infeasible.');
        end
        
        % Update Basic Variable tracking
        bv(pivot_row - 1) = enter_col;
        
        % (c) Perform pivot operations
        pivot_val = tableau(pivot_row, enter_col);
        tableau(pivot_row, :) = tableau(pivot_row, :) / pivot_val; % Normalize pivot row
        
        for i = 1:size(tableau, 1)
            if i ~= pivot_row
                factor = tableau(i, enter_col);
                tableau(i, :) = tableau(i, :) - factor * tableau(pivot_row, :);
            end
        end
        iter = iter + 1;
    end
end

function display_solution(tableau, bv, headers)
    % Helper function to format and display output 
    disp('Optimal Tableau:');
    disp(strjoin(headers, char(9)));
    disp(num2str(tableau, '%8.2f\t'));
    
    % Extract x1 (col 2) and x2 (col 3) from the basis
    x1 = 0; x2 = 0;
    if ismember(2, bv)
        x1 = tableau(find(bv==2) + 1, end);
    end
    if ismember(3, bv)
        x2 = tableau(find(bv==3) + 1, end);
    end
    
    % Min Z is the negation of the Max (-Z) value in the objective row
    min_Z = -tableau(1, end);
    
    fprintf('Optimal Solution: x1 = %.2f, x2 = %.2f\n', x1, x2);
    fprintf('Minimum Z = %.2f\n\n', min_Z);
end