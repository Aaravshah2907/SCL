%% Example: Chart Containing Geographic and Cartesian Axes
% This example shows how to define a class of charts for visualizing
% geographic and categorical data using two axes.
% The left axes contains a map showing the locations of several cellular towers.
% The right axes shows the distribution of the towers by category.
%
% The following |TowerChart| class definition shows how to:
%
% * Define a public property called |TowerData| that stores a table.
% * Validate the contents of the table using a local function called
% |mustHaveRequiredVariables|.
% * Define two private properties called |MapAxes| and |HistogramAxes| that
% store the axes. 
% * Implement a |setup| method that gets the |TiledChartLayout| object,
% specifies the grid size of the layout, and positions the axes.
%
% To define the class, copy this code into the editor and save it 
% with the name |TowerChart.m| in a writable folder.
%
% <include>TowerChart.m</include>
%
%%
% After saving the class file, load the table stored in
% |cellularTowers.mat|. Then create an instance of the chart by passing the
% table to the |TowerChart| constructor method as a name-value pair argument.

load cellularTowers.mat
TowerChart('TowerData',cellularTowers);

% Copyright 2019 The MathWorks, Inc.