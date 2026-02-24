%% Working with BeagleBone Black Hardware
%
% This example shows you the basics of working with BeagleBone Black(R) Hardware.
 
% Copyright 2015 The MathWorks, Inc.
 

%% Introduction
% 
% BeagleBone Black is a single board, credit-card size computer that can run
% Linux(R). BeagleBone Black hardware has low-level interfaces intended to
% connect directly with external devices such as A/D converters, sensors,
% motor drivers, etc. You can take advantage of these low-level interfaces
% to develop meaningful real-world applications. The BeagleBone Black support
% package includes MATLAB command-line interfaces to communicate with
% external devices connected to BeagleBone Black hardware. You can, for
% example, turn a LED connected to one of the GPIO pins on or off or sense
% the position of a push button from the MATLAB command prompt.
%
% Most of the low-level interfaces of BeagleBone Black hardware are not
% plug-and-play. To use these low-level interfaces, you must have a sound
% understanding of basic electrical concepts. If you mis-wire a GPIO pin,
% for example, you risk damaging a GPIO pin, and, in some cases, your
% entire BeagleBone Black hardware.
%
% This example is intended to familiarize you with low level interfaces
% of the BeagleBone Black hardware, establish sound practices for wiring and
% connections when working with external electrical components and use
% MATLAB command-line interface for BeagleBone Black hardware to control simple
% devices like LEDs and push buttons.


%% Prerequisites
%
% * It is helpful to complete the
% <docid:mlsupportpkg#example-beagleboneio_gettingstarted Getting Started with MATLAB Support Package for BeagleBone Black Hardware>
% example.

%% Required Hardware
% 
% To run this example, you need the following hardware:
% 
% * BeagleBone Black hardware
% * Breadboard and jumper cables
% * Red LED
% * 330 Ohm, 1 kOhm and 10 kOhm resistors
% * A push button or switch

 
%% Overview of BeagleBone Black Hardware
%
% In addition to USB, Ethernet and HDMI, the BeagleBone Black
% hardware has expansion headers that offer general purpose digital I/O,
% analog input, PWM, SPI, I2C and UART. 
% 
% BeagleBone Black hardware have two expansion headers, P8 and P9. Each pin of the
% expansion headers can be configured and used for different functionalities.
% To see the current pin map of your BeagleBone Black hardware, use showPins() method of
% beaglebone object. To see all the possible pin map, use showAllPins() method. 
%
%  bbb = beaglebone;
%  showPins(bbb);
%  showAllPins(bbb);
%
% The GPIO pins use 3.3 volt logic levels and are not 5 volt tolerant.
% There is no over-voltage protection on the CPU chip. 
%
% You can power external components using 3.3 volt and 5 volt power pins on
% the expansion headers. The maximum permitted current draw from the 3.3
% volt pins is 50 mA.
 
%% Best Practices and Restrictions
%
% * Do not connect electrical components to BeagleBone Black expansion headers
% while BeagleBone Black hardware is running. If you want to connect an
% electrical component, turn off your board first. Instructions for
% turning off you board are provided below.
%
% * BeagleBone Black pins use 3.3 volt logic levels. Do not connect devices
% using 5 volt logic levels directly to the BeagleBone Black pins.
%
% * Use logic level converters when interfacing devices using 5 volt logic
% levels to BeagleBone Black hardware.
% 
% * Do not short a GPIO pin configured as digital output.
%
% * Do not short 5 volt power pins to any other pin on the expansion
% header. Be extremely careful when working in the vicinity of 5 volt power
% pins.
% 
% * Do not touch bare expansion header pins while BeagleBone Black hardware is
% on. You can accidentally short some of the pins.

