%% Create Handles to Local Functions in Script File
% As of R2016b, you can include local functions in scripts. Therefore, you
% can use the |localfunctions| function to create function handles that you
% can invoke in the script or at the command prompt.
%
% Create the following script in a file, |mystats.m|, in your working folder.
% The script creates a cell array with handles to all the local functions.
% 
% <include>mystats.m</include>
%
%%
% Run the script. MATLAB&reg; computes the average by directly invoking the
% mymean local function and the median by invoking |mymedian| local function
% through a function handle.
mystats
%%
% At the command prompt, call the |mymean| local function using its handle.
% Variables from the script are accessible at the command prompt. The
% |mymean| function handle is the first element in the cell array.
x2 = [1 1 2 6 24 120 720 5040];
fh
avg2 = fh{2}(x2)

%% 
% Copyright 2012 The MathWorks, Inc.