function root = Root_Secant(x0, x1, tol, maxIter)
    % Secant method
    
    % Default Values..
    if nargin < 3 || isempty(tol)
        tol = 1e-6;
    end
    if nargin < 4 || isempty(maxIter)
        maxIter = 100;
    end
    
    % Actual Method..
    for i = 1:maxIter
        if f(x1) - f(x0) == 0
            error('Division by zero in secant method');
        end
    
        x2 = x1 - f(x1)*(x1 - x0)/(f(x1) - f(x0));
    
        if abs(x2 - x1) < tol
            root = x2;
            fprintf('Secant root = %.6f after %d iterations\n', root, i);
            return
        end
    
        x0 = x1;
        x1 = x2;
    end
    
    root = x1;
    fprintf('Secant root (max iterations reached) = %.6f\n', root);
end
