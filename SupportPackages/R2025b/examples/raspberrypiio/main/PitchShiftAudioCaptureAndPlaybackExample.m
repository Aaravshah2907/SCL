%% Audio Pitch Shift Using Audio Capture Playback
%
% This example shows you how to shift the pitch of an audio signal on Raspberry Pi(R) hardware using audio capture and playback.
%
% In this example, you will learn how to:
%
% * Acquire audio from a USB microphone or
% a webcam microphone connected to the Raspberry Pi hardware
% * Shift the pitch of the acquired audio
% * Play the processed audio data through the headphone jack of the Raspberry Pi hardware
%
% *NOTE* - This example is applicable only to the installed MATLAB(R) Support 
% Package for Raspberry Pi Hardware. Deploying |audiocapture| and 
% |audioplayer| is not supported in MATLAB Online(TM).

% Copyright 2019 The MathWorks, Inc.

%% Pitch Shifting
%
% Pitch shifting is the ability to modify the pitch of an audio signal to 
% either increase or decrease the pitch. For example, when a fast car 
% passes you in the street, the pitch of the sound from the car increases 
% as the vehicle approaches you and decreases as the vehicle moves away 
% from you. 
% As the source of the audio moves closer or further away from 
% the receiver, the successive signals reach the receiver at either smaller 
% or larger intervals of time. This time difference causes change in the 
% frequency of the audio being heard by the receiver. You can perform a 
% similar pitch-shifting operation by splitting an audio signal into two 
% components, delaying the signals using varying time periods, and then 
% adding them back together. This process simulates the effect of either 
% increasing or decreasing the pitch depending on how the two signals are 
% delayed or overlapped. 
% To ensure uniform power levels, the individual gains for the split 
% signals must be modulated.
%
%% Required Products
%
% * MATLAB Support Package for Raspberry Pi Hardware
% * <https://www.mathworks.com/products/audio.html Audio Toolbox>
%
%% Required Hardware
%
% * Raspberry Pi hardware (Model 3B or 3B+ recommended)
% * Audio capture device: USB microphone or <https://elinux.org/RPi_USB_Webcams webcam microphone>
% * A pair of headphones that can be plugged into the 3.5 mm headphone jack of the hardware
% * USB cable
% * Ethernet cable
% * A monitor connected to the Raspberry Pi hardware and an HDMI cable (optional)
%
%% Step 1: Connect the Raspberry Pi Hardware for Pitch Shift
%
% Before you start this example, we recommend you to complete the 
% <docid:mlsupportpkg.example-raspi_gettingstarted Getting Started with MATLAB Support Package for Raspberry Pi Hardware>
% example.
%
% 1. Connect the micro-USB end of the USB cable to the Raspberry Pi and the 
% regular USB end of the USB cable to the computer. Wait until the PWR LED 
% on the hardware starts blinking.
%
% 2. Connect the webcam or the microphone to one of the USB ports on the 
% hardware. Note that some webcams draw too much power and may require a 
% powered USB hub for proper operation.
%
% 3. Connect a pair of headphones to the 3.5 mm headphone jack of the hardware.
%
% 4. Using the <docid:mlsupportpkg#bt7xwov-2.mw_ce00da2f-bde9-4f39-a69a-a9aaf014dbc0 Hardware Setup> screen, configure the Raspberry Pi network.
%
% <<../pitch_shift_connection.png>>
%
%% Step 2: Change the Audio Output Mode to Headphone Jack
%
% 1. In the hardware terminal, execute this command to open the Software Configuration Tool of the hardware.
%   
%   sudo raspi-config
%
% 2. In the Software Configuration Tool Window, select *Advanced Options* and press *Enter*, then select *Audio* and press *Enter*.
%
% 3. Select the *Force 3.5mm ('headphone') jack* option and press *Enter*.
% 
% 4. Press *OK*. 
%
%% Step 3: Create Capture and Playback Objects 
%
% Create a raspi object.
%
%   rpi = raspi();
%
% Create |captureObj| and |playerObj| system objects for audio processing on
% Raspberry Pi Hardware. 
%
% The |captureObj| is a connection to the audio source device |plughw:1,0|.
% The audio input is captured at a sample rate of 48000, and samples per 
% frame of 4800.
%
%   captureObj = audiocapture(rpi,'plughw:1,0','SampleRate', 48000, 'SamplesPerFrame', 4800);
%
% The |playbackObj| is a connection to the audio player device |plughw:0,1|.
% The audio output is played at a sample rate of 48000.
%
%   playbackObj = audioplayer(rpi,'plughw:0,1', 'SampleRate', 48000);
%
% If you do not know the name of the device, use the listAudioDevices function attached with this example. 
%
%% Step 4: Perform Pitch Shift of Audio Input 
%
% <docid:audio_ug#mw_fb381a97-4bf8-45d8-8b13-4f96722ed1f1 |audiopluginexample.PitchShifter|> is an audio plugin object that performs 
% the pitch shifting algorithm. The plugin parameters are the pitch shift 
% (in semi-tones), the cross-fading factor (which controls the overlap 
% between the two delay branches), and the sampling frequency. The plugin's 
% parameters are tuned by setting their values to the input arguments pitch 
% and overlap, respectively. 
%
%   pitch = -5;         
%   overlap = 0.2;      
%   Fs = 8192;          
% 
% |shiftPitch|, a function that may be used to perform pitch shifting, 
% instantiates an |audiopluginexample.PitchShifter| plugin, and uses the 
% |setSampleRate| method to set its sampling rate to the input argument Fs. 
%
%   pitchShifter = audiopluginexample.PitchShifter('PitchShift',8,'Overlap',0.3);
%   setSampleRate(pitchShifter,Fs);
%
% Capture audio from the input device. The input is of type int16 and needs 
% to be converted to type double before processing the data. 
% This is because the function |shiftPitch| expects all its inputs to be of 
% the same data type. The output data needs to be of type int16 and thus 
% pitchShifted which is a double is cast to be of type int16 before being 
% sent to audio playback device.
%
%   for k = 1:3000
%       input = capture(captureObj);
%       pitchShifted = zeros(size(double(input)),'like',double(input)); 
%       pitchShifter.PitchShift = pitch;
%       pitchShifter.Overlap = overlap;
%       [pitchShifted] = pitchShifter(double(input));
%       play(playbackObj,int16(pitchShifted));
%   end
%
%% Step 5: Deploy the MATLAB Function
% 
% You can deploy the |raspi_pitchshiftdeployment()| function on the
% hardware. 
%
%   function raspi_pitchshiftdeployment()
%     rpi = raspi();
%     captureObj = audiocapture(rpi,'plughw:1,0','SampleRate', 48000, 'SamplesPerFrame', 4800);
%     playbackObj = audioplayer(rpi,'plughw:0,1', 'SampleRate', 48000);
% 
%     pitch = -5;         
%     overlap = 0.2;      
%     Fs = 8192;         
% 
%     pitchShifter = audiopluginexample.PitchShifter('PitchShift',8,'Overlap',0.3);
%     setSampleRate(pitchShifter,Fs);
% 
%    for k = 1:3000
%      input = capture(captureObj);
%      pitchShifted = zeros(size(double(input)),'like',double(input)); %#ok<PREALL>
%      pitchShifter.PitchShift = pitch;
%      pitchShifter.Overlap = overlap;
%     [pitchShifted] = pitchShifter(double(input));
%     play(playbackObj,int16(pitchShifted));
%    end
%   end
%
% Deploy the |raspi_pitchshiftdeployment| function as a standalone executable on the hardware by 
% using the |<docid:mlsupportpkg.mw_a8a63ef5-1af4-460a-8515-2432dd5670b6
% deploy>| function. Note: For Raspberry Pi with 32-bit OS use
% |targetHardware('Raspberry Pi')| and for 64-bit OS use |targetHardware('Raspberry Pi (64bit)')|.
%
%   board = targetHardware(Raspberry Pi (64bit))
%   deploy(board,'raspi_pitchshiftdeployment')
%
%   Code generation successful: View report
%
% The |deploy| function initiates code generation of the |raspi_pitchshiftdeployment| 
% function. At the end of code generation, MATLAB generates a code 
% generation report. Use this report to debug the |raspi_pitchshiftdeployment| function 
% for any build errors and warnings in the generated code.
%
% After successfully generating the code, the support package loads and 
% runs the code as a standalone executable on the hardware. The executable 
% starts acquiring live audio input from the audio device, runs the pitch shift 
% algorithm on the acquired audio, and then plays the result on the playback device.