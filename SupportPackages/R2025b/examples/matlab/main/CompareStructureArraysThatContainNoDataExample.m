%% Compare Structure Arrays That Contain No Data
% Compare structure arrays that contain no data using the
% |StructComparator| class.

% Copyright 2021 The MathWorks, Inc.

%% 
% First, import the classes used in this example.
import matlab.unittest.TestCase
import matlab.unittest.constraints.IsEqualTo
import matlab.unittest.constraints.StructComparator
%% 
% Create a test case for interactive testing. 
testCase = TestCase.forInteractiveUse;
%%
% Use a |StructComparator| instance to compare two structure arrays with
% no fields. The test fails because the sizes do not match.
testCase.verifyThat(struct,IsEqualTo([struct struct], ...
    "Using",StructComparator))
%%
% Compare two empty structure arrays. Even though the sizes are equal, the
% test fails because the actual and expected structure arrays do not have
% the same fields.
testCase.verifyThat(struct([]),IsEqualTo(struct("f1",{},"f2",{}), ...
    "Using",StructComparator))
%%
% Verify that |struct([])| and |struct.empty| result in the same empty
% structure array.
testCase.verifyThat(struct([]),IsEqualTo(struct.empty, ...
    "Using",StructComparator))