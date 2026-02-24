%% Sample Range  
% Play the first 3 seconds of audio from the example file |handel.mat|.   

%%  
load handel.mat;
playerObj = audioplayer(y,Fs);
start = 1;
stop = playerObj.SampleRate * 3;

play(playerObj,[start,stop]);   



%% 
% Copyright 2012 The MathWorks, Inc.