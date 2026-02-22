function [critPoints, types] = criticalPoints1D(f)
    % criticalPoints1D - find and classify critical points of a 1D function
    %
    % Inputs:
    %   f - symbolic function of x
    %
    % Outputs:
    %   critPoints - Nx1 array of critical points
    %   types      - cell array of classifications ('Local minimum', 'Local maximum', 'Inflection point')

    %% 1. Symbol
    syms x

    %% 2. First and second derivatives
    f1 = diff(f, x);  % f'(x)
    f2 = diff(f1, x); % f''(x)

    %% 3. Solve f'(x) = 0
    sol = solve(f1 == 0, x, 'Real', true);
    critPoints = double(sol);

    %% 4. Classify critical points
    n = length(critPoints);
    types = cell(n,1);

    for k = 1:n
        f2_val = double(subs(f2, x, critPoints(k)));

        if f2_val > 0
            types{k} = 'Local minimum';
        elseif f2_val < 0
            types{k} = 'Local maximum';
        else
            types{k} = 'Inflection point';
        end
    end

    %% 5. Display results
    fprintf('\nCritical points:\n');
    for k = 1:n
        fprintf('x = %g → %s\n', critPoints(k), types{k});
    end
end
