%% Create System.Double .NET Jagged Array
% This example shows how to create a .NET jagged array of
% |System.Double| using the |NET.createArray| function.
%% 
% Create a three element array. You can pass |jArr| to any
% .NET method with an input or output argument of type |System.Double[][]|.
jArr = NET.createArray('System.Double[]',3)

%% 
% Copyright 2012 The MathWorks, Inc.