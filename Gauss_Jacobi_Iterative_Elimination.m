function [x, err, iter] = Gauss_Jacobi_Iterative_Elimination(A, b, x0, eps, maxIter)
    % Solves Ax = b using Gauss-Jacobi iterative method
    % x    : solution vector
    % err  : infinity-norm error at each iteration
    % iter : number of iterations performed
    
    % ---------------- Default Checks ----------------
    if nargin < 3 || isempty(x0)
        x0 = zeros(length(b),1);
    end
    if nargin < 4 || isempty(eps)
        eps = 1e-6;
    end
    if nargin < 5 || isempty(maxIter)
        maxIter = 100;
    end
    
    n = length(b);
    x = x0;
    err = zeros(maxIter,1);
    
    % ---------------- Jacobi Iteration ----------------
    for iter = 1:maxIter
        x_new = zeros(n,1);
        
        for i = 1:n
            if A(i,i) == 0
                error('Zero diagonal element detected. Jacobi method fails.');
            end
            
            sum1 = A(i,1:i-1) * x(1:i-1);
            sum2 = A(i,i+1:n) * x(i+1:n);
            
            x_new(i) = (b(i) - sum1 - sum2) / A(i,i);
        end
        
        % Infinity-norm error
        err(iter) = norm(x_new - x, inf);
        
        % Convergence check
        if err(iter) < eps
            x = x_new;
            err = err(1:iter);
            return
        end
        
        x = x_new;
    end
    
    % If max iterations reached
    err = err(1:iter);
    warning('Maximum iterations reached without convergence');

end