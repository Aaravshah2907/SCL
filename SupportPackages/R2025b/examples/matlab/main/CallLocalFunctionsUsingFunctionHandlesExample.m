%% Call Local Functions Using Function Handles
% This example shows how to create handles to local functions. If a
% function returns handles to local functions, you can call the local
% functions outside of the main function. This approach allows you to have
% multiple, callable functions in a single file.
%
% Create the following function in a file, |ellipseVals.m|, in your working
% folder. The function returns a struct with handles to the local
% functions.
%
% <include>ellipseVals.m</include>
%%
% Invoke the function to get a |struct| of handles to the local functions.

% Copyright 2015 The MathWorks, Inc.

h = ellipseVals
%%
% Call a local function using its handle to compute the area of an ellipse.
h.area(3,1)
%%
% Alternatively, you can use the |localfunctions| function to create a cell
% array of function handles from all local functions automatically. This
% approach is convenient if you expect to add, remove, or modify names of
% the local functions.