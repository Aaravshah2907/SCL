%% Compare Floating-Point Numbers
% Test the result of a floating-point operation.

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
% Compare |0.1*3| to |0.3|. The test fails due to the round-off error in
% floating-point arithmetic.
actual = 0.1*3;
expected = 0.3;
testCase.verifyThat(actual,IsEqualTo(expected))
%%
% Test if the values are within a relative tolerance of |eps|. The test
% passes.
testCase.verifyThat(actual,IsEqualTo(expected, ...
    "Within",RelativeTolerance(eps)))