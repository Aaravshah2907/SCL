%% Compare Values Using |ObjectComparator| Class
% Compare actual and expected values using the |ObjectComparator| class.

% Copyright 2021 The MathWorks, Inc.

%%
% In a file named |MyInt.m| in your current folder, create a subclass of
% the |int8| class.
%%
% 
% <include>MyInt.m</include>
%
%% 
% Import the classes used in this example.
import matlab.unittest.TestCase
import matlab.unittest.constraints.IsEqualTo
import matlab.unittest.constraints.ObjectComparator
import matlab.unittest.constraints.AbsoluteTolerance
%% 
% Create a test case for interactive testing. 
testCase = TestCase.forInteractiveUse;
%%
% Use an |ObjectComparator| instance to compare two |MyInt| objects that
% are constructed with the same input value. The test passes.
testCase.verifyThat(MyInt(10),IsEqualTo(MyInt(10), ...
    "Using",ObjectComparator))
%%
% Compare two |MyInt| objects that are constructed with different input
% values. The test fails.
testCase.verifyThat(MyInt(11),IsEqualTo(MyInt(10), ...
    "Using",ObjectComparator))
%%
% For the test to pass, specify that values must be equal within an 
% absolute tolerance of 1. The value of the tolerance must be of the same
% class as the actual and expected values.
testCase.verifyThat(MyInt(11),IsEqualTo(MyInt(10), ...
    "Using", ObjectComparator("Within",AbsoluteTolerance(MyInt(1)))))