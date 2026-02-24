%% Set Maximum Number of Points
% Limit the number of points in the animated line to 100. Use a loop to add 
% one point to the line at a time. When the line contains 100 points, adding a 
% new point to the line deletes the oldest point.

h = animatedline('MaximumNumPoints',100);
axis([0,4*pi,-1,1])

x = linspace(0,4*pi,1000);
y = sin(x);
for k = 1:length(x)
    addpoints(h,x(k),y(k));
    drawnow
end
%% 
% Copyright 2015 The MathWorks, Inc.
