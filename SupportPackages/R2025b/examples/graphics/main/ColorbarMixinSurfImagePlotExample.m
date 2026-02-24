%% Surface Plot With Image and Colorbar
% Define a class named |SurfImagePlot| that displays a surface with an image underneath it.
%
% To define the class, create a file named |SurfImagePlot.m| that contains the following code. 
% The |setup| method for this class performs these tasks: 
%
% * Creates a |Surface| object with an offset on the |ZData| to provide enough space to display the image
% * Creates an |Image| object
% * Configures the axes
% * Makes the colorbar visible by setting the |ColorbarVisible| property to |'on'|
%
% <include>SurfImagePlot.m</include>
%
%%
% Next, define matrix |Z| as the _z_-coordinates of a surface. Plot |Z| by calling 
% the |SurfImagePlot| constructor method, which is provided by the |ChartContainer| class. 
% Specify the |'ZData'| name-value pair argument and return the object as |c|.

[X,Y] = meshgrid(-10:1:10);
Z = X.^2 + Y.^2;
c = SurfImagePlot('ZData',Z)

%%
% Use |c| to change the colormap to |cool|.

c.Colormap = cool;

% Copyright 2019 The MathWorks, Inc.