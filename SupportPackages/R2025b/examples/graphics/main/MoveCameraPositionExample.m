%% Move Camera Position
% Move the camera along the _x_-axis in a series of steps.

surf(peaks)
axis vis3d off
for x = -200:5:200
    campos([x,5,10])
    drawnow
end

%% 
% Copyright 2012 The MathWorks, Inc.