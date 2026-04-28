function Interpolation_Hermite_Plot(x,y,dy, x_marks,xq)
    if nargin < 5
        xq = linspace(min(x),max(x), 20);
    end
    yq_smooth = Interpolation_Hermite(x, y, dy, xq);
    y_marks = Interpolation_Hermite(x, y, dy, x_marks);
    
    % Plotting
    figure; hold on;
    plot(xq, yq_smooth, 'b-', 'LineWidth', 1.5);
    plot(x, y, 'ro', 'MarkerFaceColor', 'r', 'DisplayName', 'Original Data');
    plot(x_marks, y_marks, 'ks', 'MarkerSize', 10, 'DisplayName', 'New Marks');
    grid on;
    title('Hermite Interpolation');
    legend('Location','northeastoutside');
end