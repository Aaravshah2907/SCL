%% Compare Two Numbers

% Copyright 2020 The MathWorks, Inc.

%%
% Create a test case for interactive testing.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% Verify that |2| is less than |3|.
%%
verifyLessThan(testCase,2,3)
%%
% Test if |9| is less than |5|. The test fails.
%%
verifyLessThan(testCase,9,5)

