%% Compare Classes

% Copyright 2020 The MathWorks, Inc.

%%
% Create a test case for interactive testing.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% Compare two numeric values of different classes. The test fails.
%%
verifyEqual(testCase,int8(5),int16(5),"Classes must match.")
