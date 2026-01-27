function root = Root_Bisection(a, b, tol, maxIter)
    % Bisection method to find root of f1(x)
    
    % Arranging for default Tolerance..
    if nargin < 3 || isempty(tol)
        tol = 1e-10;
    end
    if nargin < 4 || isempty(maxIter)
        maxIter = 100;
    end
    
    % First Criteria check
    if f(a)*f(b) > 0
        error('Function has same sign at a and b');
    end
    max = 1;
    root = a;
    % Actual Method..
    for i = 1:maxIter
        c = (a + b)/2;
    
        if abs(f(c)) < tol || (b - a)/2 < tol
            root = c;
            fprintf('Bisection root = %.10f after %d iterations\n', root, i);
            max = i;
            return
        end
    
        if f(a)*f(c) < 0
            b = c;
            root = b;
        else
            a = c;
            root = a;
        end
        max = i;
    end
    
    fprintf('Bisection root (max iterations reached) at %d = %.10f\n', max, root);
end
