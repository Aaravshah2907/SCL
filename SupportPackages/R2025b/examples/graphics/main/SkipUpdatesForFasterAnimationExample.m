%% Skip Updates for Faster Animation
% Create an animation of a line growing as it accumulates 10,000 points by completing these steps:
%
% * Create an animated line object (|h|) and call the |axis| function to create an axes object with specific _x_- and _y_-axis limits.
% * Call |drawnow| immediately after the |axis| command to complete figure and axes initialization. 
% * Create a |for| loop that adds points to the animated line and updates the plot.
%
% Drawing each update on the screen might be slow since there are 10,000 points. 
% You can make it faster by limiting the number of updates with the |limitrate| option.
% Calling the |drawnow limitrate| command before the end of the loop displays
% the changes, but only if 50 milliseconds has elapsed since the last iteration.
%
% After the loop, display the final updates by calling |drawnow| one more
% time. 

x = linspace(0,4*pi,2000);
h = animatedline;
axis([0 4*pi -1 1])
drawnow  % Complete initialization

for k = 1:length(x)
    y = sin(x(k));
    addpoints(h,x(k),y);
    drawnow limitrate  % Display changes
end

drawnow % Display final updates
%% 
% Copyright 2015 The MathWorks, Inc.
