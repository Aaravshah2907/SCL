%% Test Zero
% When you test using |verifyFalse|, the test fails if the actual value is
% not of type |logical|.

% Copyright 2020 The MathWorks, Inc.

%%
% Create a test case for interactive testing.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% Test the value |0|. The test fails because the value is of type |double|.
%%
verifyFalse(testCase,0,"Value must be a logical scalar.")
