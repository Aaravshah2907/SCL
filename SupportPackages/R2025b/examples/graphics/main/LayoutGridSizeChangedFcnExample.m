%% Colorbar That Adjusts as Tiles Reflow
%
% Tiled chart layouts have a |GridSizeChangedFcn| callback, which you can
% use to execute code when the size of the grid changes.
% Typically, you define this callback for layouts that have the |"flow"|
% tile arrangement. 
%
% For example, define a callback function in a program file called
% |updateColorbar.m|. The function moves a colorbar between the south and 
% east tiles of a layout depending on whether the number of rows is greater than the number 
% of columns in the layout's grid. The |event| argument provides the current grid size.
%
% <include>updateColorbar.m</include>
%

% Copyright 2022 The MathWorks, Inc.

%%
% In the Command Window, create a tiled chart layout with the |"flow"| tile arrangement, and 
% set the |GridSizeChangedFcn| property to the |updateColorbar| function. 
% Create a |for| loop that adds seven plots to the layout. Then add a colorbar to the east tile.

f = figure;
tcl = tiledlayout(f,"flow",TileSpacing="tight", ...
    GridSizeChangedFcn=@updateColorbar);

for i = 1:7
    nexttile;
    pcolor(rand(20))
end

cb = colorbar;
cb.Layout.Tile = "east";
%%
% Change the size of the figure so that the tiles reflow. The colorbar moves to the south tile.

f.Position(3:4) = [400 525];

% Copyright 2022 The MathWorks, Inc.