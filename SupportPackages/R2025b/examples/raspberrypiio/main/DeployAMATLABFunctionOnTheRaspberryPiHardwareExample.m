%% Getting Started with Deploying a MATLAB Function on the Raspberry Pi Hardware
% This example shows you how to deploy a MATLAB(R) function as a standalone executable 
% on the Raspberry Pi(R) Hardware using MATLAB Support Package
% for Raspberry Pi Hardware.
%
% To demonstrate the steps in the workflow, this example uses
% a blinking LED function. In this example, you will learn how to create |blinkLED| MATLAB function, prepare the function for deployment, and then deploy the function as a standalone executable on the hardware.
% On successful deployment, the ACT LED on the hardware starts blinking every 0.5 seconds and continues to run even after you disconnect the hardware
% from the computer. For a brief overview on this example, see the
% <https://www.mathworks.com/videos/deploy-matlab-algorithms-on-raspberry-pi-1591965724601.html Deploy MATLAB Algorithms on Raspberry Pi>
% video.

% Copyright 2018 The MathWorks, Inc.

%% Prerequisites
% Before you start with this example, we recommend you to complete these examples:
%
% * <docid:mlsupportpkg.example-raspi_gettingstarted Getting Started with MATLAB Support Package for Raspberry Pi Hardware>
% * <docid:mlsupportpkg.example-raspi_gettingstarted_with_hardware Working with Raspberry Pi Hardware>
%% Required Products
% 
% * Raspberry Pi hardware. Ensure the hardware is connected to the
% internet, when working on MATLAB(R) Online&trade;.
% * A power supply with at least 1A output 
% * MATLAB Coder license
%% Step 1: Create a MATLAB Function
% 1. Copy the |blinkLED| function and paste it in the MATLAB Editor. The
% function implements an algorithm to blink the ACT LED on the Raspberry Pi
% hardware every 0.5 seconds for 100 cycles.
%
% *Note*: MATLAB functions with input or output arguments are not supported for deployment on the hardware.
%%
%  function blinkLED() 
% 
%  % Create a Raspberry Pi object 
%  r= raspi(); 
% 
%  % Blink the LED for 100 cycles 
%  for count = 1:100 
%      % Turn on the LED 
%      writeLED(r,"LED0", 1); 
%      % Pause for 0.5 seconds 
%      pause(0.5); 
%      % Turn off the LED 
%      writeLED(r,"LED0", 0); 
%      % Pause for 0.5 seconds 
%      pause(0.5); 
%  end 
%  end 
%%
% 2. Save the function as |blinkLED.m| to a folder to which you have write access.
%
%% Step 2: Run the MATLAB Function Using Live IO from Hardware
% Before deploying the function, running the MATLAB
% function by using live input and output (IO) from the hardware is recommended.
%
% Using live IO enables you to:
%
% * Verify that the MATLAB function is communicating with
% the hardware as expected.
% * Detect run-time errors, such as peripheral conflicts, that are much harder to diagnose during deployment.
% 
% Run the |blinkLED| function by using the |run| command in the MATLAB Command Window. When you run the |blinkLED| function, MATLAB connects to the hardware and starts executing the function on the hardware. 
% The ACT LED starts blinking every 0.5 seconds.
%% 
% run blinkLED
%%
% 
% Before proceeding, fix any errors you might have detected in this step.
%% Step 3: Add the Compilation Directive to the MATLAB Function
% Add the |%#codegen| directive (or pragma) after the |blinkLED| function signature to indicate that you intend to deploy the MATLAB function on the hardware. Adding this directive instructs the MATLAB Code Analyzer to help you diagnose and fix violations that would result in errors during deployment.
%
%  function blinkLED() %#codegen
%
%% Step 4: Check the MATLAB Function Using Code Analyzer
% The Code Analyzer checks the MATLAB function for code violations at design time, minimizing compilation errors. The code analyzer continuously checks your code as you enter it. It reports problems and recommends modifications.
%
% Check the |blinkLED| function for any errors and warnings by following the steps in
% <docid:mlsupportpkg.mw_c1e35b00-a28c-4e0a-9761-5f5935961dcb Check
% Code with Code Analyzer> and fix them before proceeding to the next step.
%
% The analyzer provides an indicator in the top right of the editor window. The color of the indicator helps you identify if the function has any errors or warnings.
%
%      Color of Indicator   | Description
%    _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
%      Green                | Function has no errors or warnings 
%      Orange               | Function has warnings
%      Red                  | Function has errors 
% 
% In this example, the green color of the indicator specifies that the |blinkLED| function has no errors or warnings.
%
% <<../code_analyzer_errorfree.png>>
%% Step 5: Check the MATLAB Function for Unsupported calls
% Debug the |blinkLED| function and ensure if all the calls in the function are supported by code generation.
%
% To fix the unsupported function call errors, perform one of these steps:
%
% 1. *Declare the function as coder.extrinsic*: When you declare a function
% call as an extrinsic function, the code generator does not produce code
% for that function. It instead dispatches them to MATLAB for execution. For more
% information, see <docid:coder_ug.bq1h2z9-40 Declaring MATLAB Functions as
% Extrinsic Functions>.
%
% 2. *Replace with an equivalent call supported by code generation*:
% Replace the unsupported calls with an equivalent call that is
% supported by code generation. Including calls supported by code generation ensures that the function will behave the same as tested in *Run the Function Using Live IO from Hardware* after the deployment.
% 
% Some of the calls supported by code generation are listed here:
%
% * <docid:coder_ug.mw_83ffe908-fcac-4a11-8657-128c03ddf279 Functions and Objects Supported for C/C++ Code Generation>
% * <docid:coder_ug.bq37cl7 MATLAB Language Features Supported for C/C++ Code Generation>
% * <docid:mlsupportpkg.mw_a2a99c79-55e2-4b2e-b64a-53ddde063d3c Raspberry Pi Peripheral Functions Supported For C Code Generation>
%
% In this example, all the functions are supported by code generation.
 
