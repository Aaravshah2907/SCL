%% Compare Strings 
% Compare textual values using the |IsEqualTo| constraint.

% Copyright 2021 The MathWorks, Inc.

%%
% First, import the classes used in this example.
import matlab.unittest.TestCase
import matlab.unittest.constraints.IsEqualTo
%% 
% Create a test case for interactive testing. 
testCase = TestCase.forInteractiveUse;
%%
% Concatenate two strings and verify the result. The test passes.
actual = "Milky " + "Way";
expected = "Milky Way";
testCase.verifyThat(actual,IsEqualTo(expected))
%%
% Change the actual value to |"Milky way "|. The test fails because the
% actual and expected values are no longer equal.
actual = "Milky way ";
testCase.verifyThat(actual,IsEqualTo(expected))
%%
% For the test to pass, ignore case and white-space characters.
testCase.verifyThat(actual,IsEqualTo(expected, ...
    "IgnoringCase",true,"IgnoringWhitespace",true))
