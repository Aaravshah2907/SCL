%% Chart Class Containing Two Interactive Plots
% This example shows how to define a class for visualizing timetable data 
% using two axes with interactive features. The top axes
% has panning and zooming enabled along the _x_ dimension, so the user can examine
% a region of interest. The bottom axes displays a plot over the entire time range. 
% The bottom axes also displays a light blue time window, which indicates 
% the time range in the top axes. The class defines the following properties, 
% methods, and local functions.
%
% Properties:
%
% * |Data| - A public and dependent property that stores a timetable.
% * |TimeLimits| - A public property that sets the limits of the top axes and 
% the width of the time window in the bottom axes.
% * |SavedData| - A protected property that enables the user to save and
% load instances of the chart and preserve the data.
% * |TopAxes| and |BottomAxes| - Private properties that store the axes objects.
% * |TopLine| and |BottomLine| - Private properties that store the line
% objects.
% * |TimeWindow| - A patch object displayed in the bottom axes, which
% indicates the time range of the top axes.
%
% Methods:
%
% * |set.Data| and |get.Data| - Enable the user to save and
% load instances of the chart and preserve the data.
% * |setup| - Executes once when the chart is created. It configures the layout 
% and the axes, the line objects, and the patch object.
% * |update| - Executes after the |setup| method and after the user
% changes one or more properties on the chart.
% * |panZoom| - Updates the time limits of the chart when the user pans or 
% zooms within the top axes. This causes the time window to update to reflect the new limits.
% * |click| - Recalculates the time limits when the user clicks the bottom axes.
%
% Local Functions:
%
% * |updateDataTipTemplate| - Called from within in the |update| method. It creates
% rows in the data tips that correspond to the variables in the timetable.
% * |mustHaveOneNumericVariable| - Validates the
% |Data| property. This function ensures that the timetable specified by the 
% user has at least one numeric variable.
%
% To define the class, copy the following code into the editor and save it
% with the name |TimeTableChart.m| in a writable folder.
%
% <include>TimeTableChart.m</include>
%
%%
% After saving the class file, create an instance of the chart. In this
% case, use the chart to examine a few weeks within a year of 
% bicycle traffic data.

bikeTbl = readtimetable('BicycleCounts.csv');
bikeTbl = bikeTbl(169:8954,:);
tlimits = [datetime(2015,8,6) datetime(2015,8,27)];
TimeTableChart('Data',bikeTbl,'TimeLimits',tlimits);

% Copyright 2019 The MathWorks, Inc.