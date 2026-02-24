function raspi_object_tracking()
% RASPI_OBJECT_TRACKING Runs the object tracking algorithm on Raspberry Pi.
% This function can be deployed to Raspberry Pi and will follow the tracing
% algorithm as specified in raspi_yolov2_detect

% Copyright 2020 The MathWorks, Inc.
%#codegen
imageSize = [224 224 3];     % Input image size for the network

% Initialize servo parameters
servoIncrement   = 5;        % Rate at which the position of servo should change
servoPinNumber   = 7;        % GPIO7 for servo control
servoPos         = 90;       % Initial position of the servo motor
MinPulseDuration = 1e-3;     % Minimum pulse duration for the servo motor
MaxPulseDuration = 2e-3;     % Maximum pulse duration for the servo motor

% Create raspi and other hardware peripheral objects
raspiObj      = raspi;
cameraObj     = cameraboard(raspiObj);
servoObj      = servo(raspiObj, servoPinNumber,...
                      'MaxPulseDuration',MaxPulseDuration,...
                      'MinPulseDuration', MinPulseDuration);
writePosition(servoObj,servoPos);

% Main loop
start = tic;
while true
    %Capture image from webcam
    img = snapshot(cameraObj);
    
    elapsedTime = toc(start);
    %Process frames at every 0.25 seconds
    if elapsedTime > 0.25
        %Resize the image
        imgSizeAdjusted     = imresize(img,imageSize(1:2));
        [img, posIncFactor] = raspi_yolov2_detect(imgSizeAdjusted);
        servoPos = servoPos + (servoIncrement*posIncFactor);
        servoPos = max(servoPos,0);
        servoPos = min(servoPos,180);
        writePosition(servoObj,servoPos);
    end

    displayImage(raspiObj,img);
end
end