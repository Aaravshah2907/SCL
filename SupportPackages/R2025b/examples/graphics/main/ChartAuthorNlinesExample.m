%% Chart Class with Variable Number of Lines
% This example shows how to define a class of charts that can display
% any number of lines based on the size of the user's data. The chart displays
% as many lines as there are columns in the |YData| matrix. For each line,
% the chart calculates the local extrema and indicates their locations
% with circular markers. The following code demonstrates how to:
%
% * Define two properties called |PlotLineArray| and |ExtremaArray| that store
% the objects for the lines and the markers, respectively.
% * Implement an |update| method that replaces the contents of the 
% |PlotLineArray| and |ExtremaArray| properties with the new objects. 
% Because this method executes all the plotting and configuration commands,
% the |setup| method is empty. This is a simple way to create any number of lines. 
% To learn how to create this chart more efficiently, by reusing existing line objects,
% see <docid:creating_plots#mw_18ddfe72-69ff-4f45-812e-4bcf85a670e9>.
%
% To define the class, copy this code into the editor and save it 
% with the name |LocalExtremaChart.m| in a writable folder. 
%
% <include>LocalExtremaChart.m</include>
%
%%
% After saving the class file, you can create an instance of the chart.
% For example: 

x = linspace(0,3);
y1 = cos(5*x)./(1+x.^2);
y2 = -cos(5*x)./(1+x.^3);
y3 = sin(x)./2;
y = [y1' y2' y3'];
c = LocalExtremaChart('XData',x,'YData',y);

%%
% Change the marker size to |8|.
c.MarkerSize = 8;

% Copyright 2019 The MathWorks, Inc.
