%% Test Logical Functions

% Copyright 2020 The MathWorks, Inc.

%%
% Create a test case for interactive testing.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% Test |true|.
%%
verifyFalse(testCase,true)
%%
% Test |false|.
%%
verifyFalse(testCase,false)
