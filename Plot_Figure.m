function fig = Plot_Figure(x, y, x_title, y_title, fig_title, fig_name, av, av_title)

    figure;
    plot(x, y, 'LineWidth', 1.5);
    hold on;

    % Optional average / constant value plot
    if nargin >= 7 && ~isempty(av)
        plot(x, av * ones(size(x)), '--', 'LineWidth', 1.5);
        if nargin >= 8 && ~isempty(av_title)
            legend('Data', av_title, 'Location', 'best');
        else
            legend('Data', 'Constant value', 'Location', 'best');
        end
    end

    title(fig_title);
    xlabel(x_title);
    ylabel(y_title);
    grid on;

    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    ax.Box = 'off';

    png_name = fig_name + '.png';
    pdf_name = fig_name + '.pdf';
    exportgraphics(gcf, png_name, 'Resolution', 300);
    exportgraphics(gcf, pdf_name, 'ContentType', 'vector');

    fig = 'Figure created';
end
