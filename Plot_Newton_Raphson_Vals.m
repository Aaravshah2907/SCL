function errors = Plot_Newton_Raphson_Vals(x0, tol, maxIter)
    
    % Initial checks

    if nargin < 2 || isempty(tol)
        tol = 1e-14;
    end
    if nargin < 3 || isempty(maxIter)
        maxIter = 15;
    end

    alpha = 1.324717957244746;
    vals = 1:maxIter;
    for iter = 1:maxIter
        vals(iter) = Root_NewtonRaphson(x0, tol, iter);
    end
    
    errors = vals - alpha;
    title_log = sprintf("NR Error log %e tolerance",tol);
    title = sprintf("NR Error %e tolerance",tol);
    Plot_Figure(1:maxIter, vals, "Iteration", "Value", title, "NR_Value", alpha, "Actual Value")
    Plot_Figure(1:maxIter, log(errors), "Iteration", "Error", title, "NR_Error", alpha, "Actual Value")
    Plot_Figure(1:maxIter, errors, "Iteration", "Error", title_log, "NR_Error")
end