function errors = Plot_Bisection_Vals(a, b, tol, maxIter)
    
    % Initial checks

    if nargin < 3 || isempty(tol)
        tol = 1e-10;
    end
    if nargin < 4 || isempty(maxIter)
        maxIter = ceil(log2((b - a) / tol));
    end

    alpha = 1.324717957244746;
    vals = 1:maxIter;
    for iter = 1:maxIter
        vals(iter) = Root_Bisection(a, b, tol, iter);
    end

    Plot_Figure(1:maxIter, vals, "Iteration", "Value", "Bisection Value", "Bisection_Value", alpha, "Actual Value")
    errors = vals - alpha;
    Plot_Figure(1:maxIter, errors, "Iteration", "Error", "Bisection Error", "Bisection_Error", 0, "Needed Error")

end