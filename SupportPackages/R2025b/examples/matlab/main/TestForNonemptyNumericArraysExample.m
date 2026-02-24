%% Test for Nonempty Numeric Arrays

% Copyright 2020 The MathWorks, Inc.

%%
% Create a test case for interactive testing.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% Verify that the vector |[2 3]| is not empty. The test passes.
%%
verifyNotEmpty(testCase,[2 3])
%%
% Test if an array with a zero dimension is not empty. The test fails
% because an array with any zero dimension is empty.
%%
verifyNotEmpty(testCase,ones(2,5,0,3))
