%% Test for Specified Warnings
% Test if the actual value is a function handle that issues a specified
% warning.

% Copyright 2020 The MathWorks, Inc.

%%
% Create a test case for interactive testing. 
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% Verify that the |warning| function issues a warning with the expected
% identifier.
%%
verifyWarning(testCase,@() warning("SOME:warning:id","Warning!"), ...
    "SOME:warning:id")
%%
% Repeat the test with "OTHER:warning:id" as the expected warning
% identifier. The test fails.
%%
verifyWarning(testCase,@() warning("SOME:warning:id","Warning!"), ...
    "OTHER:warning:id","Warning identifiers must match.")
%%
% Test the |rand| function, and also examine the output of the function.
% The test fails because |rand| does not issue any warnings. 
%%
r = verifyWarning(testCase,@rand,"SOME:warning:id")
%%
% Verify that the test fails if the actual value is not a function handle.
%%
verifyWarning(testCase,5,"SOME:warning:id")