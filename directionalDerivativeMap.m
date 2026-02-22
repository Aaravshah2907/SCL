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
