%% Return Control to Invoking Function
% In a file, |returnControlExample.m|, in your current working folder, create the
% following function to find the index of the first occurrence of the
% square root of a value within an array. This function calls the
% |findSqrRootIndex| function you created in the previous example.
% 
% <include>returnControlExample.m</include>
%
% At the command prompt, call the function.
returnControlExample(49)
%%
% When MATLAB encounters the |return| statement within |findSqrRootIndex|, it
% returns control to the invoking function, |returnControlExample|, and displays the
% relevant message.

%% 
% Copyright 2012 The MathWorks, Inc.