%% Turning Your BeagleBone Black Hardware On and Off
% 
% BeagleBone Black runs a Linux operating system. Turning off the power can
% result in operating system corruption. To turn
% off your board, first shut down the Linux operating system by executing
% the following:
%
%  system(bbb, 'sudo shutdown -h now');
%  clear bbb
%
% You can also execute the preceding command above on an interactive
% command shell as described in the Getting Started with MATLAB Support
% Package for BeagleBone Black Hardware example. After executing the command,
% wait until the operating system shuts down all LED's on the board except
% for PWR LED. Then, unplug the power cable from the board. To restart your
% board, plug the power cable back into the board. It takes approximately
% twenty seconds for the board to fully reboot.

%% Working with LEDs
%
% A light-emitting diode (LED) is a semiconductor light source. An LED has
% two legs. One is called anode and the other is called cathode. The
% two legs of LED have different names because LED works only in one
% direction. The anode leg is longer than the cathode leg, and must be
% attached to the positive voltage terminal while the cathode is attached
% to the negative voltage terminal. The current going through an LED goes
% from anode to cathode. If you wire an LED backwards, it does not light
% up. 
%
% LEDs come in different colors and sizes. Common sizes are 3mm, 5mm and
% 10mm and refer to the diameter of the LED. A red LED, when it is on will
% have a forward voltage anywhere from 1.8 volts to 2.5 volts. When a LED
% is on, it behaves like a diode and passes a large amount of current that
% may produce enough heat to cause the LED to burn out. Therefore, you
% should always use a current-limiting resistor when working with an LED.
% 
% In this example, you connect a red LED across a GPIO pin and turn the LED
% on and off using the MATLAB command-line interface. You need a red LED
% and a 330 Ohm resistor. You connect the LED and the resistor as shown in
% the circuit diagram.
%
% <<../bbb_gpio.png>>
%
% The anode (positive or long leg) is connected to the P8_12 pin and the
% cathode is connected to the ground through the resistor. Once you make
% the connections, execute the following command at the MATLAB command
% prompt to turn the LED on.
%  
%  clear bbb
%  bbb = beaglebone
%  writeDigitalPin(bbb, 'P8_12', 1);
%
% The writeDigitalPin() method configures GPIO pin P8_12 as output and sets
% the logical value of the digital pin to one (logic high) causing 3.3
% volts to be output at the pin. Writing a zero to a digital pin results in
% an output of logic low, which is digital ground in this case.
%
% Make the LED "blink" for 10 seconds.
%  
%  for i = 1:10
%      writeDigitalPin(bbb, 'P8_12', 1);
%      pause(0.5);
%      writeDigitalPin(bbb, 'P8_12', 0);
%      pause(0.5);
%  end
%  

%% Working with Push Buttons
%
% A push button is a simple switch mechanism. When pressed or in closed
% position, the legs of a push button are shorted allowing electrical
% current to pass. When in open position, the switch does not conduct
% electricity. You can use a digital input pin to sense if the push button
% is in an open or closed position.
% 
% For this task, you need a breadboard-friendly push button and 1 kOhm and
% 10 kOhm resistors. Connect the push button to GPIO pin 23, as shown in
% the previous circuit diagram.
%
% In this circuit, the GPIO pin sees ground when the push button is not
% pressed. When the push button is pressed, the GPIO pin sees 3.3 volts. You
% can read the position of the push button using the readDigitalPin()
% method.
%  
%  readDigitalPin(bbb, 'P8_11')
%  

%% Push Button Controlled LED
%
% Blink the LED rapidly for 1 second whenever the push button is pressed.
%  
%  for i = 1:100
%      buttonPressed = readDigitalPin(bbb, 'P8_11');
%      if buttonPressed
%          for j = 1:10
%              writeDigitalPin(bbb, 'P8_12', 1);
%              pause(0.05);
%              writeDigitalPin(bbb, 'P8_12', 0);
%              pause(0.05);
%          end
%      end
%      pause(0.1);
%  end
%  


%% Summary
% 
% This example introduced the workflow for working with GPIO pins. You
% learned how to connect LEDs and push buttons to GPIO pins.

 