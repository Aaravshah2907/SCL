%% Compare Values Using Relative Tolerance
% Compare actual and expected values using the |RelativeTolerance| class.

% Copyright 2021 The MathWorks, Inc.

%%
% First, import the classes used in this example.
import matlab.unittest.TestCase
import matlab.unittest.constraints.IsEqualTo
import matlab.unittest.constraints.RelativeTolerance
%%
% Create a test case for interactive testing.
testCase = TestCase.forInteractiveUse;
%% 
% Test if the values |4.1| and |4.5| are equal. The test fails.
testCase.verifyThat(4.1,IsEqualTo(4.5))
%% 
% Repeat the test, specifying a relative tolerance. Verify that the
% values are equal within 10%. The test passes.
testCase.verifyThat(4.1,IsEqualTo(4.5, ...
    "Within",RelativeTolerance(0.1)))
%% 
% Test if two cell arrays are equal within 2%. The test fails because
% the tolerance applies only to the elements of type |double|.
actual = {'abc',123,single(106)};
expected = {'abc',122,single(105)};
testCase.verifyThat(actual,IsEqualTo(expected, ...
    "Within",RelativeTolerance(0.02)))
%% 
% Create a relative tolerance that supports different numeric types.
% Specify the tolerance values of |0.02| and |single(0.02)| for comparing
% cell array elements of type |double| and |single|, respectively. If you
% compare the cell arrays using this tolerance, the test passes.
tol = RelativeTolerance(0.02,single(0.02));
testCase.verifyThat(actual,IsEqualTo(expected, ...
    "Within",tol))