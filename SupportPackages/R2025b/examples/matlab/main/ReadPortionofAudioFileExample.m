%% Read Portion of Audio File   
% Create a FLAC file from the example file |handel.mat|, and then read only
% the first 2 seconds.   

%% 
% Create a FLAC (|.flac|) file in the current folder. 
load handel.mat

filename = 'handel.flac';
audiowrite(filename,y,Fs);  

%% 
% Read only the first 2 seconds. 
samples = [1,2*Fs];
clear y Fs
[y,Fs] = audioread(filename,samples);  

%% 
% Play the samples. 
sound(y,Fs);   



%% 
% Copyright 2012 The MathWorks, Inc.