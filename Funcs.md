# Matlab Functions

## Substitution Methods

### Backward Substitution

```m
function x = backwardSubstitution(A, b)
    n = length(b);
    x = zeros(n,1);

    x(n) = b(n) / A(n,n);
    for i = n-1:-1:1
        x(i) = (b(i) - A(i,i+1:n)*x(i+1:n)) / A(i,i);
    end
end
```

### Forward Substitution

```m
function x = forwardSubstitution(A, b)
    n = length(b);
    x = zeros(n,1);

    x(1) = b(1) / A(1,1);
    for i = 2:n
        x(i) = (b(i) - A(i,1:i-1)*x(1:i-1)) / A(i,i);
    end
end
```

## Matrix Functions

### Determinant

```m
function d = myDet(A)
    [m, n] = size(A);
    if m ~= n
        error('Matrix must be square.');
    end
    
    % Base case: 1x1 matrix
    if m == 1
        d = A(1, 1);
        return;
    end
    
    d = 0;
    for j = 1:n
        % Calculate cofactor by creating the submatrix (minor)
        subA = A(2:m, [1:j-1, j+1:n]);
        
        % Add/subtract alternate terms
        if mod(j, 2) == 0
            signVal = -1;
        else
            signVal = 1;
        end
        
        d = d + signVal * A(1, j) * myDet(subA); % Recursive call
    end
end

% Inbuilt function : det(A)
```

### Inverse

```m
function result = myInverse(A)
    [m, n] = size(A);
    if m ~= n
        error('Matrix must be square.');
    end

    if m == 1
        result = 1 / A(1, 1);
        return;
    end

    result = A / eye(n);
end
```

### Trace

```m
function result = myTrace(A)
    
    % Check for Square Matrix
    [rows, cols] = size(A);
    if rows ~= cols
        error('Input matrix must be square.');
    end

    % Initialize the sum
    result = 0;

    % Loop through the diagonal elements and sum them
    for i = 1:rows
        result = result + A(i, i);
    end
end


% Inbuilt Function: trace(A)
```

### LU - No Pivot

```m
function [L, U] = lu_nopivot(A)
    
    n = size(A, 1); % Obtain number of rows (should equal number of columns)
    L = eye(n); % Start L off as identity and populate the lower triangular half slowly
    for k = 1 : n
        % For each row k, access columns from k+1 to the end and divide by
        % the diagonal coefficient at A(k ,k)
        L(k + 1 : n, k) = A(k + 1 : n, k) / A(k, k);
    
        % For each row k+1 to the end, perform Gaussian elimination
        % In the end, A will contain U
        for l = k + 1 : n
            A(l, :) = A(l, :) - L(l, k) * A(k, :);
        end
    end
    U = A;

end
```

### Inverse Using LU

```m
function X = invUsingLU(A, B)
    [n, m] = size(A);
    if n ~= m
        error('Matrix A must be square');
    end

    [L, U, P] = lu(A);

    y = L \ (P*B);   % Forward substitution
    X = U \ y;       % Back substitution
end

```

## Function

### F

```m
function y = f(x)
    y = exp(x)  - 4.*x; % Calculates f(x)
end
```

## Root Finding

### Bisection

```m
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
```

### False Position

```m
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
```

### Newton Raphson

```m
function root = Root_NewtonRaphson(x0, tol, maxIter)
    % Newton-Raphson method
    
    % Default Checks
    if nargin < 2 || isempty(tol)
        tol = 1e-14;
    end
    if nargin < 3 || isempty(maxIter)
        maxIter = 250;
    end
    
    % Assuming solution provided by user..
    x = x0;
    
    for i = 1:maxIter
        x_new = x - f(x)/df(x);
    
        if abs(x_new - x) < tol
            root = x_new;
            fprintf('NR root = %.14f after %d iterations\n', root, i);
            return
        end
    
        x = x_new;
    end
    
    root = x;
    fprintf('NR root (max iterations reached) = %.14f\n', root);
end
```

Convergence:

