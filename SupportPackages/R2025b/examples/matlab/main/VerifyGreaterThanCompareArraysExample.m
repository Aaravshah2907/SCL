%% Compare Arrays

% Copyright 2020 The MathWorks, Inc.

%%
% Create a test case for interactive testing.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% Test if each element of the array |[5 -3 2]| is greater than each
% corresponding element of the floor array |[4 -9 0]| .
%%
verifyGreaterThan(testCase,[5 -3 2],[4 -9 0])
%%
% Compare an array to itself. The test fails.
%%
verifyGreaterThan(testCase,eye(2),eye(2))