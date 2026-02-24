%% Combine Absolute and Relative Tolerances
% Compare actual and expected values using a combination of numeric
% tolerances. To combine tolerances, use the |&| and ||| operators.

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
% Compare the value |3.14| to |pi|. The test fails.
testCase.verifyThat(3.14,IsEqualTo(pi))
%% 
% Compare the values using an absolute tolerance and a relative tolerance.
% Verify that the actual and expected values are equal within the absolute
% tolerance, the relative tolerance, or both. The test passes. 
tol1 = AbsoluteTolerance(0.001);
tol2 = RelativeTolerance(0.0025);
testCase.verifyThat(3.14,IsEqualTo(pi, ...
    "Within",tol1 | tol2))
%% 
% Test if the actual and expected values are equal within both the
% tolerances. The test fails because the absolute tolerance is not
% satisfied.
testCase.verifyThat(3.14,IsEqualTo(pi, ...
    "Within",tol1 & tol2))