```m
function conv_vals = Convergence_Newton_Raphson(errors)

    n = numel(errors);
    conv_vals = zeros(1, n-1);
    
    for k = 1:n-1
        if abs(errors(k)) < eps
            conv_vals(k) = 0;
        else
            conv_vals(k) = errors(k+1) / (errors(k)*errors(k));
        end
    end
    
end
```

### Regula Falsi

```m
function root = Root_RegulaFalsi(a, b, tol, maxIter)
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

```

### Secant

```m
function root = Root_Secant(x0, x1, tol, maxIter)
    % Secant method
    
    % Default Values..
    if nargin < 3 || isempty(tol)
        tol = 1e-10;
    end
    if nargin < 4 || isempty(maxIter)
        maxIter = 100;
    end
    
    % Actual Method..
    for i = 1:maxIter
        if f(x1) - f(x0) == 0
            root = x1;
            fprintf('Secant root = %.10f after %d iterations\n', root, i);
            return;
        end
    
        x2 = x1 - f(x1)*(x1 - x0)/(f(x1) - f(x0));
    
        if abs(x2 - x1) < tol
            root = x2;
            fprintf('Secant root = %.10f after %d iterations\n', root, i);
            return
        end
    
        x0 = x1;
        x1 = x2;
    end
    
    root = x1;
    fprintf('Secant root (max iterations reached) = %.10f\n', root);
end
```

## Critical Points

### 1D

```m
function [critPoints, types] = criticalPoints1D(f)
    % criticalPoints1D - find and classify critical points of a 1D function
    %
    % Inputs:
    %   f - symbolic function of x
    %
    % Outputs:
    %   critPoints - Nx1 array of critical points
    %   types      - cell array of classifications ('Local minimum', 'Local maximum', 'Inflection point')

    %% 1. Symbol
    syms x

    %% 2. First and second derivatives
    f1 = diff(f, x);  % f'(x)
    f2 = diff(f1, x); % f''(x)

    %% 3. Solve f'(x) = 0
    sol = solve(f1 == 0, x, 'Real', true);
    critPoints = double(sol);

    %% 4. Classify critical points
    n = length(critPoints);
    types = cell(n,1);

    for k = 1:n
        f2_val = double(subs(f2, x, critPoints(k)));

        if f2_val > 0
            types{k} = 'Local minimum';
        elseif f2_val < 0
            types{k} = 'Local maximum';
        else
            types{k} = 'Inflection point';
        end
    end

    %% 5. Display results
    fprintf('\nCritical points:\n');
    for k = 1:n
        fprintf('x = %g → %s\n', critPoints(k), types{k});
    end
end
```

### 2D

```m
function [critPoints, types] = criticalPoints2D(f)
    % Inputs:
    %   f - symbolic function of x and y
    %
    % Outputs:
    %   critPoints - Nx2 array of critical points [x y]
    %   types      - cell array of classifications

    %% 1. Symbols
    syms x y

    %% 2. Gradient and Hessian
    gradf = gradient(f, [x y]);
    H = hessian(f, [x y]);

    %% 3. Solve ∇f = 0
    sol = solve(gradf == 0, [x y], 'Real', true);

    critPoints = [sol.x, sol.y];
    critPoints = double(critPoints);

    %% 4. Classify critical points
    n = size(critPoints, 1);
    types = cell(n, 1);

    for k = 1:n
        Hk = double(subs(H, [x y], critPoints(k, :)));
        eigvals = eig(Hk);

        if all(eigvals > 0)
            types{k} = 'Local minimum';
        elseif all(eigvals < 0)
            types{k} = 'Local maximum';
        else
            types{k} = 'Saddle point';
        end
    end

    %% 5. Display results
    fprintf('\nCritical points:\n');
    for k = 1:n
        fprintf('(%g, %g) → %s\n', critPoints(k,1), critPoints(k,2), types{k});
    end
end
```

## Range Reduction - Search Methods

### Bisection Search

```m
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
```

### Fibonacci Search

```m
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
```

## Linear Equations

### Gauss - Jordan Elimination

