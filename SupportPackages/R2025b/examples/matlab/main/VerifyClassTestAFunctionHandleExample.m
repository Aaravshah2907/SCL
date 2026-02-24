%% Test a Function Handle


% Copyright 2020 The MathWorks, Inc.

%%
% Create a test case for interactive testing.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% Verify that |@sin| is a function handle.
%%
verifyClass(testCase,@sin,?function_handle)
%%
% Repeat the test using the function name |"sin"|. The test fails.
%%
verifyClass(testCase,"sin",?function_handle)