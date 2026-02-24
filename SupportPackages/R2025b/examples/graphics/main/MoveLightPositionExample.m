%% Move Light Position
% Create a surface. Add a light and move the position of the light.

surf(peaks)
axis vis3d
h = light;
for az = -50:10:50
   lightangle(h,az,30)
   pause(.1)
end

%% 
% Copyright 2012 The MathWorks, Inc.