function [a, b, iter, app_min, min_val] = Bisection_Search_method(f, a, b, eps, nmax, delta)
    if nargin < 4 || isempty(eps)
        eps = 1e-5;
    end
    if nargin < 5 || isempty(nmax)
        nmax = log2((b-a)/eps);
    end
    if nargin < 6 || isempty(delta)
        delta = (b-a)*0.001;
    end

    Nmax = ceil(log2((b-a)/eps));
    for iter = 1: nmax
        x1 = a + (b-a)/2 - delta/2;
        x2 = a + (b-a)/2 + delta/2;
    
        fx1 = f(x1);
        fx2 = f(x2);
        
        if fx1 > fx2
            a = x1;
        else
            b = x2;
        end 
    end

    app_min = (a+b)/2;
    min_val = f(app_min);

    fprintf('\nBisection Search Results:\n');
    fprintf('---------------------------\n');
    fprintf('Number of iterations: %d\n', iter);
    fprintf('Number of iterations required for max precision: %d\n', Nmax);
    fprintf('Final interval: [%.10f , %.10f]\n', a, b);
    fprintf('Approximate minimizer: %.10f\n', app_min);
    fprintf('Function value at minimizer: %.10f\n', min_val);

end