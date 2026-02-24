function plotApp
fig = uifigure;
g = uigridlayout(fig,[2 3]);
g.RowHeight = {'1x','fit'};
g.ColumnWidth = {'1x','fit','1x'};


ax = uiaxes(g);
ax.Layout.Row = 1;
ax.Layout.Column = [1 3];
b = uibutton(g, ...
    "Text","Plot Data", ...
    "ButtonPushedFcn", @(src,event) plotButtonPushed(ax));
b.Layout.Row = 2;
b.Layout.Column = 2;
end

function plotButtonPushed(ax)
x = linspace(0,2*pi,100);
y = sin(x);
plot(ax,x,y)
end
