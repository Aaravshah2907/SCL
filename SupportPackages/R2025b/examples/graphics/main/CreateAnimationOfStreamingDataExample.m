%% Create Animation of Streaming Data
% Create an animation of a line growing as it accumulates 2,000 data points. 
% Use |drawnow| to display the changes on the screen after each iteration through 
% the loop. 

h = animatedline;
axis([0 4*pi -1 1])
x = linspace(0,4*pi,2000);

for k = 1:length(x)
    y = sin(x(k));
    addpoints(h,x(k),y);
    drawnow
end
%% 
% Copyright 2015-2017 The MathWorks, Inc.
