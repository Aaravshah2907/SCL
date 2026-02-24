%% Compare Values Using Numeric Tolerances

% Copyright 2020 The MathWorks, Inc.

%%
% Create a test case for interactive testing.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% Test if the actual value |1.5| is equal to the expected value |2|. The
% test fails.
%%
verifyEqual(testCase,1.5,2)
%%
% Verify that the difference between the actual and expected values is
% within |1|.
%%
verifyEqual(testCase,1.5,2,"AbsTol",1)
%%
% Test if the difference between the actual and expected values is
% less than 10%. The test fails.
%%
verifyEqual(testCase,1.5,2, ...
    "Difference must be within relative tolerance.","RelTol",0.1)