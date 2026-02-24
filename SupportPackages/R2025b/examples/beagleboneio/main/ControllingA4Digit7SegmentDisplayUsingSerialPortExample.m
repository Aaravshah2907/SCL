%% Control Four-Digit Seven-Segment Display Using Serial Port
%
% This example shows you how to use the serial UART on BeagleBone Black
% hardware to control a four-digit seven-segment display.
 
% Copyright 2015 The MathWorks, Inc.
 

%% Introduction
% 
% BeagleBone Black hardware includes a hardware serial UART port. The serial
% port enables you to connect devices supporting serial communications
% directly to BeagleBone Black hardware. There is a wide variety of sensors,
% displays, ADC's, DAC's, etc. supporting serial communications. By using
% these devices you can add new capabilities to your BeagleBone Black projects.
%
% In this example, we will concentrate on controlling a four-digit seven-segment
% display via serial port. We will start by providing an overview of
% serial communications in general and then focus on the display and
% specifics of serial communications interface it supports. We will learn
% about MATLAB command interface for serial communication devices and
% finally finish the example by displaying numbers and simple characters.


%% Prerequisites
%
% * We recommend completing
% <docid:mlsupportpkg#example-beagleboneio_gettingstarted Getting
% Started with MATLAB Support Package for BeagleBone Black Hardware> example.


%% Required Hardware
% 
% To run this example you will need the following hardware:
% 
% * BeagleBone Black hardware
% * Breadboard and jumper cables
% * A four-digit seven-segment display with serial interface from SparkFun

 
%% Overview of Serial Communications
%
% The serial port on BeagleBone Black implements a version of the RS-232
% communications where 0/+3.3V TTL logic levels are used instead of +/-12V.
% RS-232 is a series of standards for serial binary single-ended data and
% control signals connecting between data terminal equipment (DTE) and DCE
% data circuit-terminating equipment (DCE). RS-232 was once a common
% peripheral found in personal computers. It has been largely replaced by
% USB. Today, TTL logic level implementation of RS-232 is commonly used for
% attaching low-speed peripherals to an embedded system.
%
% BeagleBone Black hardware has a serial port exposed on the expansion
% header. The serial port has two signals. A transmit signal line, TXD, and
% a receive signal line, RXD. Peripheral devices supporting serial
% communications are attached to these pins. There are other signal lines
% such as RTS/CTS but these are rarely used. 
%
% The RS-232 communications does not have a clock signal. The clock is
% derived from the incoming waveform. The transmission starts with a start
% bit followed by a number of data bits (usually 8) and ends with a stop
% bit. The data rate is called baud rate and specifies signaling rate in
% bits per second.

%% Overview of Four-Digit Seven-Segment Display
%
% The four-digit seven-segment display from SparkFun is a four-digit alpha-numeric
% display with TTL serial, SPI and I2C interfaces. 
%
% <<../segment_display.png>>
%
% This device can display numbers, most letters and a few special
% characters. Decimal points, apostrophes and colons are supported.
% Brightness of the display can be adjusted. The display has a simple
% control interface where the controller device, BeagleBone Black hardware in this
% case, issues commands with parameters to the display device over I2C bus.
% For example, to clear the display controller sends a command byte of '0x76'.
% To set the cursor to a particular position, controller sends a command byte
% of '0x79' followed by a byte indicating cursor position (0 to 3). A
% comprehensive list of commands is shown in the table below.
%
% <html>
% <table align="center" border="1" cellpadding="5">
%     <tbody>
%         <tr>
%             <td style="text-align: center;">
%                 <strong>Command</strong></td>
%             <td style="text-align: center;">
%                 <strong>Command byte</strong></td>
%             <td style="text-align: center;">
%                 <strong>Data byte range</strong></td>
%             <td style="text-align: center;">
%                 <strong>Data byte description</strong></td>
%         </tr>
%         <tr>
%             <td style="text-align: center;">
%                 Clear display</td>
%             <td style="text-align: center;">
%                 0x76</td>
%             <td style="text-align: center;">
%                 None</td>
%             <td style="text-align: center;">
%                 &nbsp;</td>
%         </tr>
%         <tr>
%             <td style="text-align: center;">
%                 Decimal control</td>
%             <td style="text-align: center;">
%                 0x77</td>
%             <td style="text-align: center;">
%                 0-63</td>
%             <td style="text-align: center;">
%                 1-bit per decimal</td>
%         </tr>
%         <tr>
%             <td style="text-align: center;">
%                 Cursor control</td>
%             <td style="text-align: center;">
%                 0x79</td>
%             <td style="text-align: center;">
%                 0-3</td>
%             <td style="text-align: center;">
%                 0=left-most, 3=right-most</td>
%         </tr>
%         <tr>
%             <td style="text-align: center;">
%                 Brightness control</td>
%             <td style="text-align: center;">
%                 0x7A</td>
%             <td style="text-align: center;">
%                 0-255</td>
%             <td style="text-align: center;">
%                 0=dimmest, 255=brightest</td>
%         </tr>
%         <tr>
%             <td style="text-align: center;">
%                 Digit 1 control</td>
%             <td style="text-align: center;">
%                 0x7B</td>
%             <td style="text-align: center;">
%                 0-127</td>
%             <td style="text-align: center;">
%                 1-bit per segment</td>
%         </tr>
%         <tr>
%             <td style="text-align: center;">
%                 Digit 2 control</td>
%             <td style="text-align: center;">
%                 0x7C</td>
%             <td style="text-align: center;">
%                 0-127</td>
%             <td style="text-align: center;">
%                 1-bit per segment</td>
%         </tr>
%         <tr>
%             <td style="text-align: center;">
%                 Digit 3 control</td>
%             <td style="text-align: center;">
%                 0x7D</td>
%             <td style="text-align: center;">
%                 0-127</td>
%             <td style="text-align: center;">
%                 1-bit per segment</td>
%         </tr>
%         <tr>
%             <td style="text-align: center;">
%                 Digit 4 control</td>
%             <td style="text-align: center;">
%                 0x7E</td>
%             <td style="text-align: center;">
%                 0-127</td>
%             <td style="text-align: center;">
%                 1-bit per segment</td>
%         </tr>
%         <tr>
%             <td style="text-align: center;">
%                 Baud rate config</td>
%             <td style="text-align: center;">
%                 0x7F</td>
%             <td style="text-align: center;">
%                 0-11</td>
%             <td style="text-align: center;">
%                 See baud rate command in datasheet</td>
%         </tr>
%         <tr>
%             <td style="text-align: center;">
%                 I2C Address configuration</td>
%             <td style="text-align: center;">
%                 0x80</td>
%             <td style="text-align: center;">
%                 1-126</td>
%             <td style="text-align: center;">
%                 New I<sup>2</sup>C address</td>
%         </tr>
%         <tr>
%             <td style="text-align: center;">
%                 Factory reset</td>
%             <td style="text-align: center;">
%                 0x81</td>
%             <td style="text-align: center;">
%                 None</td>
%             <td style="text-align: center;">
%                 &nbsp;</td>
%         </tr>
%     </tbody>
% </table>
% </html>



