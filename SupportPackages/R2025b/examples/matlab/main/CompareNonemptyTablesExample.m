%% Compare Nonempty Tables
% Compare tables that contain nonempty variables using the
% |TableComparator| class.

% Copyright 2021 The MathWorks, Inc.

%%
% First, import the classes used in this example.
import matlab.unittest.TestCase
import matlab.unittest.constraints.IsEqualTo
import matlab.unittest.constraints.TableComparator
import matlab.unittest.constraints.NumericComparator
import matlab.unittest.constraints.AbsoluteTolerance
%%
% Create a test case for interactive testing.
testCase = TestCase.forInteractiveUse;
%%
% Create two tables whose variables contain numeric values.
LastName = ["Lin";"Jones";"Brown"];
Age = [38;40;49];
Height = [64;67;64];
Weight = [131;133;119];
BloodPressure = [125 83; 117 75; 122 80];
T1 = table(Age,Height,Weight,BloodPressure);
T2 = table(Age,Height,Weight,BloodPressure,'RowNames',LastName);
%% 
% Use a |TableComparator| instance to compare the tables. To compare 
% nonempty tables, pass an appropriate comparator to the |TableComparator|
% constructor. 
testCase.verifyThat(T1,IsEqualTo(T2, ...
    "Using",TableComparator(NumericComparator)))
%%
% Even though the table variables contain the same numeric data, the test
% fails because the |RowNames| property has different values on |T1| and
% |T2|. For the test to pass, set the |RowNames| property on |T1|.
T1.Properties.RowNames = LastName;
testCase.verifyThat(T1,IsEqualTo(T2, ...
    "Using",TableComparator(NumericComparator)))
%%
% Change one of the values in |T2| and compare the tables again. The test
% fails.
T2.Age(end) = 50;
testCase.verifyThat(T1,IsEqualTo(T2, ...
    "Using",TableComparator(NumericComparator)))
%%
% Specify that corresponding values in the table variables must be equal
% within an absolute tolerance of 1. The test passes.
testCase.verifyThat(T1,IsEqualTo(T2, ...
    "Using",TableComparator( ...
    NumericComparator("Within",AbsoluteTolerance(1)))))
%%
% Modify the tables to contain nested tables. To compare the
% modified tables, instruct |TableComparator| to operate recursively. The
% test passes.
T1.BloodPressure = table([125;117;122],[83;75;80]);
T2 = T1;
testCase.verifyThat(T1,IsEqualTo(T2, ...
    "Using",TableComparator(NumericComparator,"Recursively",true)))