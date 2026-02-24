function selectTsunamis
% Load data
t = readtable("tsunamis.xlsx");
vars = ["Latitude","Longitude","MaxHeight"];
t = t(1:20,vars);

% Create UI components
fig = uifigure("Position",[100 100 800 350]);
gl = uigridlayout(fig,[1 2]);
gl.ColumnWidth = {'1x','2x'};
tbl = uitable(gl);
gb = geobubble(gl,[],[]);

% Configure table
tbl.Data = t;
tbl.SelectionType = "row";
tbl.Multiselect = "on";
tbl.SelectionChangedFcn = @(src,event) plotTsunami(src,event,gb);  
end

% Plot tsunami data for each selected row
function plotTsunami(src,event,gb)
rows = event.Selection;
data = src.Data(rows,:);
gb.LatitudeData = data.Latitude;
gb.LongitudeData = data.Longitude;
gb.SizeData = data.MaxHeight;
end