%% Test for Specified Exceptions
% Test if the actual value is a function handle that throws a specified
% exception.

% Copyright 2020 The MathWorks, Inc.

%%
% Create a test case for interactive testing.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% Verify that the |error| function throws an exception with the expected
% identifier.
%%
verifyError(testCase,@() error("SOME:error:id","Error!"),"SOME:error:id")
%%
% Repeat the test with |"OTHER:error:id"| as the expected error identifier.
% The test fails.
%%
verifyError(testCase,@() error("SOME:error:id","Error!"), ...
    "OTHER:error:id","Error identifiers must match.")
%%
% Test the |rand| function, and also examine the output of the function.
% The test fails because |rand| does not throw any exceptions.
%%
r = verifyError(testCase,@rand,?MException)
%%
% Verify that the test fails if the actual value is not a function handle.
%%
verifyError(testCase,5,?MException)

