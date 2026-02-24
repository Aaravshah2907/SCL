function toggleLegendApp
fig = uifigure;
g = uigridlayout(fig,[2 3]);
g.RowHeight = {'1x','fit'};
g.ColumnWidth = {'1x','fit','1x'};

ax = uiaxes(g);
ax.Layout.Row = 1;
ax.Layout.Column = [1 3];
plot(ax,magic(3));
lgd = legend(ax,"hide");
cbx = uicheckbox(g,"Text","Show legend");
cbx.Layout.Row = 2;
cbx.Layout.Column = 2;

cbx.ValueChangedFcn = @(src,event) checkBoxChanged(src,event,lgd);
end

function checkBoxChanged(src,event,lgd)
val = event.Value;
lgd.Visible = val;
end