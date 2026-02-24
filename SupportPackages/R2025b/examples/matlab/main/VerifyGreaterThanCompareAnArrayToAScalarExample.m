%% Compare Array to Scalar

% Copyright 2020 The MathWorks, Inc.

%%
% Create a test case for interactive testing.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% Test if each element of the vector |[5 6 7]| is greater than the floor
% value |2|.
%%
verifyGreaterThan(testCase,[5 6 7],2)
%%
% Test if |5| is greater than each element of the floor vector |[1 2 3]|.
%%
verifyGreaterThan(testCase,5,[1 2 3])
%%
% Test if each element of the matrix |[1 2 3; 4 5 6]| is greater than the
% floor value |4|. The test fails.
%%
verifyGreaterThan(testCase,[1 2 3; 4 5 6],4, ...
    "All elements must be greater than the floor value.")
