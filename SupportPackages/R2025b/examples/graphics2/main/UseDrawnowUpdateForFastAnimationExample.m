%% Use drawnow limitrate for Fast Animation
% Use a loop to add 100,000 points to an animated line. Since the number of 
% points is large, using |drawnow| to display the changes might be slow. Instead, 
% use |drawnow limitrate| for a faster animation.

h = animatedline;
axis([0,4*pi,-1,1])
drawnow

numpoints = 100000;
x = linspace(0,4*pi,numpoints);
y = sin(x);
for k = 1:numpoints
    addpoints(h,x(k),y(k))
    drawnow limitrate
end
%% 
% Copyright 2015 The MathWorks, Inc.
