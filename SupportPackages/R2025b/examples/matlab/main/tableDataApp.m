function tableDataApp
% Create table array
t = readtable("tsunamis.xlsx");
vars = ["Latitude","Longitude","MaxHeight"];
t = t(1:20,vars);

% Create UI figure
fig = uifigure;
fig.Position(3:4) = [722 360];
gl = uigridlayout(fig,[1 2]);

% Create table UI component
uit = uitable(gl);
uit.Data = t;
uit.ColumnSortable = true;
uit.ColumnEditable = [false false true];

% Create bubble chart
ax = geoaxes(gl);
lat = t.Latitude;
long = t.Longitude;
sz = t.MaxHeight;
bubblechart(ax,lat,long,sz)

% Specify table callback
uit.DisplayDataChangedFcn = @(src,event) updatePlot(src,ax);
end


function updatePlot(src,ax)
t = src.DisplayData;
lat = t.Latitude;
long = t.Longitude;
sz = t.MaxHeight;
bubblechart(ax,lat,long,sz)
end