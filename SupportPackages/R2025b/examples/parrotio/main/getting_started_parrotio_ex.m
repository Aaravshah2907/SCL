%% Getting Started with MATLAB&reg; Support Package for Parrot&reg; Drones
%
% This example shows how to use the MATLAB&reg; Support Package for Parrot&reg; 
% drone to perform the basic flight operations on the drone such as take-off, 
% land, and fly along a path.
%
%% Introduction
%
% The MATLAB Support Package for Parrot Drone enables you to control a
% Parrot drone from a computer running MATLAB. 
%
% The support package includes functions to pilot a Parrot drone 
% by sending the commands to control its direction, speed, and orientation, 
% and read the flight navigation data such as speed, height, and 
% orientation. 
%
% In this example you will learn how to create a parrot object to 
% control and fly the Parrot drone from within MATLAB. 

% Copyright 2019 The MathWorks, Inc.

%% Pre-requisites
%
% If you are new to MATLAB, it is helpful to read the Getting Started
% section of the <matlab:doc('MATLAB') MATLAB documentation> and running 
% <matlab:web('http://www.mathworks.com/videos/getting-started-with-matlab-101684.html','-browser') Getting Started with
% MATLAB example>.
%
%% Required Hardware
%
% To run this example you need the following:
%
% * A fully charged Parrot FPV drone
% * A computer with a WiFi connection
%
%% Important pre-flight safety considerations
%
% Before flying the Parrot drone, ensure the following safety
% procedures:
%
% * Ensure the safety of people, animals, and property in the vicinity of the flight.
% * Wear safety glasses at all times.
% * Place the drone on a flat surface before starting.
% * Fly the drone only indoors, with an open area greater than 10x10 feet, over a non-glossy floor.
%
%% Task 1 &mdash; Hardware setup
%
% * Power on the Parrot FPV drone, wait for the LEDs on the camera to stabilize.
% * Connect your computer to the drone's Wifi network.
% 
%% Task 2 &mdash; Create a parrot object
%
% Create a |parrot| object.
%
%    p = parrot();
%  
%% Task 3 &mdash; Take-off and land the drone
%
% Take off the Parrot FPV drone from a level surface. 
%
% Execute the following command at the MATLAB command prompt the takeoff of 
% the drone.
%
%    takeoff(p);
%
% The Parrot drone moves up vertically, and remains there.
%
% Land the drone.
%
%    land(p);
%
%% Task 4 &mdash; Fly the drone along a square path
% 
% Take-off and move the drone forward for 2 seconds and turn the drone by pi/2 radians
% (90 degrees) at each square vertex. 
%
% Repeat this action 4 times (vertices
% of a square) to make the drone navigate a square path and return it to the
% starting position.
% 
% Use the |BatteryLevel| property of the drone to ensure there is enough
% battery charge left for flight.
%
%    takeoff(p);
%    movement_step = 1;
%     while(movement_step <= 4 && p.BatteryLevel > 10)
%      moveforward(p, 2);
%      turn(p, deg2rad(90));
%      movement_step = movement_step + 1;
%     end
%
% You can also increase the |duration| argument in |moveforward| function to 
% make the drone move forward for more time. Use the optional |tilt| argument 
% in the |moveforward| function to vary the speed of drone.
%
% Land the drone.
% 
%    land(p);
%
%% Task 5 &mdash; Fly the drone along a circlular path
%
% Take-off the drone and control the |Roll| angle and |RotationSpeed| of the drone to make the drone 
% fly along the perimeter of a circle. 
% 
% Execute the following command at the MATLAB 
% command prompt to fly the drone in a circle for 5 seconds.
%
%    takeoff(p);
%    move(p, 5, 'Roll', deg2rad(4), 'RotationSpeed', deg2rad(120));
%
% Vary the value of |RotationSpeed| NV pair to adjust the speed of drone revolution.
%
% Land the drone.
% 
%    land(p);
%
%% Task 6 &mdash; Fly the drone along a diagonal path
%
% Take-off and move the drone along a diagonal path in the horizontal plane by adjusting 
% the Pitch and Roll angles. 
% 
% Execute the following command at the MATLAB command 
% prompt to fly the drone along a diagonal path for 5 seconds.
%
%    takeoff(p);
%    move(p, 5, 'Pitch', deg2rad(-4), 'Roll', deg2rad(4));
%
% Vary the |Pitch| and |Roll| NV pairs to adjust the speed of the drone.
%
% Land the drone. 
% 
%    land(p);
%
%
%% Task 7 &mdash; Clean up
%
% When finished clear the parrot object
%
%    clear p;
%