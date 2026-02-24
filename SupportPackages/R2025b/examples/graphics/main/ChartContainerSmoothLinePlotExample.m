%% Smooth Line Plot
% Define a class called |SmoothPlot| that plots a set of data using a 
% dotted blue line with a smoothed version of the line.
%
% To define the class, create a file called |SmoothPlot.m| that contains 
% the following class definition with these features:
%
% * |XData| and |YData| public properties that store the _x_- and _y_-coordinate data for the original line.
% * |SmoothColor| and |SmoothWidth| public properties that control the color and width of the smooth line.
% * |OriginalLine| and |SmoothLine| private properties
% that store the |Line| objects for original and smoothed data.
% * A |setup| method that initializes |OriginalLine| and |SmoothLine|.
% * An |update| method that updates the plot when the user changes the value of a property.  
% * A |createSmoothData| method that calculates a smoothed version of
% |YData|. 
%
% <include>SmoothPlot.m</include>
%
%%
% Next, create a pair of |x| and |y| vectors. Plot |x| and |y| by calling the |SmoothPlot| 
% constructor method, which is provided by the |ChartContainer| class. 
% Specify the |'XData'| and |'YData'| name-value pair arguments and return the object as |c|. 

x = 1:1:100;
y = 10*sin(x./5) + 8*sin(10.*x + 0.5);
c = SmoothPlot('XData',x,'YData',y);

%%
% Use |c| to change the color of the smooth line to red.

c.SmoothColor = [1 0 0];

% Copyright 2019 The MathWorks, Inc.