%% Connect Display 
% 
% To interface the display to BeagleBone Black hardware you need to do some
% light soldering. Since we are using the serial interface of the display
% in this example, solder jumper wires to the RX, GND and VCC pins of the
% display. You may also choose to solder some straight male headers to be
% able to mount the display on a breadboard for prototyping. Before going
% any further, you may also want to follow manufacturer's hardware assembly
% guide.
%
% Follow the circuit diagram shown below to connect the display to
% BeagleBone Black hardware.
%
% <<../bbb_uart.png>>
%



%% Display Number
% 
% Let's start by enabling serial port 4.
%
% bbb = beaglebone;
% enableSerialPort(bbb, 4)
%
% Note that the AvailableSerialPorts property of beaglebone object gets set
% to '/dev/ttyO4'. Next, we create a serialdev object:
%
% segmentDisp = serialdev(bbb, '/dev/ttyO4', 9600);
%
% The second argument, '/dev/ttyO4', is the name of the serial port. We open
% this serial port with a baud rate of 9600 which is the default baud rate
% supported by the display. According to the command table for the display,
% sending a byte in the range 0 - 0xf results in a hexadecimal number
% represented by the byte to be displayed. The cursor is initially at
% position 0, which is the left most digit, and advances one position each
% time a character is displayed.
%
%  write(segmentDisp, 0);
%
% This should display a '0' on the left most digit of the display. Let's
% display a couple of more characters.
%
%  write(segmentDisp, 7);
%  write(segmentDisp, hex2dec('a'));
%  write(segmentDisp, hex2dec('b'));
%
% After executing the commands above, you should see '07ab' displayed on
% the segmented display.

%% Clear Display Screen
%
% To clear the display screen we will follow the datasheet and send '0x76'
% to the display.
%
%  write(segmentDisp, hex2dec('76'));
%

%% Set Cursor Position
%
% To display a particular character at a particular cursor position, you
% may want to set the cursor position.
%
%  write(segmentDisp, [hex2dec('79'), 3]);
%  write(segmentDisp, 9);
%
% The commands above will display a '9' at the right most digit position of the
% display.


%% Advanced: Create a MATLAB class for segment display
%
% You can put all the things we learned about the segment display together
% and create a MATLAB class for it. This MATLAB class has methods for
% setting the cursor position, clearing the display screen, printing
% numbers, etc. As an example, we created such a class. Here is an example
% of how you would use this class.
%
%  clear segmentDisp
%  sd = serialsegmentdisplay(bbb, '/dev/ttyO4');
%  clr(sd);  % Clear screen
%  print(sd, '112');
%  print(sd, 'dead');
%  print(sd, 'beef');
%
% Note that before creating the class, we cleared the original serialdev
% object called segmentDisp. You are allowed to create a single object per
% serial device. The segmentdisplay class internally creates a serialdev
% object. Hence you need to clear any serialdev object connected to the
% display from MATLAB workspace before instantiating the segmentdisplay.
%
% The segmentdisplay class tries to reduce flickering caused by clearing /
% re-displaying numbers. It does so by caching the displayed characters and
% updating only those that are different. Not all features supported by the
% segmented display are implemented. You can use the MATLAB class we
% created as a starting point for your own implementation. Here is a MATLAB
% code snippet implementing an up counter:
%
%  N = 1000;
%  delay = 0.01;
%  clr(sd);
%  for i = 1:N
%      print(sd,num2str(i));
%      pause(delay);
%  end
%  


%% Summary
% 
% This example introduced the workflow for working with serial
% communications interface. You learned how to control a four-digit seven-segment
% display to display hexadecimal numbers.

 