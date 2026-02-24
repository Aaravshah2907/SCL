%% Rotate Camera Target
% Move the camera target to pan the object in a circular motion.

sphere;
axis vis3d
hPan = sin(-pi:1:pi);
vPan = cos(-pi:1:pi);
for k = 1:length(hPan)
   campan(hPan(k),vPan(k))
   pause(.1)
end

%% 
% Copyright 2012 The MathWorks, Inc.