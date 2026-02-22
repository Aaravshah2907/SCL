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
