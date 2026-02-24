%% Move Camera Target
% Move the camera position and the camera target along the _x_-axis in a series 
% of steps.

surf(peaks); 
axis vis3d
xp = linspace(-150,40,50);
xt = linspace(25,50,50);
for i = 1:50
     campos([xp(i),25,5]);
     camtarget([xt(i),30,0])
     drawnow
end

%% 
% Copyright 2012 The MathWorks, Inc.