%% Compare Numeric Values

% Copyright 2020 The MathWorks, Inc.

%%
% Create a test case for interactive testing.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% Compare a numeric value to itself. The test fails.
%%
verifyNotEqual(testCase,5,5,"Values must be different.")
%%
% Verify that different numeric scalars are not equal.
%%
verifyNotEqual(testCase,4.95,5)
%%
% Verify that values of different sizes are not equal.
%%
verifyNotEqual(testCase,[5 5],5)