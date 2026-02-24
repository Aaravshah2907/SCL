%% Test Handles for Inequality
% Test if the actual value is not the same as the specified handle array.

% Copyright 2020 The MathWorks, Inc.

%%
% In a file in your current folder, create the |ExampleHandle| handle
% class.
%%
% 
% <include>ExampleHandle.m</include>
%
%% 
% Create two |ExampleHandle| objects assigned to the variables |h1| and
% |h2|. Then, assign the value of |h2| to another variable |h3|. The
% variables |h1| and |h2| point to different objects, but the variables 
% |h2| and |h3| point to the same object.
%%
h1 = ExampleHandle;
h2 = ExampleHandle;
h3 = h2;
%% 
% Create a test case for interactive testing.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%% 
% Verify that |h1| and |h2| point to different objects.
%%
verifyNotSameHandle(testCase,h1,h2)
%% 
% Test if |h2| and |h3| point to different objects. The test fails.
%%
verifyNotSameHandle(testCase,h2,h3, ...
    "Values must point to different objects.")
%% 
% Verify that |[h1 h2]| is not the same as |[h2 h1]|. The test passes
% because the corresponding vector elements point to different objects.   
%%
verifyNotSameHandle(testCase,[h1 h2],[h2 h1])
%% 
% Test if |[h2 h3]| is not the same as |[h3 h2]|. The test fails 
% because the corresponding vector elements point to the same object.
%%
verifyNotSameHandle(testCase,[h2 h3],[h3 h2])
%% 
% Verify that two handle arrays of different shapes are not the same.
%%
verifyNotSameHandle(testCase,[h1 h1 h2 h3],[h1 h1; h2 h3])