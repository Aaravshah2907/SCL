function collectModeData(mode,noOfSamples)
% collectData - collect the data for the specified mode and store in a mat file.

% Copyright 2024 The MathWorks, Inc.

% Create an arduino object for ESP32 board over serial
aObj = arduino;

% Create IMU sensor object
imuObj = lsm9ds1(aObj,"SamplesPerRead",1);

data = [];
disp(['*** Collecting data for mode = ' mode ' ***']);

% Collect data for the specified number of samples
for idx=1:noOfSamples
    % Read the sensor values 
    accelerationValues = read(imuObj);
    data = [data;accelerationValues];
end

release(imuObj);

% Save the data in mat file
save([mode '_raw_data.mat'], 'data'); 

disp('*** Data collection complete ***');
end