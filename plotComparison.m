function plotComparison(xrange, actual_yvals, approx_yvals)

    figure;
    
    plot(xrange, actual_yvals, 'b-', 'LineWidth', 2); 
    hold on;
    
    plot(xrange, approx_yvals, 'r--', 'LineWidth', 2);
    
    xlabel('x');
    ylabel('y');
    title('Actual vs Approximate Solution');
    
    legend('Actual', 'Approximate');
    grid on;
    
    hold off;

end