%%
%% Step 6: Create a Hardware Configuration Object
% 1. Create a hardware configuration object by using the
% |<docid:mlsupportpkg.mw_113cf339-3bf2-4736-aa57-af1fd0c9897c
% targetHardware>| function in the MATLAB Command Window. Note: For
% Raspberry Pi with 32-bit OS use |targetHardware('Raspberry Pi')| and for 64-bit OS use |targetHardware('Raspberry Pi (64bit)')|.
%%
%  board = targetHardware('Raspberry Pi (64bit)')
%%
%%
%  board = 
% 
%  targetHardware with properties:
% 
%              Name: 'Raspberry Pi (64bit)'
%     DeviceAddress: '176.93.236.232'
%          Username: 'pi'
%          Password: '*********'
%          BuildDir: '/home/pi'
%       BuildAction: 'Build, load, and run'
%
% *Note*: You can deploy the |blinkLED| MATLAB function from MATLAB(R)
% Online&trade;. See
% <docid:mlsupportpkg.mw_37fe1f7c-380a-4205-8f06-8dfdb9683f20 Connect
% to Raspberry Pi Hardware Board in MATLAB Online> for the steps.
%
% Create a hardware configuration object. 
% 
%  board = targetHardware('Raspberry Pi (64bit)')
%
%%
%  board = 
% 
%  targetHardware with properties:
% 
%              Name: 'Raspberry Pi (64bit)'
%     DeviceAddress: '00000000a9f2c18c'
%            Username: ''
%            Password: ''
%            BuildDir: '/home/matlabrpi'
%     EnableRunOnBoot: 0
%         BuildAction: 'Build, load, and run'
%         CoderConfig: [1x1 coder.CodeConfig]
%
% In  MATLAB Online&trade;, |DeviceAddress| is the |SerialNumber| of the hardware 
% as displayed by |raspilist|.
%%
% 2. Verify the |DeviceAddress|, |Username|, and |Password| properties listed in the output. If required, change the value of the properties by using dot notation syntax.
%
% For example, to change the device address to |173.21.22.327|, enter:
%%
%  board.DeviceAddress = '173.21.22.327'
%%
%% Step 7: Deploy the MATLAB Function on Hardware
% Deploy the MATLAB function as a standalone executable on the hardware by using the |<docid:mlsupportpkg.mw_a8a63ef5-1af4-460a-8515-2432dd5670b6 deploy>| function.
%%
%  deploy(board,'blinkLED')
%%
%%
% Code generation successful: View report
%%
% The |deploy| function initiates code generation of the |blinkLED| function. At the end of code generation, MATLAB generates a code generation report. Use this report to debug the |blinkLED| function for any build errors and warnings in the generated code.
%
% After successfully generating the code, the support package loads and runs the code as a standalone executable on the hardware. The executable starts blinking the ACT LED on the hardware every 0.5 seconds. The blinking continues for 100 cycles.  
%
% <<../blinkLEDCodegenReport.PNG>>
%
%% See Also
%
% * Video series: <https://www.mathworks.com/videos/series/raspberry-pi-support-from-matlab.html Raspberry Pi Support from MATLAB>
% * Video: <https://www.mathworks.com/videos/deploy-matlab-algorithms-on-raspberry-pi-1591965724601.html Deploy MATLAB Algorithms on Raspberry Pi>
% * <docid:mlsupportpkg#example-edge_detection_deployment Deploy an Edge Detection Algorithm on the Raspberry Pi Hardware>
% * Video: <https://www.mathworks.com/videos/deploy-an-edge-detection-algorithm-on-raspberry-pi-1591967219707.html
% Deploy an Edge Detection Algorithm on the Raspberry Pi Hardware>