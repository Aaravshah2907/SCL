%% Self-Balancing Motorcycle Using Arduino Engineering Kit Rev 2
% This example shows how to use Arduino(R) Engineering Kit Rev 2 to build and program a motorcycle bot that self-balances and maneuvers by itself using a flywheel.
% The project models the motorcycle with the help of inverted pendulum dynamics and performs inertial sensing to balance the motorcycle by controlling the flywheel, 
% located at the center of the motorcycle.
%
% The motorcycle is controlled by an Arduino Nano 33 IoT board, that is interfaced with the Arduino Nano Motor Carrier, a DC motor to move the back wheel, DC motor with Encoder to 
% control the inertia wheel and a standard servo motor to steer the motorcycle handle.
%
% <<../aek_sb_motorcycle.png>>

% Copyright 2021 The MathWorks, Inc.

%% Required Products
%
% * Simulink(R) Support Package for Arduino Hardware
% * Simscape(TM)
% * Simscape(TM) Multibody(TM)
%
%% Prerequisites
% Before you start exploring the Self-Balancing Motorcycle project, complete
% these steps:
%
% *1.* Understand the basics of Arduino Engineering Kit Rev 2 and install the tools as described in 
% <https://engineeringkit.arduino.cc/aekr2/module/engineering/lesson/01-unboxing-and-installations
% Unboxing and Installation>. Because you have already installed the
% Simulink add-on for Arduino hardware (Simulink Support Package for Arduino
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
%% Assemble the Motorcycle
% To assemble the motorcycle from the components included in Arduino Engineering Kit Rev 2, watch the video in the *Project
% Overview* section of
% <https://engineeringkit.arduino.cc/aekr2/module/engineering/project/06-self-balancing-motorcycle Project Self-balancing Motorcycle>.
%
%% Project files for Self-Balancing Motorcycle
% The required files for Self-Balancing Motorcycle project are
% downloaded and installed as part of the MATLAB Support Package for Arduino
% Hardware installation. You
% can find these files in the folder _aekrev2projectfiles.instrset_. Use this MATLAB command to view and access the files:
%
%  fullfile(matlabshared.supportpkg.getSupportPackageRoot, '3P.instrset', 'aekrev2projectfiles.instrset')
%
% The _Motorcycle_ subfolder in this main folder (_aekrev2projectfiles.instrset_) contains the files described in the detailed
% workflow at
% <https://engineeringkit.arduino.cc/aekr2/module/engineering/project/06-self-balancing-motorcycle Project Self-Balancing Motorcycle>.
%
%% See also
% * <docid:mlsupportpkg#mw_1e86d1b2-6e59-4742-af3f-32f0eb29423e>
