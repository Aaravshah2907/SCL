%% Test Function with Variable Number of Inputs and Outputs
% Verify that a function throws a specified exception if it is called with
% too many outputs.

% Copyright 2020 The MathWorks, Inc.

%%
% In a file in your current folder, create the |variableNumArguments| 
% function that accepts a variable number of inputs and outputs. If the
% number of outputs is greater than the number of inputs, the function throws
% an exception. Otherwise, it returns the class of inputs.
%
% <include>variableNumArguments.m</include>
%
%%
% Create a test case for interactive testing. Then, test
% |variableNumArguments| when you provide it with two inputs and 
% request the same number of outputs. The test fails because the function
% does not throw the specified exception.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
[c1,c2] = verifyError(testCase,@() variableNumArguments(1,'2'), ...
    "variableNumArguments:TooManyOutputs")
%%
% Verify that if |variableNumArguments| is called with too many outputs, it
% throws an exception with the identifier 
% |"variableNumArguments:TooManyOutputs"|.
%%
[c1,c2,c3] = verifyError(testCase,@() variableNumArguments(1,'2'), ...
    "variableNumArguments:TooManyOutputs")
