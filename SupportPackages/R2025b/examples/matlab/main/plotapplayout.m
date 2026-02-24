function fig = plotapplayout
% Create figure window
fig = uifigure;

% Create UI components
ax = uiaxes(fig,Position=[15 70 535 340]);
lbl = uilabel(fig,Position=[30 15 110 35],Text="Plot Type:");
b1 = uibutton(fig,Position=[150 15 180 35],Text="Surf");
b2 = uibutton(fig,Position=[350 15 180 35],Text="Mesh");

% Configure UI components
surf(ax,peaks);
title(ax,"Peak Surface")
fontname(fig,"Times")
end