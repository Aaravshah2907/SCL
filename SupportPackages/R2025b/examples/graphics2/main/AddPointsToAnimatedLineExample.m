%% Add Points Within Loop to Animated Line
% Create an animated line using the |animatedline| function. Then, add points 
% to the line within a loop to create an animation. Set the axis limits before 
% the loop to prevent the limits from changing.

figure
h = animatedline;
axis([0 4*pi -1 1])

for x = linspace(0,4*pi,10000)
    y = sin(x);
    addpoints(h,x,y)
    drawnow limitrate
end
%% 
% Copyright 2015 The MathWorks, Inc.
