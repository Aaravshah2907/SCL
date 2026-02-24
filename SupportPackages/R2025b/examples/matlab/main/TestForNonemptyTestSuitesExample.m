%% Test for Nonempty Test Suites

% Copyright 2020 The MathWorks, Inc.

%%
% Create a test case for interactive testing.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%% 
% Create and test an empty test suite. The test fails.
%%
emptyTestSuite = matlab.unittest.TestSuite.empty;
verifyNotEmpty(testCase,emptyTestSuite,"Value must be nonempty.")
