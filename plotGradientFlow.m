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
