function imageApp
fig = uifigure;
g = uigridlayout(fig,[2 3]);
g.RowHeight = {22,'1x'};
g.ColumnWidth = {'1x','fit','1x'};

dd = uidropdown(g, ...
    "Editable","on", ...
    "Items",["peppers.png","street1.jpg"]);
dd.Layout.Row = 1;
dd.Layout.Column = 2;

im = uiimage(g,"ImageSource","peppers.png");
im.Layout.Row = 2;
im.Layout.Column = [1 3];

dd.ValueChangedFcn = @(src,event)updateImage(src,event,im,fig);
end

function updateImage(src,event,im,fig)
val = src.Value;
if event.Edited && ~exist(val,"file")
    im.ImageSource = "";
    uialert(fig,"Enter a file on the MATLAB path","Invalid Image")
else
    im.ImageSource = val;
end
end
