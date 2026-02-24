function textAreaApp
fig = uifigure;
g = uigridlayout(fig,[3 3]);
g.RowHeight = {'fit','fit','fit'};
g.ColumnWidth = {'1x','fit','1x'};

lbl = uilabel(g,"Text","Enter Comments:");
lbl.Layout.Row = 1;
lbl.Layout.Column = 2;
txa = uitextarea(g);
txa.Layout.Row = 2;
txa.Layout.Column = 2;
btn = uibutton(g,"Text","Submit","Enable","off");
btn.Layout.Row = 3;
btn.Layout.Column = 2;

txa.ValueChangedFcn = @(src,event) textEntered(src,event,btn);
end

function textEntered(src,event,btn)
val = src.Value;
btn.Enable = "off";
% Check each element of text area cell array for text
for k = 1:length(val)
    if ~isempty(val{k})
        btn.Enable = "on";
        break
    end
end
end
