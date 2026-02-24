%% Getting Started with MATLAB Support Package for BeagleBone Black Hardware
%
% This example shows you how to use the MATLAB(R) Support Package for
% BeagleBone(R) Black Hardware to perform basic operations on the hardware such
% as executing shell commands, turning an on-board LED on or off and
% manipulating files.
 
% Copyright 2015 The MathWorks, Inc.
 

%% Introduction
%
% The MATLAB Support Package for BeagleBone Black Hardware enables you to
% communicate with BeagleBone Black hardware remotely from a computer running
% MATLAB. The support package includes a MATLAB command line interface for
% accessing BeagleBone Black hardware's I/O peripherals and communication
% interfaces. Using this command line interface, you can collect data from
% sensors connected to BeagleBone Black hardware and actuate devices attached
% to BeagleBone Black hardware.
%
% In this example you learn how to create a *beaglebone* object to connect to 
% BeagleBone Black hardware from within MATLAB. You examine the properties
% and methods of this object to learn about the status of basic peripherals 
% such as digital I/O pins (also known as GPIO), SPI, I2C, and Serial.
% Using this object, you execute shell commands on your BeagleBone Black
% hardware and manipulate files on the BeagleBone Black hardware.


%% Prerequisites
%
% * If you are new to MATLAB, we recommend completing the
% <https://www.mathworks.com/support/learn-with-matlab-tutorials.html
% Interactive MATLAB Tutorial>, <docid:matlab_doccenter#bth9dea-1 Get
% Started with MATLAB>, and running the <https://www.mathworks.com/videos/getting-started-with-matlab-101684.html Getting Started with MATLAB> example.
%
% * If you are new to BeagleBone Black hardware, follow the instructions on
% <https://www.beagleboard.org/getting-started BeagleBone Black Getting Started> 
%  to install the necessary driver on you host computer.

%% Required Hardware
% 
% To run this example you need the following hardware:
% 
% * BeagleBone Black hardware
 

%% Create a beaglebone Object
%
% Create a *beaglebone* object.
%
%  bbb = beaglebone();
%
% The bbb is a handle to a beaglebone object. While creating the bbb object, the
% MATLAB connects to a server running on the BeagleBone Black hardware
% through TCP/IP. If you have any issues with creating a beaglebone object,
% see the troubleshooting guide to diagnose connection issues. 
% 
% The properties of the beaglebone object show information about your
% BeagleBone Black hardware and the status of some of the hardware
% peripherals available. The numeric IP address or the hostname of your
% BeagleBone Black hardware is displayed in the DeviceAddress property. The
% beaglebone object detects the model and version number of your board and
% displays it in the BoardName property. The GPIO pinouts and available
% peripherals change with the model and version of your BeagleBone Black
% hardware.


%% Turn an LED on and off
% There are user LEDs on BeagleBone Black hardware that you can turn on and
% off. Execute the following commands at the MATLAB prompt to turn the LED
% off and then turn it on again.
%
%  led = bbb.AvailableLEDs{1};
%  writeLED(bbb, led, 0);
%  writeLED(bbb, led, 1);
%
% While executing the preceding commands, visually confirm that the LED on
% the BeagleBone Black hardware is turned off and then turned on. If you
% are unsure where the user LED is located, execute the following command.
% If you are unsure where the user LED is located, execute the following
% command.
%
%  showLEDs(bbb);
%
% You can make the LED blink in a loop with a period of 1 second.
%
%  for i = 1:10
%      writeLED(bbb, led, 0);
%      pause(0.5);
%      writeLED(bbb, led, 1);
%      pause(0.5);
%  end

%% Execute System Commands
% The beaglebone object has a number of methods that allow you to execute system
% commands on BeagleBone Black hardware from within MATLAB. You can accomplish
% quite a lot by executing system commands on your BeagleBone Black hardware.
%
%  system(bbb, 'ls -al /home')
%
% This statement executes a Linux directory listing command and returns the
% resulting text output at the MATLAB command prompt. 
%  
% Perform the LED exercise this time using system commands.
%  
%  system(bbb, 'echo 1 > /sys/class/leds/beaglebone:green:usr3/brightness');
%  system(bbb, 'echo 0 > /sys/class/leds/beaglebone:green:usr3/brightness');
%  
% You cannot execute interactive system commands using the system() method. 
% To execute interactive commands on the BeagleBone Black hardware, you must
% open a terminal session. 
%  
%  openShell(bbb)
%  
% This command opens a PuTTY terminal. Log in with your user name and
% password. The default user name is 'root' and no password is required.
% After logging in, you can execute interactive shell commands like 'top'.


%% Manipulate Files
% The beaglebone object provides the basic file manipulation capabilities. To
% transfer a file on BeagleBone Black hardware to your host computer you use
% the getFile() method.
%  
%  getFile(bbb, '/boot/uboot/Docs/images/beagle.png');
%  
% You can then open the file 'beagle.png' containing an image in MATLAB:
%  
%  img = imread('beagle.png');
%  image(img);
%  
% The getFile() method takes an optional second argument that allows you to
% define the file destination. To transfer a file on your host computer to
% BeagleBone Black hardware, you use putFile() method.
%  
%  putFile(bbb, 'beagle.png', '/tmp');
%  
% Make sure that file is copied.
%  
%  system(bbb, 'ls -l /tmp/beagle.png')
%  
% You can delete files on your BeagleBone Black hardware using the deleteFile()
% command. 
%  
%  deleteFile(bbb, '/tmp/beagle.png');
%  
% Make sure that file is deleted.
%  
%  system(bbb, 'ls -l /tmp/beagle.png')
%  
% The preceding command should result in an error indicating that the file
% cannot be found.

%% Summary
% This example introduced the workflow for using the MATLAB Support Package
% for BeagleBone Black Hardware. Using the BeagleBone Black support package,
% you turned the user LED on and off, executed system commands and
% manipulated files on BeagleBone Black hardware.

