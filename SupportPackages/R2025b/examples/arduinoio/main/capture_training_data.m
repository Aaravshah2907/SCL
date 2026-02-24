function data = capture_training_data    
%CAPTURE_TRAINING_DATA This function captures training
%data for arduino_machinelearning model

% Copyright 2021-2023 The MathWorks, Inc.


gesture=0;
%Acceleration threshold to detect motion
accelerationThreshold = 2.5;        
%Create arduino object
a=arduino('usersArduino'); %Change this to your Bluetooth name or address                         
%Initialize imu sensor
imu=lsm9ds1(a,'SamplesPerRead',119,'Bus',1);
disp('Updated server. Start capturing gesture data.');
%Loop to capture 100 gestures
while(gesture < 100)                 
    %Read acceleration data
    accel=imu.readAcceleration;     
    %Sum up absolute values of acceleration 
    aSum=sum(abs(accel))/9.8;       
    %Capture values if there is significant motion
    if aSum>=accelerationThreshold 
        gesture=gesture+1;
        %Read IMU sensor data
        imudata=imu.read;
        imudatatable=timetable2table(imudata);
        %Save values in data variable
        data{gesture}=[imudatatable.Acceleration/9.8 rad2deg(imudatatable.AngularVelocity)];    
        %Display the captured gesture number
        disp(['Gesture no.' num2str(gesture)]);
    end
end
release(imu);
clear imu;
clear a;
end
