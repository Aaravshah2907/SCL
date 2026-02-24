%% Test for Nonempty Character Vectors

% Copyright 2020 The MathWorks, Inc.

%%
% Create a test case for interactive testing.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%% 
% Test an empty character vector. The test fails.
%%
verifyNotEmpty(testCase,'')
