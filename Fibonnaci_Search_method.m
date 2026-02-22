function [a, b, k, app_min, min_val] = Fibonnaci_Search_method(f, a, b, eps)
    if nargin < 4 || isempty(eps)
        eps = 1e-5;
    end

    F = [1 1];
    while F(end) < (b-a)/eps
        F(end+1) = F(end) + F(end-1);
    end

    n = length(F);
    x1 = a + (F(n-2)/F(n))*(b-a);
    x2 = a + (F(n-1)/F(n))*(b-a);

    fx1 = f(x1);
    fx2 = f(x2);

    for k = 1:n-3
        if fx1 > fx2
            a = x1;
            x1 = x2;
            fx1 = fx2;
            x2 = a + (F(n-k-1)/F(n-k))*(b-a);
            fx2 = f(x2);
        else
            b = x2;
            x2 = x1;
            fx2 = fx1;
            x1 = a + (F(n-k-2)/F(n-k))*(b-a);
            fx1 = f(x1);
        end
    
    end

    app_min = (a+b)/2;
    min_val = f(app_min);

    fprintf('\nFibonacci Search Results:\n');
    fprintf('---------------------------\n');
    fprintf('Number of iterations: %d\n', k);
    fprintf('Final interval: [%.10f , %.10f]\n', a, b);
    fprintf('Approximate minimizer: %.10f\n', app_min);
    fprintf('Function value at minimizer: %.10f\n', min_val);

end