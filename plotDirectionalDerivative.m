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
