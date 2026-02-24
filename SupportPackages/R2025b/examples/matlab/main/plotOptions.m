function plotOptions
fig = uifigure;
g = uigridlayout(fig);
g.RowHeight = {'1x','fit','1x'};
g.ColumnWidth = {'1x','fit'};

ax = uiaxes(g);
ax.Layout.Row = [1 3];
ax.Layout.Column = 1;

x = linspace(-2*pi,2*pi);
y = sin(x);
p = plot(ax,x,y,"Color","#F00");

dd = uidropdown(g, ...
    "Items",["Red","Yellow","Blue","Green"], ...
    "ItemsData", ["#F00" "#FF0" "#00F" "#0F0"], ...
    "ValueChangedFcn",@(src,event) updatePlot(src,p));
dd.Layout.Row = 2;
dd.Layout.Column = 2;
end

function updatePlot(src,p)
val = src.Value;
p.Color = val;
end