```m
function X = Gauss_Jordan_Elimination(A, B)
     [n, m] = size(A);
    if n ~= m
        error('Matrix must be square');
    end

    % Augmented matrix [A | I]
    Aug = [A B];

    for i = 1:n
        % ---------- Partial pivoting ----------
        [~, k] = max(abs(Aug(i:n, i)));
        k = k + i - 1;
        Aug([i k], :) = Aug([k i], :);

        % ---------- Normalize pivot row ----------
        Aug(i, :) = Aug(i, :) / Aug(i, i);

        % ---------- Eliminate other rows ----------
        for j = 1:n
            if j ~= i
                Aug(j, :) = Aug(j, :) - Aug(j, i) * Aug(i, :);
            end
        end
    end

    % Extract inverse
    X = Aug(:, n+1:end);
end
```

### Gauss - Jacobi

```m
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
```

### Gauss - Seidel

```m
function [x, err, iter] = Gauss_Seidel_Iterative_Elimination(A, b, x0, eps, maxIter)
    % Solves Ax = b using Gauss-Seidel iterative method
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
        x_old = x;
        
        for i = 1:n
            if A(i,i) == 0
                error('Zero diagonal element detected. Jacobi method fails.');
            end
            
            sum1 = A(i,1:i-1) * x(1:i-1);
            sum2 = A(i,i+1:n) * x(i+1:n);
            
            x(i) = (b(i) - sum1 - sum2) / A(i,i);
        end
        
        % Infinity-norm error
        err(iter) = norm(x - x_old, inf);
        
        % Convergence check
        if err(iter) < eps
            err = err(1:iter);
            return
        end
    end
    
    % If max iterations reached
    err = err(1:iter);
    warning('Maximum iterations reached without convergence');

end
```

### Scaled Partial Pivoting

```m
function [U,c] = scaledPartialPivoting(A,b)

n = length(b);

% Scaling factors
s = max(abs(A), [], 2);

Aug = [A b];

for k = 1:n-1

    % Scaled ratios
    ratios = abs(Aug(k:n,k)) ./ s(k:n);
    [~, idx] = max(ratios);
    p = idx + k - 1;

    % Row swap
    if p ~= k
        Aug([k p], :) = Aug([p k], :);
        s([k p]) = s([p k]);
    end

    % Elimination
    for i = k+1:n
        m = Aug(i,k) / Aug(k,k);
        Aug(i,k:end) = Aug(i,k:end) - m*Aug(k,k:end);
    end
end

U = Aug(:,1:n);
c = Aug(:,n+1);

end
```

## Plots?

### Directional Derivative Map

```m
function directionalDerivativeMap(f, nAngles)
    % directionalDerivativeVectorField
    % f : symbolic function f(x,y)
    % nAngles : number of directions (default 12)
    
    if nargin < 2
        nAngles = 12; 
    end

    %% 1. Symbols
    syms x y

    %% 2. Gradient
    gradf = gradient(f, [x y]);
    grad_num = matlabFunction(gradf, 'Vars', [x y]);

    %% 3. Mesh grid
    x_range = linspace(-5,5,15); % coarse to avoid clutter
    y_range = linspace(-5,5,15);
    [X,Y] = meshgrid(x_range, y_range);

    % Gradient at mesh points
    G = grad_num(X,Y);  % 2 x Ny x Nx

    %% 4. Directions
    thetas = linspace(0,2*pi,nAngles+1);
    thetas(end) = [];
    
    scale = 0.3; % scale factor for quiver

    %% 5. Plot
    figure; hold on; axis equal;
    xlabel('x'); ylabel('y'); grid on;
    title('Directional derivative vectors at each point');

    % Loop over directions
    for k = 1:length(thetas)
        vx = cos(thetas(k));
        vy = sin(thetas(k));

        % Extract gradient components
        Gx = squeeze(G(1,:,:)); % Ny x Nx
        Gy = squeeze(G(2,:,:));

        % Directional derivative at each point
        Dv = vx*Gx + vy*Gy;     % Ny x Nx

        % Compute vector components for quiver
        U = scale*Dv*vx;        % Ny x Nx
        V = scale*Dv*vy;        % Ny x Nx

        % Plot arrows
        quiver(X, Y, U, V, 0, 'k');
    end
end
```

