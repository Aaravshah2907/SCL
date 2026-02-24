function editFieldApp
fig = uifigure;
gl = uigridlayout(fig);
gl.RowHeight = {'1x',150,'fit','1x'};
gl.ColumnWidth = {'1x',150,'1x'};

g = uigauge(gl,"Limits",[0 10]);
g.Layout.Row = 2;
g.Layout.Column = 2;

ef = uieditfield(gl,"numeric", ...
    "Limits",[0 10], ...
    "ValueChangedFcn",@(src,event) editFieldValueChanged(src,event,g));
ef.Layout.Row = 3;
ef.Layout.Column = 2;
end

function editFieldValueChanged(src,event,g)
g.Value = src.Value;
end