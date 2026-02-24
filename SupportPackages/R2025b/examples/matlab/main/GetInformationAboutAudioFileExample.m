%% Get Information About Audio File
% Create a WAVE file from the example file |handel.mat|, and get information about the file.

%%
% Create a WAVE (.wav) file in the current folder.
load handel.mat
filename = 'C:\Temp\handel.wav';
audiowrite(filename,y,Fs);
clear y Fs

%% 
% Use |audioinfo| to return information about the WAVE file.
info = audioinfo(filename)


%% 
% Copyright 2012 The MathWorks, Inc.