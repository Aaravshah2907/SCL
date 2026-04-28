function Interpolation_Lagrange_Plot(x,y,xmarks,xq)
    if nargin < 4
        xq = linspace(min(x),max(x),25);
    end
    yq = Interpolation_Lagrange(x,y,xq);
    ymarks = Interpolation_Lagrange(x,y,xmarks);
    plot(x, y, 'ro', 'MarkerSize', 10, 'LineWidth', 2); hold on;
    plot(xq, yq, 'b-', 'LineWidth', 1.5);
    plot(xmarks,ymarks,'go','MarkerSize',9, 'LineWidth', 2);
    grid on;
    title('Lagrange Interpolation');
    legend('Data Points', 'Interpolating Polynomial');
end