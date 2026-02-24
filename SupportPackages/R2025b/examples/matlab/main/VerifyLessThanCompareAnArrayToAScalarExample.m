%% Compare Array to Scalar

% Copyright 2020 The MathWorks, Inc.

%%
% Create a test case for interactive testing.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% Test if each element of the vector |[5 6 7]| is less than the ceiling
% value |9|.
%%
verifyLessThan(testCase,[5 6 7],9)
%%
% Test if |2| is less than each element of the ceiling vector |[5 6 7]|.
%%
verifyLessThan(testCase,2,[5 6 7])
%%
% Test if each element of the matrix |[1 2 3; 4 5 6]| is less than the
% ceiling value |4|. The test fails.
%%
verifyLessThan(testCase,[1 2 3; 4 5 6],4, ...
    "All elements must be less than the ceiling value.")
