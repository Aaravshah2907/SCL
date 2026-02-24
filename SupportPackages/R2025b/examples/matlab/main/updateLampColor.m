function updateLampColor
fig = uifigure("Position",[100 100 150 300]);
g = uigridlayout(fig);
g.RowHeight = {'1x','fit'};
g.ColumnWidth = {'1x'};

lmp = uilamp(g);

s = uiswitch(g,"rocker");
s.Items = ["Go","Stop"];
s.ValueChangedFcn = @(src,event) updateLamp(src,event,lmp);
end

function updateLamp(src,event,lmp)
val = src.Value;
switch val
    case "Go"
        lmp.Color = "green";
    case "Stop"
        lmp.Color = "red";
end
end
