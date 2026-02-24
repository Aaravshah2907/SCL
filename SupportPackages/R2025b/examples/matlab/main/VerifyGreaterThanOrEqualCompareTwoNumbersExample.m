%% Compare Two Numbers

% Copyright 2020 The MathWorks, Inc.

%%
% Create a test case for interactive testing.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% Verify that |3| is greater than or equal to |2|.
%%
verifyGreaterThanOrEqual(testCase,3,2)
%%
% Verify that |3| is greater than or equal to |3|.
%%
verifyGreaterThanOrEqual(testCase,3,3)
%%
% Test if |5| is greater than or equal to |9|. The test fails.
%%
verifyGreaterThanOrEqual(testCase,5,9)




