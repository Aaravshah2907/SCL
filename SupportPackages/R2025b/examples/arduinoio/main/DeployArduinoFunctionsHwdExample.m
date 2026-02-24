%% Deploy Arduino Functions to Arduino Hardware Using MATLAB Function Block
% This example shows how to program a MATLAB(R) Function block Simulink(R) 
% Support Package for Arduino(R) Hardware to access
% multiple peripherals on the Arduino(R) hardware.
%%%
% The <docid:simulink_ref#f7-2761585 MATLAB Function> block enables you to
% implement custom MATLAB functions in a Simulink(R) model. You can use the
% MATLAB Function block to generate readable, efficient, and compact C/C++
% code that can be deployed to the Arduino hardware.
%%%
% For a detailed overview of the MATLAB Function block, see
% <docid:simulink_ug#f6-106262 Implement MATLAB Functions in Simulink with
% MATLAB Function Blocks>.
%%%
% Using the MATLAB Function block for code generation provides:
%%%
% * *Scheduling and Multitasking* &mdash; You can set the sample rate of the
% MATLAB Function block. The generated code runs on the hardware at the
% specified sample rate. With the multitasking mode On, you can run
% different blocks at different rates on the hardware.
% * *Monitor and Tuning* &mdash; You can monitor signals and tune parameters
% by using the Monitor & Tune feature in the Simulink model and observe or
% log the output signal.

% Copyright 2023 The MathWorks, Inc.


%% Supported Hardware
%
% MATLAB Function blocks support code generation on these boards:
% 
% * Arduino Due
% * Arduino Nano 3.0
% * Arduino Uno
% * Arduino Mega 2560
% * Arduino Mega ADK
% * Arduino Leonardo
% * Arduino Micro
% * Arduino MKR1000
% * Arduino MKR1010
% * Arduino MKR Zero


%% Deploy MATLAB IO Functions on Arduino Hardware
%
% Deploy a function that sets the state of an LED pin based on its input,
% generates PWM signals, and reads the analog voltage by using the
% functions listed in <docid:matlab_doccenter#mw_f3fc353d-8465-41db-8547-9a821da5e2c4 Read and Write
% Data>.
% 
% To configure the model on the Arduino board:
% 
% 1. Open the
% <matlab:openExample('arduinoio/DeployArduinoFunctionsHwdExample','supportingFile','arduino_matlab_codegen')
% |arduino_matlab_codegen|> Simulink model.
%%
open_system('arduino_matlab_codegen')
%%
% 2. On the *Hardware* tab, in the *Prepare* section, click *Hardware
% Settings* to open the Configuration Parameters dialog box.
%%%
% 3. Select the *Hardware Implementation* pane and select your Arduino
% hardware from the *Hardware board* parameter list. Do not change any
% other settings. Click OK.
%%%
% 4. To see the function written in the editor, double click the MATLAB
% Function block.
%%%
% Tip: Before you deploy the function, you must validate the function. For
% more information, see the *Run the MATLAB Function* section in this example.
%%%
% 5. To build the model and run it on the hardware, on the *Hardware* tab
% of the Simulink model, in the *Mode* section, select |Run on board|, and
% then click *Build, Deploy & Start*.
%%%
% 6. To perform signal monitoring and parameter tuning, on the *Hardware*
% tab of the Simulink model, in the *Mode* section, select |Run on board|,
% and then click *Monitor & Tune*. For example, you can change the PWM duty
% cycle and observe the generated PWM signal or you can connect the analog
% pins to VCC or GND and log the analog voltages in the scope.
%%%
% Follow the preceding steps for the
% <matlab:openExample('arduinoio/DeployArduinoFunctionsHwdExample','supportingFile','arduino_matlab_codegen_initblock')
% |arduino_matlab_codegen_initblock|> Simulink model. 
%%
open_system('arduino_matlab_codegen_initblock')
%%
% In this model,
% all pin configurations you must perform at the beginning of a program
% execution are in the |init| block. Configuring the pins in the |init|
% block makes the function in the MATLAB function block modular.


%% Run the MATLAB Function
%
% Before deploying the function, run the function in the MATLAB Command Window. You can then:
% 
% * Verify that the MATLAB function communicates with the hardware as expected.
% * Detect run-time errors, such as peripheral conflicts, that are harder
% to diagnose during deployment.

%% Adding Delays
% To add a delay in your function inside the MATLAB Function block, use this snippet:
%
%  if 
%     coder.target('rtw')
%     coder.ceval('delay', duration);
%  end
%
% The duration holds the delay value in milliseconds. Ensure that the total execution time, including the delay, of the MATLAB Function block on the hardware is less than the sample time to avoid overrun condition.

%% Limitation
%
% *Invalid PWM Pins*
%%%
% These PWM pin numbers are not allowed inside a MATLAB Function block.
%%%
% * Arduino Mega 2560, Mega ADK &mdash; 5
% * Arduino Leonardo, Micro &mdash; 5
% * Arduino Uno, Nano3.0 &mdash; 3, 11
% * Arduino Due &mdash; 11, 12
% * Arduino MKR1000, MKR WiFi 1010, MKR Zero &mdash; 4, 5 
%%%
% If you use a PWM function from the MATLAB Support Package for Arduino
% Hardware in the MATLAB function block, then do not use the pins listed in
% this table in the Arduino PWM blocks from the Simulink Support Package
% for Arduino Hardware. Simulink requires a timer for scheduling on the
% Arduino hardware. When a PWM function is used in the MATLAB Function
% Block to generate a PWM signal, a timer is chosen for scheduling on the
% Arduino hardware. The PWM pins connected to that timer therefore cannot be used.
%%%
% *Simulink I/O*
%%%
% If you run Simulink I/O on your model that has the MATLAB Function block
% with <docid:matlab_doccenter#mw_f3fc353d-8465-41db-8547-9a821da5e2c4 Read and Write Data> functions
% and other Simulink Arduino blocks, Simulink I/O does not run on the
% MATLAB Function block. For the other Simulink Arduino blocks, Simulink
% I/O runs normally.
%%%
% *Resource Conflicts*
%%%
% To avoid resource conflicts:
% 
% * Before you access the Arduino peripherals, set the mode of the pins by
% using <docid:mlsupportpkg#bus7qlz-1 |configurePin|> to the mode that you
% plan to use. 
% * Using the same pin across different peripherals in a model may lead to
% undefined behaviour. For example, if you are using
% <docid:mlsupportpkg#buhprtx |readDigitalPin|> to read digital input from
% a pin in the MATLAB Function block, the same pin is not allowed as an
% output pin in another block in your model.

%% Other Things to Try
% You can use the I2C and SPI functions inside MATLAB Function block. 
% See <docid:mlsupportpkg#mw_37828611-6c45-4380-a853-22fa59076405 |Gyroscope-Based Pedometer Using MATLAB Functions|> for more details.