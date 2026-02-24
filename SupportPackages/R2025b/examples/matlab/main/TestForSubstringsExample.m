%% Test for Substrings
% Test if the actual value contains the specified substring.

% Copyright 2020 The MathWorks, Inc.

%%
% Create a test case for interactive testing.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% Define the actual value.
%%
actual = "This is a long message.";
%%
% Verify that |actual| contains the text |"long"|.
%%
verifySubstring(testCase,actual,"long")
%%
% Show that case matters. This test fails because |actual| does not
% contain |"Long"|.
%%
verifySubstring(testCase,actual,"Long","Test is case sensitive.")
%%
% Show that the test fails if the substring is longer than the actual
% string.
%%
verifySubstring(testCase,actual,"This is a long message with extra words.")