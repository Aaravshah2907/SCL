%% Compare Numeric Values
% Numeric values are equal if they are of the same class with equivalent
% size, complexity, and sparsity.

% Copyright 2020 The MathWorks, Inc.

%%
% Create a test case for interactive testing.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% Verify that a numeric value is equal to itself.
%%
verifyEqual(testCase,5,5)
%%
% Compare values of different sizes. The test fails.
%%
verifyEqual(testCase,[5 5],5)