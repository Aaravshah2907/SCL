function results = taylor2_func_vals(f_sym, x0, y0, xn, h_vals, exact_fun)
    % taylor2_func_vals : 2nd-order Taylor method using symbolic differentiation
    %
    % Inputs:
    %   f_sym    - symbolic expression of f(x,y)
    %   x0, y0   - initial values
    %   xn       - final x
    %   h_vals   - (optional) step sizes
    %   exact_fun- (optional) exact solution
    %
    % Example: f_sym = (1+x)*y^2;

    syms x y

    % Default h values
    if nargin < 5 || isempty(h_vals)
        h_vals = [0.1, 0.075, 0.05, 0.025];
    end
    
    use_exact = (nargin == 6);

    % Compute derivatives
    fx = diff(f_sym, x);
    fy = diff(f_sym, y);

    f2_sym = fx + fy*f_sym;

    f = matlabFunction(f_sym, 'Vars' , [x y]);
    f2 = matlabFunction(f2_sym, 'Vars' , [x y]);

    colors = lines(length(h_vals));
    results = struct;
    
    figure; hold on;
    
    errors = zeros(length(h_vals),1);

    for k = 1:length(h_vals)
        h = h_vals(k);
        N = round((xn-x0)/h); % Number of Iterations required to perform the calcn

        x_curr = x0;
        y_curr = y0;
        x_vals = zeros(N+1,1);
        y_vals = zeros(N+1,1);

        x_vals(1) = x_curr;
        y_vals(1) = y_curr;

        for i = 1:N
            y_curr = y_curr + h*f(x_curr, y_curr) + (h^2/2)*f2(x_curr, y_curr);
            x_curr = x_curr +h;
            x_vals(i+1) = x_curr;
            y_vals(i+1) = y_curr;
        end

        results(k).h = h;
        results(k).x = x_vals;
        results(k).y = y_vals;

        plot(x_vals, y_vals, '-o', 'Color', colors(k,:), ...
        'DisplayName', ['h = ' num2str(h)]);
    
        % Error
        if use_exact
            exact_val = exact_fun(xn);
            errors(k) = abs(y_vals(end) - exact_val);
        end
    end

    % Plot exact
    if use_exact
        x_fine = linspace(x0, xn, 100);
        plot(x_fine, exact_fun(x_fine), 'k', 'LineWidth', 2, ...
            'DisplayName', 'Exact');
    end

    xlabel('x'); ylabel('y');
    title('2nd Order Taylor Method (Symbolic)');
    legend show;
    grid on;
    
    % Error plot
    if use_exact
        figure;
        plot(h_vals, errors, 'o-r','LineWidth',2);
        xlabel('Step size h');
        ylabel('Error');
        title('Error vs Step Size');
        grid on;
        
        for k = 1:length(h_vals)
            results(k).error = errors(k);
        end
    end

end