%% Compare Arrays with Different Tolerances
% To customize how numeric arrays are compared, use a combination of
% tolerances and constraints in your tests.

% Copyright 2021 The MathWorks, Inc.

%%
% First, import the classes used in this example.
import matlab.unittest.TestCase
import matlab.unittest.constraints.IsEqualTo
import matlab.unittest.constraints.AbsoluteTolerance
import matlab.unittest.constraints.RelativeTolerance
%%
% Create a test case for interactive testing.
testCase = TestCase.forInteractiveUse;
%% 
% Compare two numeric vectors using the |IsEqualTo| constraint. The test
% fails.
exp = [1 100];
act = [1.1 101.1];
testCase.verifyThat(act,IsEqualTo(exp))
%% 
% Perform element-wise comparisons between the vectors using absolute and
% relative tolerances. Verify that corresponding vector elements satisfy 
% either of the tolerances. The test passes. 
absTol = AbsoluteTolerance(1);
relTol = RelativeTolerance(0.02);
testCase.verifyThat(act,IsEqualTo(exp,"Within",absTol | relTol))
%% 
% Now test if all the corresponding elements satisfy the absolute
% tolerance, or if all of them satisfy the relative tolerance. The test
% fails because the first and second elements satisfy only the absolute
% and relative tolerances, respectively.
testCase.verifyThat(act, ...
    IsEqualTo(exp,"Within",absTol) | IsEqualTo(exp,"Within",relTol))