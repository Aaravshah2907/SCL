function root = Root_NewtonRaphson(x0, tol, maxIter)
    % Newton-Raphson method
    
    % Default Checks
    if nargin < 2 || isempty(tol)
        tol = 1e-14;
    end
    if nargin < 3 || isempty(maxIter)
        maxIter = 250;
    end
    
    % Assuming solution provided by user..
    x = x0;
    
    for i = 1:maxIter
        x_new = x - f(x)/df(x);
    
        if abs(x_new - x) < tol
            root = x_new;
            fprintf('NR root = %.14f after %d iterations\n', root, i);
            return
        end
    
        x = x_new;
    end
    
    root = x;
    fprintf('NR root (max iterations reached) = %.14f\n', root);
end
