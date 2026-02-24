% OBJECTTRACKINGSETUP - run the script to capture images from a camera
% attached to raspberry Pi. Set the varialbe 'dataCaptureTime' to configure
% the time duration of data collection. After capturing images,
% videoLabeler app will open automatically and user can label desired
% object or ROI.

% Copyright 2020 The MathWorks, Inc

% Set time duration (seconds) for data capture
dataCaptureTime = 30;

% Create raspi obj and camera obj
raspiObj = raspi();
cameraObj = cameraboard(raspiObj);

% Get ground truth data for tarining
dataLocation = getGroundTruthData(cameraObj,dataCaptureTime);

%Use Videolabeler app to mark desired object from the image sequence
videoLabeler(dataLocation);

disp('Use the videoLabeler app and export the label data to objectLabel.mat');
