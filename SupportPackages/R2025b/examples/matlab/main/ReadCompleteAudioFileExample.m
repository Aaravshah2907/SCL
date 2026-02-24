%% Read Complete Audio File   
% Create a WAVE file from the example file |handel.mat|, and read the file
% back into MATLAB(R).   

%% 
% Create a WAVE (|.wav|) file in the current folder. 
load handel.mat

filename = 'handel.wav';
audiowrite(filename,y,Fs);
clear y Fs  

%% 
% Read the data back into MATLAB using |audioread|. 
[y,Fs] = audioread('handel.wav');  

%% 
% Play the audio. 
sound(y,Fs);   



%% 
% Copyright 2012 The MathWorks, Inc.