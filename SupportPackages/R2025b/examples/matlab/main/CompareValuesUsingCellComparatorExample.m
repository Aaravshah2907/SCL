%% Compare Values Using |CellComparator| Class
% Compare actual and expected values using the |CellComparator| class.

% Copyright 2021 The MathWorks, Inc.

%% 
% First, import the classes used in this example.
import matlab.unittest.TestCase
import matlab.unittest.constraints.IsEqualTo
import matlab.unittest.constraints.CellComparator
import matlab.unittest.constraints.NumericComparator
import matlab.unittest.constraints.AbsoluteTolerance
%% 
% Create a test case for interactive testing. 
testCase = TestCase.forInteractiveUse;
%%
% Use a |CellComparator| instance to compare two empty cell arrays. The
% test fails because the sizes do not match.
testCase.verifyThat({},IsEqualTo(cell(0,2),"Using",CellComparator))
%%
% To compare nonempty cell arrays, pass an appropriate comparator to the
% |CellComparator| constructor. For example, compare a cell array of
% numeric values to itself. The test passes.
testCase.verifyThat({1,2,4},IsEqualTo({1,2,4}, ...
    "Using",CellComparator(NumericComparator)))
%%
% Compare |{1,2,3}| to |{1,2,4}|. For the test to pass, specify that
% corresponding elements must be equal within an absolute tolerance of 1. 
testCase.verifyThat({1,2,3},IsEqualTo({1,2,4}, ...
    "Using",CellComparator(NumericComparator( ...
    "Within",AbsoluteTolerance(1)))))
%%
% Compare nested cell arrays of numeric values by instructing the 
% comparator to operate recursively. The test fails because the nested cell
% arrays are not the same.
testCase.verifyThat({1,2,{4,8}},IsEqualTo({1,2,{4,16}}, ...
    "Using",CellComparator(NumericComparator,"Recursively",true)))