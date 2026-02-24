%% Test a Numeric Value


% Copyright 2020 The MathWorks, Inc.

%%
% Create a test case for interactive testing.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% Verify that a numeric value is an instance of the class |double|.
%%
verifyInstanceOf(testCase,1,"double")
%%
% Test if the value is an instance of the class |logical|. The test fails.
%%
verifyInstanceOf(testCase,1,"logical", ...
    "Value must be an instance of the class logical.")

