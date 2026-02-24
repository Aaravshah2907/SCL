%% Webcam Controlled Rover Using Arduino Engineering Kit Rev 2
% This example shows how to use Arduino(R) Engineering Kit Rev 2 to program a
% differential drive robot that can be remotely controlled by MATLAB(R) over Wi-Fi(R) to perform operations
% such as path following and moving objects with a forklift along with obstacle avoidance.
%
% The rover is controlled by an Arduino Nano 33 IoT board, that is interfaced to the Arduino Nano Motor Carrier, two DC motors with encoders, 
% and a micro-servo motor. On top of the rover, you will install a color-coded sticker that will serve as a marker and 
% assist the image processing algorithm that uses a webcam to detect the
% location and orientation of the robot, and thereby assist the rover in
% overall trajectory tracking.
%
% <<../aek_webcam_rover.png>>

% Copyright 2021 The MathWorks, Inc.

%% Required Products
%
% * MATLAB Support Package for Arduino Hardware
% * Simulink(R) Support Package for Arduino Hardware
% * Stateflow(R)
% * Image Processing Toolbox(TM)
%
%% Prerequisites
% Before you start exploring the Webcam Controlled Rover project, complete
% these steps:
%
% *1.* Understand the basics of Arduino Engineering Kit Rev 2 and install the tools as described in 
% <https://engineeringkit.arduino.cc/aekr2/module/engineering/lesson/01-unboxing-and-installations
% Unboxing and Installation>. Because you have already installed the MATLAB
% add-on for Arduino hardware (MATLAB Support Package for Arduino
% Hardware), you can proceed with the installation of the other tools.
%
% *2.* Learn how to get started with Arduino environment and the tools, as described in 
% <https://engineeringkit.arduino.cc/aekr2/module/engineering/lesson/02-getting-started-with-arduino-matlab-and-simulink
% Arduino, MATLAB and Simulink>.
%
% *3.* Learn the basics of DC motors, servo motors, IMU (Inertial Measurement Unit), and motor control
% system, as described in 
% <https://engineeringkit.arduino.cc/aekr2/module/engineering/lesson/03-introduction-to-mechatronics
% Basics of Mechatronics>.
%
%% Assemble the Webcam Controlled Rover
% To assemble the webcam controlled rover from the components included in Arduino Engineering Kit Rev 2, watch the video in the *Project
% Overview* section of
% <https://engineeringkit.arduino.cc/aekr2/module/engineering/project/05-webcam-controlled-rover Project Webcam Controlled Rover>.
%
%% Project files for Webcam Controlled Rover
% The required files for Webcam Controlled Rover project are
% downloaded and installed as part of the MATLAB Support Package for Arduino Hardware installation. You
% can find these files in the folder _aekrev2projectfiles.instrset_. Use this MATLAB command to view and access the files:
%
%  fullfile(matlabshared.supportpkg.getSupportPackageRoot, '3P.instrset', 'aekrev2projectfiles.instrset')
%
% The _MobileRover_ subfolder in this main folder (_aekrev2projectfiles.instrset_) contains the files described in the detailed
% workflow at
% <https://engineeringkit.arduino.cc/aekr2/module/engineering/project/05-webcam-controlled-rover Project Webcam Controlled Rover>.
%
%% See also
% * <docid:mlsupportpkg#mw_1e86d1b2-6e59-4742-af3f-32f0eb29423e>