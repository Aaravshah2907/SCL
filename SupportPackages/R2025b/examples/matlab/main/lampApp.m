function lampApp
fig = uifigure(Position=[100 100 200 300]);
g = uigridlayout(fig,[2,1]);
g.RowHeight = {'fit','1x'};
btn = uibutton(g,Text="Calculate");
lmp = uilamp(g,Color="green");
btn.ButtonPushedFcn=@(src,event) calc(lmp);
end

function calc(lamp)
lamp.Color = "red";
drawnow
svd(rand(4000));
lamp.Color = "green";
drawnow
end