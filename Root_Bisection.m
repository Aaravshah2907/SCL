function root = Root_Bisection(a, b, tol, maxIter)
    % Bisection method to find root of f1(x)
    
    % Arranging for default Tolerance..
    if nargin < 3 || isempty(tol)
        tol = 1e-6;
    end
    if nargin < 4 || isempty(maxIter)
        maxIter = 100;
    end
    
    % First Criteria check
    if f1(a)*f1(b) > 0
        error('Function has same sign at a and b');
    end
    
    % Actual Method..
    for i = 1:maxIter
        c = (a + b)/2;
    
        if abs(f1(c)) < tol || (b - a)/2 < tol
            root = c;
            fprintf('Bisection root = %.6f after %d iterations\n', root, i);
            return
        end
    
        if f1(a)*f1(c) < 0
            b = c;
        else
            a = c;
        end
    end
    
    root = (a + b)/2;
    fprintf('Bisection root (max iterations reached) = %.6f\n', root);
end
