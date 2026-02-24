%% Chart Class That Supports |title|, |xlim|, and |ylim| Functions
% This example shows how to define a class of charts that
% supports the |title|, |xlim|, and |ylim| functions. The following code 
% demonstrates how to:
%
% * Define a |TitleText| property and implement a |title| method so that 
%   instances of the chart support the |title| function.
% * Implement the |xlim| and |ylim| methods so that instances of the chart support the
%   |xlim| and |ylim| functions.
% * Define properties that allow the user to get and set the
%   _x_- and _y_-axis limits.
% * Combine |Bar| and |ErrorBar| objects into a single chart. 
%
% To define the class, copy this code into the editor and save it
% with the name |BarErrorBarChart.m| in a writable folder.
%
% <include>BarErrorBarChart.m</include>
%
%%
% After saving |BarErrorBarChart.m|, create an instance of the chart. 

BarErrorBarChart('XData',[1 2 3 4],'YData',[11 22 31 41],'EData',[2 2 2 2]);

%%
% Specify a title by calling the |title| function. Then zoom into the 
% last three bars by calling the |xlim| function.

title('Top Three Contributors')
xlim([1.5 5])

% Copyright 2019 The MathWorks, Inc.