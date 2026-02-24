%% Connect to BeagleBone Black Hardware Board
% Use the |beaglebone| function to create a connection to a BeagleBone Black
% hardware board and assign the connection to an object. You can use this
% object to interact with BeagleBone Black hardware board and peripherals.
%
%%
% Create a connection object, |bbb|, from &tm_matlab to the BeagleBone
% Black hardware board.
bbb = beaglebone
%%
% Show the current pin configuration.
showPins(bbb);
%%
% Show all possible pin configurations of the BeagleBone Black hardware
% board.
showAllPins(bbb);
%%
% Use the bbb object to turn one of the LEDs on and off.
writeLED(bbb, 'usr0', 1);
pause(1);
writeLED(bbb, 'usr0', 0);
%%
% To close the connection, use clear to remove the bbb object and any other
% connections that use bbb.
clear bbb
