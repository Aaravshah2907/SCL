function root = Root_FalsePosition(a, b, tol, maxIter)
    % False Position (Regula Falsi) method to find root of f(x)
    
    % Deafult Values..
    if nargin < 3 || isempty(tol)
        tol = 1e-6;
    end
    if nargin < 4 || isempty(maxIter)
        maxIter = 100;
    end
    
    % Default Check..
    if f(a)*f(b) > 0
        error('Function has same sign at a and b');
    end
    
    % Actual Method..
    for i = 1:maxIter
        % Regula Falsi formula
        c = (a*f(b) - b*f(a)) / (f(b) - f(a));
    
        if abs(f(c)) < tol
            root = c;
            fprintf('False Position root = %.6f after %d iterations\n', root, i);
            return
        end
    
        if f(a)*f(c) < 0
            b = c;
        else
            a = c;
        end
    end
    
    root = c;
    fprintf('False Position root (max iterations reached) = %.6f\n', root);
end
