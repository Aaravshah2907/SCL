%% Compare Two Numbers

% Copyright 2020 The MathWorks, Inc.

%%
% Create a test case for interactive testing.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% Verify that |2| is less than or equal to |3|.
%%
verifyLessThanOrEqual(testCase,2,3)
%%
% Verify that |3| is less than or equal to |3|.
%%
verifyLessThanOrEqual(testCase,3,3)
%%
% Test if |9| is less than or equal to |5|. The test fails.
%%
verifyLessThanOrEqual(testCase,9,5)
