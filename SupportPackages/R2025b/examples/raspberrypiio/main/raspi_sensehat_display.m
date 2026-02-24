function raspi_sensehat_display()
% RASPI_SENSEHAT_DISPLAY Example demonstrates the use of tcpclient to send
% and receive data from a tcpserver. The IMU sensor data is sent to an
% Android device where the data is displayed on a scope. On the Android
% screen the user can set the intensity of the R, G and B Leds which are
% are received by the raspberry pi device and set on the SenseHAT LED
% Matrix.

%Copyrights 2019 The MathWorks, Inc.

%Create a raspi object
r = raspi();

%Create a SenseHAT Object using the above created raspi object
s = sensehat(r);

%Create a tcpclient object to send data. Replace the IP address and Port
%according to your Android device.
tcpObj_Send = tcpclient('192.168.1.2',6000);

%Create a tcpclient object to receive data. Replace the IP address and Port
%according to your Android device.
tcpObj_Recv= tcpclient('192.168.1.2',10000, 'Timeout',2);

%Run the loop for 1000 iterations. If you need to run continuously, replace
%with a while(1) loop.

for count = 1:1000
    %Read IMU Sensor - Accel data
    accelData = readAcceleration(s);
    %Read IMU Sensor - Gyro data
    gyroData = readAngularVelocity(s);
    %Read IMU Sensor - Mag data
    magData = readMagneticField(s);
    
    %Combine IMU Data
    imuData = [accelData gyroData magData];
    
    %Send IMU data
    write(tcpObj_Send, imuData);
    
    %Read the data from tcpclient
    LEDdata = read(tcpObj_Recv, 3, 'double');
    
    %Ignore if the data is zero. tcpclient read returns zero as output if
    %no read is successful within the give timeout
    if ((LEDdata(1) ~=0) && (LEDdata(2) ~=0) && (LEDdata(3) ~=0))
        for row = 1:8
            for col = 1:8                
                writePixel(s, [row col] , LEDdata);
            end
        end
    end
    
    %Add a pause of 0.2 seconds
    pause(0.2);
end

