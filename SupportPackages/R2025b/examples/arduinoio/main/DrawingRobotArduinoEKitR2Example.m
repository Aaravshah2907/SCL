%% Drawing Robot Using Arduino Engineering Kit Rev 2
% This example shows how to use Arduino(R) Engineering Kit Rev 2 to build and program a robot that extracts line traces from an image 
% and reproduces it as a drawing on a whiteboard. The project uses MATLAB(R) code to capture an image using a webcam, and then convert 
% it into a set of motor commands using image processing techniques, which drive the robot across a whiteboard and reproduce the captured image as a drawing.
%
% The drawing robot is controlled by an Arduino Nano 33 IoT board, interfaced with the Arduino Nano Motor Carrier, two DC motors with encoders, 
% and a micro-servo motor. The drawing robot has two different colored markers
% that can be raised and lowered by means of the servo motor. The two DC
% motors helps the drawing robot navigate over the whiteboard.
%
% <<../aek_drawing_robot.png>>

% Copyright 2021 The MathWorks, Inc.

%% Required Products
%
% * MATLAB Support Package for Arduino Hardware
% * MATLAB Support Package for USB Webcams
% * Image Processing Toolbox(TM)
% * Control System Toolbox(TM)
%
%% Prerequisites
% Before you start exploring the Drawing Robot project, complete
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
%% Assemble the Drawing Robot
% To assemble the drawing robot from the components included in Arduino Engineering Kit Rev 2, watch the video in the *Project
% Overview* section of
% <https://engineeringkit.arduino.cc/aekr2/module/engineering/project/04-drawing-robot Project Drawing Robot>.
%% Project files for Drawing Robot
% The required files for Drawing Robot project are
% downloaded and installed as part of the MATLAB Support Package for Arduino Hardware installation. You
% can find these files in the folder _aekrev2projectfiles.instrset_. Use this MATLAB command to view and access the files:
%
%  fullfile(matlabshared.supportpkg.getSupportPackageRoot, '3P.instrset', 'aekrev2projectfiles.instrset')
%
% The _DrawingRobot_ subfolder in this main folder (_aekrev2projectfiles.instrset_) contains the files described in the detailed
% workflow at 
% <https://engineeringkit.arduino.cc/aekr2/module/engineering/project/04-drawing-robot Project Drawing Robot>.
%
%% See also
% * <docid:mlsupportpkg#mw_1e86d1b2-6e59-4742-af3f-32f0eb29423e>
