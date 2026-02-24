%% Face Detection Using Parrot FPV Drones
% 
% This example shows how to use a Parrot(R) drone to automatically detect human 
% faces captured by the drone's FPV camera. 
% 
%% Introduction
%
% Use the MATLAB(R) Support Package for Parrot(R) Drones to control the 
% drone and capture images from the FPV camera. A cascade object detector uses 
% the Viola-Jones detection algorithm and a trained classification model for face 
% detection. By default, the detector is configured to detect faces, but it can 
% be used to detect other types of objects.

% Copyright 2019 The MathWorks, Inc.

%% Required MathWorks Products
%
% * MATLAB(R)
% * MATLAB(R) Support Package for Parrot(R) Drones
% * Computer Vision Toolbox(TM)
%
%% Prerequisites
%
% Complete <docid:mlsupportpkg.mw_e6fec931-8264-4d55-9640-de7fcdc2044b
% Getting Started with MATLAB Support Package for Parrot Drones>.
%
%% Required Hardware
%
% To run this example you need:
%
% * A fully charged Parrot FPV drone  
% * A computer with a Wi-Fi(R) connection
%
%% Task 1 - Create a Connection to the Parrot Drone
%
% Create a |parrot| object.
%
%   parrotObj = parrot; 
%
%% Task 2 - Create a Cascade Object Detector Instance
%  
% Create an instance of the cascade object detector to detect faces 
% using the Viola-Jones algorithm.
%
%   detector = vision.CascadeObjectDetector;
%
%% Task 3 - Activate FPV Camera
%  
% Start the drone flight to activate the FPV camera. Move the drone up to 
% sufficient height to capture faces.
%
%   takeoff(parrotObj);     
%   moveup(parrotObj,1);   
%
%% Task 4 - Create a Connection to the Drone's FPV Camera
%
% Use the parrot object from Task 1 to create the connection to the drone's 
% FPV camera.
%
%   camObj = camera(parrotObj,'FPV'); 
%
%% Task 5 - Detect Faces While Traversing a Square Path
% 
% Detect faces while the drone moves forward for 2 seconds along the edge of a square path. 
% 
% *1* Move the drone forward for the default duration of 0.5 seconds for each 
% forward step, ensuring a nonblocking behavior. This enables the drone to 
% capture the image and detect faces while in motion.
%
% *2* Capture a single frame from the drone's FPV camera.
%
% *3* Input the image to the detector, which returns bounding boxes containing the 
% detected objects. The detector performs multiscale object detection on the input 
% image.
%
% *4* Display the image with bounding boxes around faces and the title displaying 
% the number of faces detected.
%
% *5* Turn the drone by pi/2 radians at each square vertex.
% 
%   tOuter= tic;
%   while(toc(tOuter)<=30 && parrotObj.BatteryLevel>20)
%      tInner = tic;
%      % Keep moving the drone for 2 seconds along each square path edge
%      while(toc(tInner)<=2)
%          moveforward(parrotObj);                                                       % Move the drone forward for default time of 0.5 seconds (nonblocking behaviour)
%          picture = snapshot(camObj);                                                   % Capture image from drone's FPV camera
%          bbox = detector(picture);                                                     % Detect faces in image
%          videoOut = insertShape(picture,'Rectangle',bbox,'Color','r','LineWidth',3);   % Insert bounding box into image
%          imshow(picture);                                                              % Show the picture
%          title(sprintf(' %d face(s) detected ',size(bbox,1)));
%          drawnow;
%      end
%      turn(parrotObj,deg2rad(90));                                                      % Turn the drone by pi/2 radians
%   end
%
% *6* Execute steps 1-5 for 30 seconds.
%
% This example shows two faces detected by the drone's FPV camera.
%
% <<../face_detection.png>>
%
%% Task 6 - Land the Drone
%
% Land the drone.
%
%   land(parrotObj);
%
%% Task 7 - Clean Up
%
% When finished clear the connection to the Parrot drone and the FPV camera.
%
%   clear parrotObj;
%   clear camObj;
%
