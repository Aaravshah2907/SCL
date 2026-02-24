%% Transfer Data over TCP/IP Between Raspberry Pi Sense HAT and Android Device
% This example shows how to use MATLAB(R) commands to send data over TCP/IP
% from Raspberry Pi(R) Sense HAT to an Android(TM)
% device and also receive RGB color values from the Android device and display the same
% on the LED matrix of Sense HAT. 

% Copyright 2019 The MathWorks, Inc.

%% Introduction
%
% The Raspberry Pi Sense HAT is an add-on board for
% Raspberry Pi hardware. It has an 8X8 RGB LED Matrix, a five-position joystick
% and includes the following sensors:
%
% * Humidity sensor
% * Pressure sensor
% * IMU sensor (Accelerometer, Gyroscope, and Magnetometer).
% 
% In this example, you will develop an algorithm to send the data from the IMU sensor
% by defining a TCP/IP client. You will also develop another algorithm to receive RGB color values from the Android device over TCP/IP and 
% display the color on the 8x8 RGB LED matrix.

%% Prerequisites
%
% * We recommend completing *Working with Raspberry Pi Sense HAT* example.

%% Required Hardware
%
% To run this example you will need the following hardware:
%
% * Raspberry Pi hardware
% * Raspberry Pi Sense HAT
%% Required Products
%
% * MATLAB Support Package for Raspberry Pi Hardware
% * Simulink Support Package for Android Devices
%% Step 1: Create a Sense HAT Object and TCP/IP Clients
%
% Create a Sense HAT object in MATLAB Support Package for Raspberry Pi Hardware 
% by executing the following commands at the MATLAB prompt.
%
%   r = raspi();
%   s = sensehat(r);
%
% |s| is a handle to a sensehat object.
%
% Create a TCP/IP client object to send data from Raspberry Pi to the Android device. Replace the IP address and Port
% according to your Android device.
%
%  tcpObj_Send = tcpclient('192.168.1.2',6000);
%
% Create a TCP/IP client object to receive data from the Android device. Replace the IP address and Port
% according to your Android device. We specify the Timeout as 2 seconds for
% a response to be obtained from the Android device.
%
%  tcpObj_Recv= tcpclient('192.168.1.2',10000, 'Timeout',2);
%
%% Step 2: Send IMU Sensor Data from Sense HAT
%
% In MATLAB Support Package for Raspberry Pi Hardware, we will use an algorithm  
% that uses a _for_ loop that runs for 1000 iterations while obtaining data from the IMU
% sensor of Raspberry Pi Sense HAT. We combine the IMU sensor data 
% into a [1x3] array and send the data using the TCP/IP client object. We also add a pause time of 0.2 seconds between the iterations. 
%
%  for count = 1:1000
%     %Read IMU Sensor - Accel data
%     accelData = readAcceleration(s);
%     %Read IMU Sensor - Gyro data
%     gyroData = readAngularVelocity(s);
%     %Read IMU Sensor - Mag data
%     magData = readMagneticField(s);
%     imuData = [accelData gyroData magData];
%     write(tcpObj_Send, imuData);
%     pause(0.2)
%  end
% 
%% Step 3: Read Data from the Android Device on LED Matrix of Sense HAT
%
% In MATLAB Support Package for Raspberry Pi Hardware, we will use an algorithm  
% that uses a _for_ loop that runs for 1000 iterations while receiving data from the
% color sliders on the application that you are going to deploy on the remote Android device.
% We will use the |read| method to read data from the TCP/IP receive object (which obtains the data from the
% remote Android device). We also add a pause time of 0.2 seconds between the iterations.
%
% We can display the received data on the LED matrix of Sense HAT using the |writePixel| function. 
% In this case, we will also add a code to ignore the 
% |writePixel| command if the input data is zero. Additionally, if the read is not successful within the 
% timeout value specified, the TCP/IP client returns zero as output.
%
%  for count = 1:1000
%   LEDdata = read(tcpObj_Recv, 3, 'double');
%   if ((LEDdata(1) ~=0) && (LEDdata(2) ~=0) && (LEDdata(3) ~=0))
%        for row = 1:8
%            for col = 1:8                
%                writePixel(s, [row col] , LEDdata);
%            end
%        end
%    end
%   pause(0.2)
%  end
%
%% Step 4: Deploy the MATLAB Function
% 
% You can deploy the |raspi_sensehat_display()| function on the
% Raspberry Pi hardware. 
%
%  function raspi_sensehat_display()
% 
%   r = raspi();
%   s = sensehat(r);
%
%   tcpObj_Send = tcpclient('192.168.1.2',6000);
%   tcpObj_Recv= tcpclient('192.168.1.2',10000, 'Timeout',2);
% 
%   for count = 1:1000
%     
%     accelData = readAcceleration(s);     
%     gyroData = readAngularVelocity(s);    
%     magData = readMagneticField(s);     
%     imuData = [accelData gyroData magData];     
%     
%     write(tcpObj_Send, imuData);     
%    
%     LEDdata = read(tcpObj_Recv, 3, 'double');%     
%    
%     if ((LEDdata(1) ~=0) && (LEDdata(2) ~=0) && (LEDdata(3) ~=0))
%         for row = 1:8
%             for col = 1:8                
%                 writePixel(s, [row col] , LEDdata);
%             end
%         end
%     end     
%    
%     pause(0.2);
%  end
%
% Deploy the |raspi_sensehat_display| function as a standalone executable on the hardware by 
% using the |<docid:mlsupportpkg.mw_a8a63ef5-1af4-460a-8515-2432dd5670b6
% deploy>| function. Note: For Raspberry Pi with 32-bit OS use
% |targetHardware('Raspberry Pi')| and for 64-bit OS use |targetHardware('Raspberry Pi (64bit)')|.
%
%   board = targetHardware('Raspberry Pi (64bit)')
%   deploy(board,'raspi_sensehat_display')
%
%   Code generation successful: View report
%
% The |deploy| function initiates code generation of the |raspi_sensehat_display| 
% function. At the end of code generation, MATLAB generates a code 
% generation report. Use this report to debug the |raspi_sensehat_display| function 
% for any build errors and warnings in the generated code.
%
% After successfully generating the code, the support package loads and 
% runs the code as a standalone executable on the hardware. The executable 
% starts sending IMU Sensor data over TCP/IP and prepares to receive any data from the remote Android device.
%
%% Step 5: Prepare and Deploy a Model for TCP/IP Using Simulink Support Package for Android Devices
% After you install Simulink Support Package for Android Devices, open the <matlab:openExample('raspberrypiio/ControlAndMonitorSenseHATAndroidRaspiExample','supportingFile','androidraspberrypisensehat')
% |androidraspberrypisensehat|> Simulink model.
%%
open_system('androidraspberrypisensehat')
%% 
% * TCP/IP Receive block in the model is configured to receive data at port 6000 (the
% same port number that you specified for |tcpObj_Send| object in the
% MATLAB Support Package for Raspberry Pi Hardware in the previous task)
% * TCP/IP Send block in the model is configured to send data at port 10000 (the
% same port number that you specified for |tcpObj_Receive| object in the
% MATLAB Support Package for Raspberry Pi Hardware in the previous task).
%
% Deploy this model to the Android device that is connected to the host computer
% (in the *Hardware* tab of the Simulink model, click *Build, Deploy & Start*). The deployed
% model launches an application that helps you to read the data and also use the
% three sliders on the application to send the desired RGB values.
%
% On the Android device, launch the application
% that you deployed, and view the live data for accelerometer, 
% gyroscope, and magnetometer, as obtained from the IMU sensor of Raspberry Pi Sense HAT. 
%
% On the Android device, move the three color sliders in the application for
% configuring various RGB values. You can observe the corresponding change of color on the 8X8 RGB
% LED Matrix of the Raspberry Pi Sense HAT.
%% Other Things to Try
% Create an algorithm to run the control continuously in MATLAB Support Package for Raspberry Pi Hardware, by using a _while_
% loop in the MATLAB code.
