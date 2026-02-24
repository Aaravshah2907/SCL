%% Send Inputs to MATLAB Function from Command Line of Raspberry Pi in MATLAB Online
% This example shows you how to deploy a MATLAB&reg; function that accepts 
% inputs from command line of Raspberry Pi(R) using MATLAB Support 
% Package for Raspberry Pi Hardware in MATLAB Online. In this example, 
% a MATLAB function for adding two numbers is used for deployment.
%
% When you generate code for adding numbers, the Raspberry Pi support 
% package builds the executable on the hardware. You can then provide 
% inputs to the executable as command line arguments. The executable 
% adds the numbers and displays the output on the Raspberry Pi Linux&reg; 
% terminal.
%
% *NOTE*: For the steps on deploying a MATLAB&reg; function that accepts 
% inputs from command line of Raspberry Pi(R) using the installed MATLAB 
% Support Package for Raspberry Pi Hardware, see <docid:mlsupportpkg#example-simplesum_ssh Send Inputs to MATLAB Function from Command Line of Raspberry Pi>

% Copyright 2020 The MathWorks, Inc.

%% Required Hardware
%
% <<../connections.png>>
%
% * Raspberry Pi hardware
% * USB cable
% * A monitor connected to the Raspberry Pi hardware and a HDMI cable (optional)
%
% Ensure the hardware is connected to the internet when working on MATLAB 
% Online. See 
% <docid:mlsupportpkg.mw_37fe1f7c-380a-4205-8f06-8dfdb9683f20 Connect
% to Raspberry Pi Hardware Board in MATLAB Online> for more details.
%% Step 1: Connect the Raspberry Pi Hardware
%
% *Tip*: Before you start this example, we recommend you to complete the 
% <docid:mlsupportpkg.example-raspi_gettingstarted Getting Started
% with MATLAB Support Package for Raspberry Pi Hardware>. 
%
% Connect the micro end of the USB cable to the Raspberry Pi and the 
% regular end of the USB cable to the computer. Wait until the PWR LED on 
% the hardware starts blinking.
%
% In the MATLAB Command Window, create a connection to the Raspberry Pi hardware.
%%
%   r = raspi
%%
%%
%   r =
%
%     raspi with properties:
% 
%          DeviceAddress: 'MLHWPIAA4B'
%           SerialNumber: '100000002880ae4c'
%              BoardName: 'Raspberryi Pi 4 Model B'
%          AvailableLEDs: {'led0'}
%   AvailableDigitalPins: [4,5,6,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27]
%   AvailableSPIChannels: {'CE0','CE1'}
%      AvailableI2CBuses: {'i2c-0','i2c-1'}
%       AvailableWebcams: {}
%            I2CBusSpeed: 100000
% 
%     Supported peripherals
%%
%   clear r;
%% Step 2: Create the Sum Function
%
% In this example, the |simpleSum| function implements the logic for 
% adding two numbers. Create a function |simpleSum| with the code
% generation directive.
%
%% 
%   function simpleSum(a,b)
%   %#codegen
%   assert(all(size(a) ==1));
%   assert(isa(a,'double'));
%   assert(all(size(b) ==1));
%   assert(isa(b,'double'));
%   c = a + b;
%   fprintf('%f +%f = %f\n',a,b,c);
%   end
%% Step 3: Generate C Code for Addition on Raspberry Pi
%
% Create a hardware configuration object by using the 
% |<docid:mlsupportpkg.mw_113cf339-3bf2-4736-aa57-af1fd0c9897c targetHardware>| 
% function in the MATLAB Command Window. Note: For Raspberry Pi with 32-bit
% OS use |targetHardware('Raspberry Pi')| and for 64-bit OS use |targetHardware('Raspberry Pi (64bit)')|.
%%
%   board = targetHardware('Raspberry Pi (64bit)');
%%
% Verify the |DeviceAddress|, |Username|, and |Password| properties listed 
% in the output. If required, change the value of the properties by using 
% the dot notation syntax. 
%
% For example, to change the device address to '100000002880ae4c', enter, 
%%
%   board.DeviceAddress = '100000002880ae4c'
%
% Set the |CoderConfig.GenCodeOnly| property of the board object to true. 
% This enables the support package to generate and run the sum function 
% code only on the host computer.
%
%%
%   board.CoderConfig.GenCodeOnly = true
%%
%%
%   board =
%
%     targetHardware with properties:
%
%               Name: 'Raspberry Pi (64bit)'
%      DeviceAddress: '100000002880ae4c' 
%           Username: ''
%           Password: ''
%           BuildDir: '/home/matlabrpi'
%    EnableRunOnBoot: 0
%        BuildAction: 'Build, load, and run'
%        CoderConfig: [1x1 coder.Config]
%% 
% Deploy the sum function on the hardware by using the |<docid:mlsupportpkg.mw_a8a63ef5-1af4-460a-8515-2432dd5670b6 deploy>| 
% function. The deploy function initiates code generation of the |simpleSum| 
% function. Once code generation is completed, MATLAB generates a code 
% generation report. Use this report to debug the function for any errors 
% and warnings in the generated code.
%
% After successfully generating the code, update the |main.c| file to 
% accept inputs from command line.
%%
%    deploy(board,'simpleSum')
%%
%    Code generation successful: View report
%% Step 4: Edit C Main and H Main Files to Accept Input from Command Line of Raspberry Pi
%
% This section explains how to modify the |main.c| and |main.h| files to accept inputs 
% from command line of Raspberry Pi. Modify the |main.c| and |main.h| files manually by 
% using the steps in this section. You can find the |main.c| and |main.h| files in the
% codegen folder. In this example, you can find |main.c| and |main.h| in
% |codegen/exe/simpleSum|.
%
% Open the |main.c| file and update the file by adding code at the points 
% labeled in this code.
%
% <<../mainc.png>>
%
% Also open the |main.h| file and update the file by adding code at the point
% labeled in this code.
%
% <<../mainh.png>>
%
%% Step 5: Deploy the Function as a Standalone Executable on the Raspberry Pi
% 
% To generate and deploy the code on the hardware, set the 
% |CoderConfig.GenCodeOnly| property of the board object to false and 
% then use the deploy function. Since the deploy function will overwrite 
% the |main.c| file that you edited in the previous section, disable the 
% creation of the file before deployment. 
%
%%
%    board.CoderConfig.CustomSource = {fullfile(pwd,'codegen','exe','simpleSum','main.c')};
%    board.CoderConfig.CustomInclude = {fullfile(pwd,'codegen','exe','simpleSum','main.h')};
%    board.CoderConfig.GenerateExampleMain = 'DoNotGenerate';
%    board.CoderConfig.GenCodeOnly = false
%
%%
%   board =
%
%     targetHardware with properties:
%
%               Name: 'Raspberry Pi (64bit)'
%      DeviceAddress: '100000002880ae4c' 
%           Username: ''
%           Password: ''
%           BuildDir: '/home/matlabrpi'
%    EnableRunOnBoot: 0
%        BuildAction: 'Build, load, and run'
%        CoderConfig: [1x1 coder.Config]
%
%%
%    deploy(board,'simpleSum')
%%
%    Code generation successful: View report
%
% The deploy function initiates code generation of the |simpleSum| function.
% After successfully generating the code, the support package loads the 
% sum function as a standalone executable on the hardware. 
% The location of the executable is displayed in the MATLAB Command Window. 
% 
%%
%   /home/matlabrpi/MATLAB_ws/R2020b/MATLAB_Drive/
%% Step 6: Run the Executable Program to Add Numbers
%
% Open an SSH terminal with Raspberry Pi. You can use Putty to connect to 
% Hardware or directly use SSH commands in terminal for Unix. 
% In the terminal, log in by entering the user name and password for the 
% Raspberry Pi.
%
% Change the current directory to the directory where the executable was 
% saved on the Raspberry Pi. This is the location that you noted in the 
% previous step. 
%
%%
%   cd /home/matlabrpi/MATLAB_ws/R2020b/MATLAB_Drive/
%
% Run the executable on the Raspberry Pi by providing inputs to the executable.
% 
%%
%   ./simpleSum.elf 7 8
%
% The executable adds the numbers and displays the output on the Linux 
% terminal of Raspberry Pi.
%
% <<../terminal.png>>