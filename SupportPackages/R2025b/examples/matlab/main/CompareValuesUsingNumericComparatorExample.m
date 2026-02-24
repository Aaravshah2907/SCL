%% Compare Values Using |NumericComparator| Class
% Compare actual and expected values using the |NumericComparator| class.

% Copyright 2021 The MathWorks, Inc.

%% 
% First, import the classes used in this example.
import matlab.unittest.TestCase
import matlab.unittest.constraints.IsEqualTo
import matlab.unittest.constraints.NumericComparator
import matlab.unittest.constraints.AbsoluteTolerance
%% 
% Create a test case for interactive testing. 
testCase = TestCase.forInteractiveUse;
%%
% Use a |NumericComparator| instance to compare a number to itself. The
% test passes.
testCase.verifyThat(3.14,IsEqualTo(3.14,"Using",NumericComparator))
%%
% Compare the value of |pi| to |3.14|. The test fails.
testCase.verifyThat(pi,IsEqualTo(3.14,"Using",NumericComparator))
%%
% Repeat the test using an absolute tolerance of 0.01. The test passes.
testCase.verifyThat(pi,IsEqualTo(3.14, ...
    "Using",NumericComparator("Within",AbsoluteTolerance(0.01))))