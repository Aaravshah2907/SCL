function fig = Plot_Figure(x, y, x_title, y_title, fig_title, fig_name)
    figure;
    plot(x,y);
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
    fig = 'Figure created'
end