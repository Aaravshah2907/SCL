%% Chart That Supports Light and Dark Themes
% Define a class named |ThemedSmoothPlot| that plots a set of data using a 
% faint line as well as a smoothed version of the same data using a bolder line. 
%
% To define the class, create a file named |ThemedSmoothPlot.m| that contains 
% the following class definition with these features:
%
% * |XData| and |YData| public properties that store the _x_- and _y_-coordinate data for the original line
% * |SmoothWidth| public property that controls the width of the smooth line
% * |OriginalLine| and |SmoothLine| private properties
% that store the |Line| objects for the original and smoothed data
% * A |setup| method that initializes |OriginalLine| and |SmoothLine|
% * An |update| method that updates the plot when the user changes the value of a property
% * A |createSmoothData| method that calculates a smoothed version of
% |YData|
% * An |updateColor| method that selects plot colors based on the theme of the figure 
%
% <include>ThemedSmoothPlot.m</include>
%
%%
% Create a light-themed figure. Then plot pair of |x| and |y| vectors
% by calling the |ThemedSmoothPlot| constructor method and specifying the |XData| and |YData| 
% name-value arguments. 

f = figure(Theme="light");
f.Position(3:4) = [695 420];
x = 1:1:100;
y = 10*sin(x./5) + 8*sin(10.*x + 0.5);
ThemedSmoothPlot(XData=x,YData=y);

%%
% Change the theme of the figure to |"dark"|. The line colors update in
% response.

theme(gcf,"dark")

% Copyright 2024 The MathWorks, Inc.

