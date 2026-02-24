%% Test Using Constraints
% Test if the actual value satisfies the specified constraint.

% Copyright 2020 The MathWorks, Inc.

%%
% Create a test case for interactive testing.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% Test |true|. Verify that it satisfies the |IsTrue| constraint.  
%%
import matlab.unittest.constraints.IsTrue
verifyThat(testCase,true,IsTrue)
%%
% Test if the strings |"Hello"| and |"hello"| are equal. This test fails
% because the comparison is case sensitive.
%%
import matlab.unittest.constraints.IsEqualTo
verifyThat(testCase,"Hello",IsEqualTo("hello"))
%%
% Test if a cell array containing an empty numeric array is empty. The test
% fails.
%%
import matlab.unittest.constraints.IsEmpty
verifyThat(testCase,{[]},IsEmpty,"Cell array must be empty.")
%%
% Verify that an array does not contain any |NaN| values.
%%
import matlab.unittest.constraints.HasNaN
verifyThat(testCase,[Inf -7+1i],~HasNaN)
%%
% Test if a numeric array has two elements and both of its elements are
% greater than one.  
%%
import matlab.unittest.constraints.HasElementCount
import matlab.unittest.constraints.IsGreaterThan
verifyThat(testCase,[3 5],HasElementCount(2) & IsGreaterThan(1))