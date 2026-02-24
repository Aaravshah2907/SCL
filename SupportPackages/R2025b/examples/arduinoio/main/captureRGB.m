
% Create arduino object
arduinoObj = arduino('COM3', 'Nano33BLE', 'Libraries', 'APDS9960'); 

% Create apds9960 object
apds9960Obj = apds9960(arduinoObj, 'Bus', 1, 'BitRate', 400000);

% Initialize numReading as 0. It is used to keep track of number of observations
numReading = 0;

% Wait for some time to set up the object
disp("Keep the board closer to the fruit and press any key"); 
f = msgbox("Go to command line and press any key once ready");
pause; 

% Create an empty table
trainingData = table();
disp("Acquiring sensor data");

%here we are taking 2000 samples
while(numReading <= 2000)
    % Read the color of fruit through APDS9960 sensor
    colorData = readColor(apds9960Obj);
    % Convert array to table
    colorDataInTableFormat = array2table(colorData); 
    % Append entry to training data 
    trainingData = [trainingData; colorDataInTableFormat]; 
    % Increment the numReading 
    numReading = numReading+1; 
    %pause(0.1); 
end

disp("Data acquisition completed"); 


% Clear apds9960 sensor object 
clear apds9960Obj; 

% Clear arduino object 
clear arduinoObj;
