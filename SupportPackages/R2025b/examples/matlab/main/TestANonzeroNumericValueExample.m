%% Test a Nonzero Numeric Value
% When you test using |verifyTrue|, the test fails if the actual value is 
% not of type |logical|.

% Copyright 2020 The MathWorks, Inc.

%%
% Create a test case for interactive testing. 
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%% 
% Test the value |1|. The test fails because the value is of type |double|.
%%
verifyTrue(testCase,1,"Value must be a logical scalar.")
