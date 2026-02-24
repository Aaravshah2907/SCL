%% Compare Two Numbers

% Copyright 2020 The MathWorks, Inc.

%%
% Create a test case for interactive testing.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% Verify that |3| is greater than |2|.
%%
verifyGreaterThan(testCase,3,2)
%%
% Test if |5| is greater than |9|. The test fails.
%%
verifyGreaterThan(testCase,5,9)
