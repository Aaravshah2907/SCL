%% Create Handles to Local Functions in Function File
% Create the following function in a file, |computeEllipseVals.m|, in your working
% folder. The function returns a cell array with handles to all the local
% functions.
% 
% <include>computeEllipseVals.m</include>
%
%%
% At the command prompt, invoke the function to get a cell array of handles to the local functions.
fh = computeEllipseVals
%%
% Call a local function using its handle to compute the area of an ellipse.
% The |computeArea| function handle is the third element in the cell array.
fh{3}(3,1)

%% 
% Copyright 2012 The MathWorks, Inc.