function fig = myapplayout
% Create figure window
fig = uifigure;

% Create UI components
ax = uiaxes(fig,Position=[15 70 535 340]);
lbl = uilabel(fig,Position=[30 15 100 35],Text="Choose Plot Type:");
b1 = uibutton(fig,Position=[140 15 180 35],Text="Surf");
b2 = uibutton(fig,Position=[350 15 180 35],Text="Mesh");

% Configure UI component appearance
surf(ax,peaks);
fontsize(fig,8,"pixels")
title(ax,"Peak Surface",FontSize=11)
end