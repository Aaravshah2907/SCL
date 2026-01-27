function errors = Plot_Secant_Vals(a, b, tol, maxIter)
    
    % Initial checks

    if nargin < 3 || isempty(tol)
        tol = 1e-10;
    end
    if nargin < 4 || isempty(maxIter)
        maxIter = 25;
    end

    alpha = 1.324717957244746;
    vals = 1:maxIter;
    for iter = 1:maxIter
        vals(iter) = Root_Secant(a, b, tol, iter);
    end

    Plot_Figure(1:maxIter, vals, "Iteration", "Value", "Secant Value", "Secant_Value", alpha, "Actual Value")
    errors = vals - alpha;
    Plot_Figure(1:maxIter, errors, "Iteration", "Error", "Secant Error", "Secant_Error", 0, "Needed Error")

end