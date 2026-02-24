%% Test Handles for Equality
% Test if the actual value is the same as the specified handle array.

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
% Test if |h1| and |h2| point to the same object. The test fails.
%%
verifySameHandle(testCase,h1,h2,"Values must point to the same object.")
%% 
% Verify that |h2| and |h3| point to the same object.
%%
verifySameHandle(testCase,h2,h3)
%% 
% Verify that |[h2 h3]| and |[h3 h2]| are the same. The test passes
% because the corresponding vector elements point to the same object. 
%%
verifySameHandle(testCase,[h2 h3],[h3 h2])
%% 
% Test if |[h1 h2]| and |[h2 h1]| are the same. The test fails because the
% corresponding vector elements point to different objects.
%%
verifySameHandle(testCase,[h1 h2],[h2 h1])
%% 
% Test if two handle arrays of different shapes are the same. The test
% fails.
%%
verifySameHandle(testCase,[h1 h1 h2 h3],[h1 h1; h2 h3])