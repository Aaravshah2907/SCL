%% Compare Values Using Absolute Tolerance
% Compare actual and expected values using the |AbsoluteTolerance| class.

% Copyright 2021 The MathWorks, Inc.

%%
% First, import the classes used in this example.
import matlab.unittest.TestCase
import matlab.unittest.constraints.IsEqualTo
import matlab.unittest.constraints.AbsoluteTolerance
%%
% Create a test case for interactive testing.
testCase = TestCase.forInteractiveUse;
%% 
% Test if the values |4.1| and |4.5| are equal. The test fails.
testCase.verifyThat(4.1,IsEqualTo(4.5))
%% 
% Repeat the test, specifying an absolute tolerance. Verify that the
% values are equal within a tolerance of |0.5|. The test passes.
testCase.verifyThat(4.1,IsEqualTo(4.5, ...
    "Within",AbsoluteTolerance(0.5)))
%% 
% Test if two cell arrays are equal using a tolerance value of |3|. The 
% test fails because the tolerance applies only to the elements of type
% |double|.
actual = {'abc',123,single(106),int8([1 2 3])};
expected = {'abc',122,single(105),int8([2 4 6])};
testCase.verifyThat(actual,IsEqualTo(expected, ...
    "Within",AbsoluteTolerance(3)))
%% 
% Create an absolute tolerance that supports different numeric types.
% Specify the tolerance values of |3|, |single(1)|, and |int8([1 2 4])|
% for comparing cell array elements of type |double|, |single|, and
% |int8|, respectively. If you compare the cell arrays using this
% tolerance, the test passes.
tol = AbsoluteTolerance(3,single(1),int8([1 2 4]));
testCase.verifyThat(actual,IsEqualTo(expected, ...
    "Within",tol))