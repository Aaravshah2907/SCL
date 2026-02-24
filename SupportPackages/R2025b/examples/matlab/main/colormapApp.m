function colormapApp
fig = uifigure;
g = uigridlayout(fig,[3 2]);
g.RowHeight = {'1x','fit','1x'};
g.ColumnWidth = {'fit','1x'};

lb = uilistbox(g, ...
    "Items",["Spring","Summer","Autumn","Winter"], ...
    "ItemsData",{spring,summer,autumn,winter});
lb.Layout.Row = 2;
lb.Layout.Column = 1;
ax = uiaxes(g);
ax.Layout.Row = [1 3];
ax.Layout.Column = 2;
surf(ax,peaks)
colormap(ax,spring)

lb.ValueChangedFcn = @(src,event) listBoxValueChanged(src,event,ax);
end

function listBoxValueChanged(src,event,ax)
cmap = event.Value;
colormap(ax,cmap)
end
