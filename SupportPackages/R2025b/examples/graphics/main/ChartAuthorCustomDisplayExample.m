%% Chart Class with Custom Property Display
% This example shows how to define a class of charts with a 
% custom property display that lists only a subset of the properties. 
% The following code demonstrates how to overload the |getPropertyGroups| method of the 
% |matlab.mixin.CustomDisplay| class. The example also demonstrates 
% the basic coding pattern for charts that derive from the
% |matlab.graphics.chartcontainer.ChartContainer| base class. You can use 
% this example to become familiar with the coding techniques of chart development, or as the
% basis for a class you plan to develop. 
%
% To define the class, copy the following code into the editor and save it
% with the name |SmoothPlotCustomDisplay.m| in a writable folder.
%
% <include>SmoothPlotCustomDisplay.m</include>
%
%%
% After saving the class file, you can create an instance of the chart.
% Omit the semicolon when you create the chart to see the customized display.

x = 1:1:100;
y = 10*sin(x/15)+8*sin(10*x+0.5);
c = SmoothPlotCustomDisplay('XData',x,'YData',y)

% Copyright 2019 The MathWorks, Inc.
