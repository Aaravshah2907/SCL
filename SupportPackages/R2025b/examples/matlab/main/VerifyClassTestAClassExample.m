%% Test Numeric Values


% Copyright 2020 The MathWorks, Inc.

%%
% Create a test case for interactive testing.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% Verify that the class of the numeric value |5| is |double|.
%%
verifyClass(testCase,5,"double")
%%
% Repeat the test using a |matlab.metadata.Class| instance instead of a
% string.
%%
verifyClass(testCase,5,?double)
%%
% Test if zero is a logical value. The test fails.
verifyClass(testCase,0,"logical","Value must be logical.")