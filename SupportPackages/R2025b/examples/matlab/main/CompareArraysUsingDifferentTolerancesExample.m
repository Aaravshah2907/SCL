%% Compare Arrays Using Different Tolerances
% Compare numeric arrays using a combination of absolute and relative
% tolerances.

% Copyright 2023 The MathWorks, Inc.

%%
% Create a test case for interactive testing.
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% Compare two numeric vectors using the |verifyEqual| method. The test
% fails.
expected = [1 100];
actual = [1.1 101.1];
verifyEqual(testCase,actual,expected)
%%
% Perform element-wise comparisons between the vectors using absolute
% and relative tolerances. Test if corresponding vector elements
% satisfy either of the tolerances. The test passes.
verifyEqual(testCase,actual,expected,"AbsTol",1,"RelTol",0.02)
%%
% Test again using only one of the specified tolerances. This test fails
% because only the first elements satisfy the absolute tolerance.
verifyEqual(testCase,actual,expected,"AbsTol",1)
