%% Compare Array to Scalar

% Copyright 2020 The MathWorks, Inc.

%%
% Create a test case for interactive testing.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% Test if each element of the vector |[5 2 7]| is less than or equal to
% the ceiling value |7|.
%%
verifyLessThanOrEqual(testCase,[5 2 7],7)
%%
% Test if each element of the matrix |[1 2 3; 4 5 6]| is less than or
% equal to the ceiling value |4|.
%%
verifyLessThanOrEqual(testCase,[1 2 3; 4 5 6],4, ...
    "All elements must be less than or equal to the ceiling value.")
