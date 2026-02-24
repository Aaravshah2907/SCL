%% Rotate Camera About View Axis
% Rotate the camera around the viewing axis. 

surf(peaks)
axis vis3d
for i = 1:36
	camroll(10)
	drawnow
end

%% 
% Copyright 2012 The MathWorks, Inc.