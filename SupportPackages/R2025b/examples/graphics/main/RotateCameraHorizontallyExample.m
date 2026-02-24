%% Rotate Camera Horizontally
% Rotate the camera horizontally about a line defined by the camera target point 
% and a direction that is parallel to the _y_-axis. Visualize this rotation as 
% a cone formed with the camera target at the apex and the camera position forming 
% the base.

surf(peaks)
axis vis3d

for i = 1:36
   camorbit(10,0,'data',[0 1 0])
   drawnow
end

%% 
% Copyright 2012 The MathWorks, Inc.