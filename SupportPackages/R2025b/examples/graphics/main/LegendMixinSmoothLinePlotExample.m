%% Smooth Line Plot With Legend
% Define a |SmoothLegendPlot| class that plots a set of data using a dotted 
% blue line with a smoothed version of the line. 
%
% To define the class, create a file named |SmoothLegendPlot.m| that 
% contains the following code. The |setup| method for this class performs these tasks:
%
% * Creates two |Line| objects with the appropriate |DisplayName| values to show in the legend
% * Makes the legend visible by setting the |LegendVisible| property to |'on'|
% * Gets the |Legend| object and customizes the text color, box edge color, and box line width
%
% <include>SmoothLegendPlot.m</include>
%
%%
% Next, create a pair of |x| and |y| vectors. Plot |x| and |y| by calling the |SmoothLegendPlot| 
% constructor method, which is inherited from the |ChartContainer| class. Specify 
% the |'XData'| and |'YData'| name-value pair arguments and return the chart object as |c|. 

x = 1:1:100;
y = 10*sin(x./5)+8*sin(10.*x+0.5);
c = SmoothLegendPlot('XData',x,'YData',y);

%%
% Use |c| to change the color of the smooth line to red. Notice that the legend also shows the new line color.

c.SmoothColor = [1 0 0];

% Copyright 2019 The MathWorks, Inc.
