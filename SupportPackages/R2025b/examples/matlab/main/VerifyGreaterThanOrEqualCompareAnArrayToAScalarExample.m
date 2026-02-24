%% Compare Array to Scalar

% Copyright 2020 The MathWorks, Inc.

%%
% Create a test case for interactive testing.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% Test if each element of the vector |[5 2 7]| is greater than or equal to
% the floor value |2|.
%%
verifyGreaterThanOrEqual(testCase,[5 2 7],2)
%%
% Test if each element of the matrix |[1 2 3; 4 5 6]| is greater than or
% equal to the floor value |4|.
%%
verifyGreaterThanOrEqual(testCase,[1 2 3; 4 5 6],4, ...
    "All elements must be greater than or equal to the floor value.")
