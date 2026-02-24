%% Image Classification Using Parrot FPV Drones
%
% This example shows you how to use the MATLAB&reg; Support Package for Parrot&reg; Drones 
% to classify images captured by the drone's FPV camera.
% 
%% Introduction
%
% The MATLAB Support Package for Parrot Drones enables you to control the 
% Parrot drone and capture images from the first-person view (FPV) camera. 
% The images captured by the drone's FPV camera can be classified using <https://www.mathworks.com/matlabcentral/fileexchange/64456-deep-learning-toolbox-model-for-googlenet-network GoogLeNet>, 
% a pretrained deep convolutional neural network. GoogLeNet is trained on 
% more than a million images from the <https://image-net.org/ ImageNet> database. 
% It takes the image as input and provides a label for the object in the image.

% Copyright 2019 The MathWorks, Inc.
%% Prerequisites
%
% Complete <docid:mlsupportpkg.mw_e6fec931-8264-4d55-9640-de7fcdc2044b
% Getting Started with MATLAB Support Package for Parrot Drones>.
%
%% Required Hardware
%
% To run this example, you need: 
%
% * A fully charged Parrot FPV drone  
% * A computer with a Wi-Fi(R) connection
%
%% Task 1 &mdash; Create a Connection to the Parrot Drone
%
% Create a |parrot| object.
%
%    parrotObj = parrot; 
%
%% Task 2 &mdash; Create the GoogLeNet Neural Network Object
%
% Create a GoogLeNet neural network object.
%
%    nnet = googlenet; 
%
%% Task 3 &mdash; Activate FPV Camera
%
% Start the drone flight and activate the FPV camera.
%
%    takeoff(parrotObj);
%
% Create a connection to the drone's FPV camera.
%
%    camObj = camera(parrotObj, 'FPV'); 
%
%% Task 4 &mdash; Capture and Classify the Object in the Image
% 
% Move the drone forward for 2 seconds along the edges of a square path. Capture 
% the image of an object. Classify the image while the drone moves forward.
%
% 1. Move the drone forward for the default duration of 0.5 seconds for each 
% forward step, ensuring a nonblocking behavior. This enables the drone to 
% capture the image and classify it while in motion.
%
% 2. Capture a single frame from the drone's FPV camera.
%
% 3. Resize the image and classify the object in image using the neural
% network.
%
% 4. Display the image with title as the label returned by the classify 
% function.
%
% 5. Turn the drone by &pi;/2 radians at each square vertex.
%
%    tOuter= tic;
%    while(toc(tOuter)<=30 && parrotObj.BatteryLevel>20)
%       tInner = tic;
%       % Keep moving the drone for 2 seconds along each square path edge
%       while(toc(tInner)<=2)
%          moveforward(parrotObj);                        % Move the drone forward for default time of 0.5 seconds (nonblocking behavior)
%          picture = snapshot(camObj);                    % Capture image from drone's FPV camera
%          resizedPicture = imresize(picture,[224,224]);  % Resize the picture
%          label = classify(nnet,resizedPicture);         % Classify the picture
%          imshow(picture);                               % Show the picture
%          title(char(label));                            % Show the label
%          drawnow;
%       end
%       turn(parrotObj,deg2rad(90));                       % Turn the drone by pi/2 radians
%    end
%
% 6. Execute steps 1&#8211;5 for 30 seconds.
%
% For example, the drone classifies a monitor screen as captured by the FPV camera.
%
% <<../alexnet_monitor.png>>
%
%% Task 5 &mdash; Land the Drone
%
% Land the drone.
%
%    land(parrotObj);
%
%% Task 6 &mdash; Clean Up
%
% When finished, clear the connection to the Parrot drone, the FPV camera, and GoogLeNet. 
%
%    clear parrotObj;
%    clear camObj;
%    clear nnet;
%