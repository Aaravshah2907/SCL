function collectData(activity,noOfSamples)
% collectData - collect the data for the specified activity and store in a mat file.

% Copyright 2023 The MathWorks, Inc.

% Create an arduino object for ESP32 board over WiFi
aObj = arduino;

% Create IMU sensor object
imuObj = lsm9ds1(aObj);

data = [];
disp(['*** Collecting data for activity = ' activity ' ***']);

% Collect data for the specified number of samples
for idx=1:noOfSamples
    % Read the sensor values and calibrate
    accelerationValues = readAcceleration(imuObj);

    data = [data;accelerationValues];
end

% Save the data in mat file
save([activity '_raw_data.mat'], 'data'); 

disp('*** Data collection complete ***');
end