function standarizePlots(figHandle, axHandle, plotTitle, xAxisLabel, yAxisLabel)
    % Apply the standard style to your plots
    
    % Set the figure properties
    set(figHandle, 'Color', 'w'); % Set figure background to white
    
    % Set the axes properties
    set(axHandle, ...
        'Box', 'off', ... % Turn off the box surrounding the plot
        'TickDir', 'out', ... % Draw ticks pointing outwards
        'LineWidth', 1.5, ... % Set axis line width
        'FontSize', 12, ... % Set font size
        'FontWeight', 'bold', ... % Set font weight
        'FontName', 'Arial'); % Set font name
    
    % Set labels and title
    title(axHandle, plotTitle, 'FontSize', 14, 'FontWeight', 'bold');
    xlabel(axHandle, xAxisLabel, 'FontSize', 12, 'FontWeight', 'bold');
    ylabel(axHandle, yAxisLabel, 'FontSize', 12, 'FontWeight', 'bold');
    
    % Set grid lines
    grid(axHandle, 'on');
end

% Example usage of the standarizePlots function
% Generate some example data
  %x = linspace(0, 2*pi, 100);
  %y = sin(x);

% Create a new figure and plot the data
  %fig = figure;
  %ax = axes(fig);
  %plotHandle = plot(ax, x, y, 'LineWidth', 2);

% Call the standarizePlots function to apply standard formatting
  %standarizePlots(fig, ax, 'Sine Wave', 'Time (s)', 'Amplitude');