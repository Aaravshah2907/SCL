%% Analog Input Using SPI
%
% This example shows you how to use the SPI peripheral on
% BeagleBone Black(R) hardware to connect to an MCP3008 10-bit 8-channel
% ADC.
 
% Copyright 2015 The MathWorks, Inc.
 

%% Introduction
% 
% The Serial Peripheral Interface (SPI) is a very common device communication
% interface. BeagleBone Black hardware has SPI interface available on the expansion
% headers. In this example, you interface an ADC chip to BeagleBone Black hardware
% using the SPI peripheral.


%% Prerequisites
%
% * It is helpful if you complete the 
% <docid:mlsupportpkg#example-beagleboneio_gettingstarted Getting
% Started with MATLAB Support Package for BeagleBone Black Hardware> example.


%% Required Hardware
% 
% To run this example you need the following hardware:
% 
% * BeagleBone Black hardware
% * Breadboard and jumper cables
% * MCP3008 ADC
% * 10 kOhm Potentiometer

 
%% Overview of SPI 
%
% The Serial Peripheral Interface (SPI) is a synchronous serial data link
% that you use to interface one or more peripheral devices to a
% single controller SPI device. SPI uses three signal lines common to all
% peripherals:
%
% * Serial Data In (SDI). Data is moved from peripheral to controller on this
% wire.
% * Serial Data Out (SDO). Data is moved from controller to peripheral on this
% wire.
% * Serial clock (SCLK). The controller SPI device generates this clock.
%
% Each peripheral is wired to an individual chip-select or peripheral-transmit
% enable line. During SPI communication, controller selects only
% one peripheral device at a time. Any other peripheral on the bus that has not been
% activated using its chip-select line must disregard the input clock and
% MOSI signals. It also must not drive the MISO line.
%
% <<../spi_diagram.png>>
%
% SPI communications are full duplex. When the controller sends a bit on the
% MOSI line, the peripheral reads the bit and at the same time sends a bit on
% the MISO line that is in turn read by the controller. Therefore, to read from
% a peripheral device, you must write to it.


%% Enable SPI Peripheral
%
% There are 2 SPI buses available on BeagleBone Black hardware: SPI0 and
% SPI1. Use showAllPins method to determine the pins on the P8 / P9
% expansion header the SPI peripheral is mapped to. Use enableSPI method to
% enable SPI0. After enabling SPI0, view AvailableSPIChannels property of
% the beaglebone object to verify that you see new SPI channels:
%  
%  clear bbb
%  bbb = beaglebone;
%  enableSPI(bbb, 0)
%  bbb.AvailableSPIChannels
%


%% Overview of MCP3008 
%
% MCP3008 is a 10-bit, 8-channel analog to digital converter (ADC) with an
% SPI interface.
%
% <<../mcp3008.png>>
%
% As seen in this diagram, pins 1 through 8 are analog input channels. Pin
% 16 is the digital supply voltage and pin 9 is the digital ground.
% $V_{ref}$ and $A_{GND}$ are the pins used for reference voltage level for
% analog measurements. The digital 10-bit voltage measurement value is
% scaled so that a value of 0 corresponds to $A_{GND}$ and a value of 1023
% (2^10 - 1) corresponding to $V_{REF}$. Pins 10 through 13 are connections
% for SPI interface.


%% Connect MCP3008 
% 
% Connect MCP3008 to the BeagleBone Black hardware as seen in the following
% circuit diagram. To simulate a variable voltage applied to CH0,
% use a 10 kOhm potentiometer connected to CH0.
%
% <<../bbb_spi.png>>
%
% In this example, the potentiometer (POT) is a three-terminal device with
% terminals 1 and 3 comprising the end points of a resistor embedded in the
% POT. The second terminal is connected to a variable wiper. As the wiper
% moves, the resistance across terminals 1 and 2 and terminals 2 and
% 3 changes. In this circuit, POT acts as a variable voltage divider.
% As you move the knob of the potentiometer, the voltage seen at terminal 2
% changes between 3.3 Volts and 0 volts. 


%% Measure Voltage at CH0
%
% MCP3008 uses the SPI interface to communicate with the SPI controller which
% in this case is BeagleBone Black hardware. An SPI transaction between MCP3008
% and BeagleBone Black consist of 3 bytes. BeagleBone Black hardware sends a byte
% containing a value of '1' to MCP3008. At the same time, MCP3008 sends a
% do not care byte to BeagleBone Black hardware. BeagleBone Black hardware sends
% another byte to the MCP3008 with the most significant 4 bits containing a
% value of '1000'. This byte indicates to the MCP3008 that a single-ended
% voltage measurement at CH0 is requested. At the same time, MCP3008 sends
% the bits 9 and 10 of the ADC measurement. Finally, BeagleBone Black hardware
% sends a do not care byte and at the same time reads the least significant
% 8 bits of the voltage measurement. The 10-bit value read from MCP3008 is
% then converted to a voltage value.


%% Read Voltage
% 
% To read the voltage value from MCP3008, first create an spidev
% object connected to SPI channel 'spidev1.0'. Perform the SPI transaction as
% previously described.
%  
%  clear mcp3008
%  mcp3008 = spidev(bbb, 'spidev1.0');
%  data = uint16(writeRead(mcp3008,[1, bin2dec('10000000'), 0])); 
%  highbits = bitand(data(2), bin2dec('11'));
%  voltage = double(bitor(bitshift(highbits, 8), data(3)));
%  voltage = (3.3/1024) * voltage;
%
% The variable *voltage* holds the voltage value read from the CH0 pin of
% the MCP3008. You can substitute various analog sensors, such as a TMP36
% temperature sensor, in place of the POT in this circuit.

%% Advanced: Create a MATLAB Class for MCP3008
%
% You can create a MATLAB(R) class for MCP3008 that makes it easy to use this
% device from MATLAB command-line interface. You can condense the
% steps in this example using this MATLAB class.
%  
%  clear mcp3008
%  mcp3008 = beaglebone.mcp3008(bbb, 'spidev1.0');
%  for i = 1:20
%      voltage = readVoltage(mcp3008, 0);
%      fprintf('Voltage = %0.2f\n', voltage);
%      pause(0.2);
%  end
%
% Experiment with the POT knob while executing the preceding loop. You see
% that the voltage value printed on the MATLAB prompt changes.


%% Summary
% 
% This example introduced the workflow for working with the SPI interface.
% You learned how to use MCP3008 ADC to read analog input voltages.
 
 