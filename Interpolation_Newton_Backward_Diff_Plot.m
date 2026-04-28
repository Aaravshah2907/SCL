function Interpolation_Newton_Backward_Diff_Plot(x,y,x_marks,xq)
    if nargin < 4
        xq = linspace(min(x),max(x), 20);
    end
    yq_smooth = Interpolation_Backward_Diff(x, y, xq);
    y_marks = Interpolation_Backward_Diff(x, y, x_marks);
    
    % Plotting
    figure; hold on;
    plot(xq, yq_smooth, 'b-', 'LineWidth', 1.5);
    plot(x, y, 'ro', 'MarkerFaceColor', 'r', 'DisplayName', 'Original Data');
    plot(x_marks, y_marks, 'ks', 'MarkerSize', 10, 'DisplayName', 'New Marks');
    grid on;
    title('Newton''s Backward Difference Interpolation');
    legend('Location','northeastoutside');
end