### Bisection Plots

```m
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
```

### NR Plot

```m
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
```

### Secant Plot

```m
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
```

### Jacobi Errors

```m
function plotJacobiErrors(A, b, x0, eps_values, maxIter)
    if nargin < 3 || isempty(x0)
        x0 = zeros(length(b),1);
    end
    if nargin < 4 || isempty(eps_values)
        eps_values = [1e-2 1e-4 1e-6 1e-8];
    end
    if nargin < 5 || isempty(maxIter)
        maxIter = 100;
    end

    colors = ['r','g','b','k'];  % optional
    
    figure; 
    hold on;  % important to plot all curves
    grid on;
    
    for k = 1:length(eps_values)
        fpri
        eps = eps_values(k);
        
        % Use the actual function inputs for x0 and maxIter
        [~, err, ~] = Gauss_Jacobi_Iterative_Elimination(A, b, x0, eps, maxIter*k);
        
        semilogy(1:length(err), err, ['-' colors(k)], 'LineWidth', 1.5);
    end
    
    xlabel('Iteration');
    ylabel('Error (||x^{k+1}-x^k||_\infty)');
    legend(arrayfun(@(e) ['\epsilon = ' num2str(e)], eps_values,'UniformOutput',false));
    title('Gauss-Jacobi Convergence for Various \epsilon');
    hold off;
end
```

### Grad Analysis

```m
function plotGradientAnalysis(func, P, v)
    % func : symbolic function of x and y
    % P    : [px py]
    % v    : direction vector [vx vy]

    %% 1. Symbols
    syms x y

    %% 2. Point
    px = P(1);
    py = P(2);

    %% 3. Gradient
    grad_sym = gradient(func, [x, y]);
    grad_num = matlabFunction(grad_sym, 'Vars', [x y]);
    grad_val = grad_num(px, py);

    gu = grad_val(1);
    gv = grad_val(2);

    %% 4. Normalize direction vector
    v = v(:).' / norm(v);

    %% 5. Numeric function handle (KEY FIX)
    f_num = matlabFunction(func, 'Vars', [x y]);

    %% 6. Grid
    x_range = linspace(-50, 50, 1000);
    y_range = linspace(-50, 50, 1000);
    [X, Y] = meshgrid(x_range, y_range);

    Z = f_num(X, Y);   % ← no symbolic conversion issues

    %% ================= CONTOUR PLOT =================
    fig1 = figure;
    contour(X, Y, Z, 20);
    hold on;

    quiver(px, py, gu, gv, 0.5, 'r', 'LineWidth', 2);
    quiver(px, py, v(1), v(2), 1, 'b', 'LineWidth', 2);
    scatter(px, py, 60, 'k', 'filled');

    xlabel('x');
    ylabel('y');
    title('Contour with Gradient (red) and Direction v (blue)');
    axis equal;
    grid on;
    hold off;

    saveas(fig1, 'contour_gradient_direction.png');

    %% ================= SURFACE PLOT =================
    fig2 = figure;
    surf(X, Y, Z, 'EdgeColor', 'none');
    hold on;

    zP = f_num(px, py);
    scatter3(px, py, zP, 80, 'k', 'filled');

    quiver3(px, py, zP, gu, gv, 0, 'r', 'LineWidth', 2);
    quiver3(px, py, zP, v(1), v(2), 0, 'b', 'LineWidth', 2);

    xlabel('x');
    ylabel('y');
    zlabel('f(x,y)');
    title('Surface with Gradient and Direction Vector');
    view(45,30);
    colorbar;
    grid on;
    hold off;

    saveas(fig2, 'surface_gradient_direction.png');
end
```

### Grad Flow

