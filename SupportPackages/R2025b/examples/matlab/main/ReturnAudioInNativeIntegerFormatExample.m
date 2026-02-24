%% Return Audio in Native Integer Format 
% Create a |.flac| file, read the first 2 seconds of the file and then return audio in the native integer format.    

%% 
% Create a FLAC (|.flac|) file in the current folder. 
load handel.mat
filename = 'handel.flac';
audiowrite(filename,y,Fs);  

%% 
% Read only the first 2 seconds and specify the data and view the datatype
% of the sampled data y. The data type of |y| is |double|.
samples = [1,2*Fs];
clear y Fs
[y,Fs] = audioread(filename,samples);  
whos y

%% 
% Request audio data in the native format of the file, and then view the
% data type of the sampled data |y|. Note the new data type of |y|.  
[y,Fs] = audioread(filename,'native');
whos y




%% 
% Copyright 2012 The MathWorks, Inc.