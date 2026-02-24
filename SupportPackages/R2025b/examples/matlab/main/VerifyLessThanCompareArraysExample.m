%% Compare Arrays

% Copyright 2020 The MathWorks, Inc.

%%
% Create a test case for interactive testing.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% Test if each element of the array |[5 -3 2]| is less than each
% corresponding element of the ceiling array |[7 -1 8]| .
%%
verifyLessThan(testCase,[5 -3 2],[7 -1 8])
%%
% Compare an array to itself. The test fails.
%%
verifyLessThan(testCase,eye(2),eye(2))
