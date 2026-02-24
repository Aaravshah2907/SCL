%% Compare Values Using |LogicalComparator| Class
% Compare actual and expected values using the |LogicalComparator| class.

% Copyright 2021 The MathWorks, Inc.

%% 
% First, import the classes used in this example.
import matlab.unittest.TestCase
import matlab.unittest.constraints.IsEqualTo
import matlab.unittest.constraints.LogicalComparator
%% 
% Create a test case for interactive testing. 
testCase = TestCase.forInteractiveUse;
%%
% Use a |LogicalComparator| instance to compare the actual and expected
% values. The test passes because the actual and expected values are both
% |true|.
testCase.verifyThat(true,IsEqualTo(true,"Using",LogicalComparator))
%%
% Compare the value of |false| to |true|. The test fails.
testCase.verifyThat(false,IsEqualTo(true,"Using",LogicalComparator))
%%
% Compare |[true true]| to |true|. The test fails because the actual and
% expected values are not the same size.
testCase.verifyThat([true true],IsEqualTo(true,"Using",LogicalComparator))
%%
% Compare the value |1| to |true|. The test fails because the actual value
% is of type |double|.
testCase.verifyThat(1,IsEqualTo(true,"Using",LogicalComparator))