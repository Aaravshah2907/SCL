%% Test MATLAB Logical Functions

% Copyright 2020 The MathWorks, Inc.

%%
% Create a test case for interactive testing.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% Test |true|.
%%
verifyTrue(testCase,true)
%%
% Test |false|.
%%
verifyTrue(testCase,false)
