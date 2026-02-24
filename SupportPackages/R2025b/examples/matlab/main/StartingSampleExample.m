%% Starting Sample  
% Play audio from the example file |handel.mat| starting 4 seconds from
% the beginning.   

%%  
load handel.mat;
playerObj = audioplayer(y,Fs);
start = playerObj.SampleRate * 4;

play(playerObj,start);   



%% 
% Copyright 2012 The MathWorks, Inc.