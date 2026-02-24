%% Rotate Camera Along Circle Around Axes
% Rotate in the camera coordinate system to orbit the camera around the axes 
% along a circle while keeping the center of a circle at the camera target.

surf(peaks)
axis vis3d

for i=1:36
   camorbit(10,0,'camera')
   drawnow
end

%% 
% Copyright 2012 The MathWorks, Inc.