%% Test for Warnings
% Test if the actual value is a function handle that issues no warnings.

% Copyright 2020 The MathWorks, Inc.

%%
% Create a test case for interactive testing.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% Verify that a call to |true| does not result in any warnings.
%%
verifyWarningFree(testCase,@true)
%%
% Repeat the test with the |false| function. Examine the output of the
% function.
%%
f = verifyWarningFree(testCase,@false)
%%
% Verify that a call to |size| with an empty array does not result in any
% warnings.
%%
verifyWarningFree(testCase,@() size([]))
%%
% Verify that the test fails if the actual value is not a function handle.
%%
verifyWarningFree(testCase,5,"Value must be a function handle.")
%%
% Test a function that produces a warning. The test fails.
%%
verifyWarningFree(testCase,@() warning("SOME:warning:id","Warning!"))




