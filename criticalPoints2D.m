function [critPoints, types] = criticalPoints2D(f)
    % Inputs:
    %   f - symbolic function of x and y
    %
    % Outputs:
    %   critPoints - Nx2 array of critical points [x y]
    %   types      - cell array of classifications

    %% 1. Symbols
    syms x y

    %% 2. Gradient and Hessian
    gradf = gradient(f, [x y]);
    H = hessian(f, [x y]);

    %% 3. Solve ∇f = 0
    sol = solve(gradf == 0, [x y], 'Real', true);

    critPoints = [sol.x, sol.y];
    critPoints = double(critPoints);

    %% 4. Classify critical points
    n = size(critPoints, 1);
    types = cell(n, 1);

    for k = 1:n
        Hk = double(subs(H, [x y], critPoints(k, :)));
        eigvals = eig(Hk);

        if all(eigvals > 0)
            types{k} = 'Local minimum';
        elseif all(eigvals < 0)
            types{k} = 'Local maximum';
        else
            types{k} = 'Saddle point';
        end
    end

    %% 5. Display results
    fprintf('\nCritical points:\n');
    for k = 1:n
        fprintf('(%g, %g) → %s\n', critPoints(k,1), critPoints(k,2), types{k});
    end
end