```m
function plotGradientFlow(f, xrange, yrange, density)
    % plotGradientFlow - visualize gradient flow of a 2D function f(x,y)
    %
    % f        : symbolic function f(x,y)
    % xrange   : [xmin xmax], default [-5 5]
    % yrange   : [ymin ymax], default [-5 5]
    % density  : number of grid points in each direction, default 20
    
    if nargin < 2
        xrange = [-10 10];
    end
    if nargin < 3
        yrange = [-10 10];
    end
    if nargin < 4
        density = 20;
    end

    %% 1. Symbols
    syms x y

    %% 2. Gradient
    gradf = gradient(f, [x y]);
    gradX = matlabFunction(gradf(1), 'Vars', [x y]);
    gradY = matlabFunction(gradf(2), 'Vars', [x y]);

    %% 3. Mesh grid
    x_vals = linspace(xrange(1), xrange(2), density);
    y_vals = linspace(yrange(1), yrange(2), density);
    [X,Y] = meshgrid(x_vals, y_vals);

    %% 4. Evaluate gradient
    U = gradX(X,Y);  % d f / dx
    V = gradY(X,Y);  % d f / dy

    %% 5. Optional: normalize arrows for nicer visualization
    % Compute magnitude
    M = sqrt(U.^2 + V.^2);
    % Avoid division by zero
    M(M==0) = 1;
    % Normalize to unit vectors
    U_unit = U ./ M;
    V_unit = V ./ M;
    % Scale arrows by magnitude (optional: multiply by factor for visibility)
    scale = 0.001;  
    U_plot = U_unit .* M * scale;
    V_plot = V_unit .* M * scale;

    %% 6. Plot
    figure; hold on; axis equal; grid on;
    xlabel('x'); ylabel('y'); title('Gradient Flow');

    % Plot contour of f for reference
    Zfunc = matlabFunction(f, 'Vars', [x y]);
    Z = Zfunc(X,Y);
    contour(X,Y,Z,20,'LineColor','k');

    % Plot gradient arrows
    quiver(X,Y,U_plot,V_plot,0,'r','LineWidth',1.5,'MaxHeadSize',0.25);

    hold off
end
```

### Directional Derivative

```m
function plotDirectionalDerivative(f)
    % plotDirectionalDerivative2D
    % f: symbolic 2D function f(x,y)
    % Plots 2D vectors at each point representing the directional derivative
    % The vector points in the gradient direction, length = magnitude of gradient

    %% 1. Symbols
    syms x y

    %% 2. Gradient
    gradf = gradient(f, [x y]);
    gradX = matlabFunction(gradf(1), 'Vars', [x y]);
    gradY = matlabFunction(gradf(2), 'Vars', [x y]);

    %% 3. Create mesh
    x_range = linspace(-5,5,100);
    y_range = linspace(-5,5,100);
    [X,Y] = meshgrid(x_range, y_range);

    %% 4. Evaluate gradient at mesh points
    U = gradX(X,Y)/100;  % vector component in x
    V = gradY(X,Y)/100;  % vector component in y

    %% 5. 2D quiver plot
    figure;
    quiver(X, Y, U, V, 1, 'r', 'LineWidth', 1.5, 'MaxHeadSize', 0.25);
    axis equal;
    grid on;
    xlabel('x'); ylabel('y');
    title('Directional Derivative Vectors (Gradient Direction)');

    %% 6. Optional: contour plot overlay for reference
    Z = matlabFunction(f,'Vars',[x y]);
    hold on;
    contour(X,Y,Z(X,Y), 20, 'LineColor','k');
    hold off;
end

```

### Random Figure

```m
function fig = Plot_Figure(x, y, x_title, y_title, fig_title, fig_name, av, av_title)

    figure;
    plot(x, y, 'LineWidth', 1.5);
    hold on;

    % Optional average / constant value plot
    if nargin >= 7 && ~isempty(av)
        plot(x, av * ones(size(x)), '--', 'LineWidth', 1.5);
        if nargin >= 8 && ~isempty(av_title)
            legend('Data', av_title, 'Location', 'best');
        else
            legend('Data', 'Constant value', 'Location', 'best');
        end
    end

    title(fig_title);
    xlabel(x_title);
    ylabel(y_title);
    grid on;

    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    ax.Box = 'off';

    png_name = fig_name + '.png';
    pdf_name = fig_name + '.pdf';
    exportgraphics(gcf, png_name, 'Resolution', 300);
    exportgraphics(gcf, pdf_name, 'ContentType', 'vector');

    fig = 'Figure created';
end
```
