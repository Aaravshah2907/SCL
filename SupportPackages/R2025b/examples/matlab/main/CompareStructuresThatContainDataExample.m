%% Compare Structures That Contain Data
% Compare structures that contain data using the |StructComparator| class.

% Copyright 2021 The MathWorks, Inc.

%%
% First, import the classes used in this example.
import matlab.unittest.TestCase
import matlab.unittest.constraints.IsEqualTo
import matlab.unittest.constraints.StructComparator
import matlab.unittest.constraints.NumericComparator
import matlab.unittest.constraints.StringComparator
import matlab.unittest.constraints.RelativeTolerance
%%
% Create a test case for interactive testing.
testCase = TestCase.forInteractiveUse;
%%
% Create two structures whose fields contain numeric values.
s1 = struct("ID",10,"score",90);
s2 = struct("score",90,"ID",10);
%%
% Use a |StructComparator| instance to compare the structures. When
% structure arrays contain data, pass an appropriate comparator to the
% |StructComparator| constructor. The test passes.
testCase.verifyThat(s1,IsEqualTo(s2, ...
    "Using",StructComparator(NumericComparator)))
%%
% Change one of the values contained in |s2| and compare the structures
% again. The test fails.
s2.score = 95;
testCase.verifyThat(s1,IsEqualTo(s2, ...
    "Using",StructComparator(NumericComparator)))
%%
% For the test to pass, specify that corresponding values must be equal
% within a relative tolerance of 0.1.
testCase.verifyThat(s1,IsEqualTo(s2, ...
    "Using",StructComparator(NumericComparator( ...
    "Within",RelativeTolerance(0.1)))))
%%
% Compare nested structures containing strings by instructing the 
% comparator to operate recursively. The test fails because the nested
% structures are not equal.
s3 = struct("name",struct("first","Mary","last","Smith"), ...
    "location","Apartment 4");
s4 = struct("name",struct("first","Sam","last","Smith"), ...
    "location","Apartment 4");
testCase.verifyThat(s3,IsEqualTo(s4, ...
    "Using",StructComparator(StringComparator,"Recursively",true)))