%% Compare Empty Tables
% Compare empty tables using the |TableComparator| class.

% Copyright 2021 The MathWorks, Inc.

%% 
% First, import the classes used in this example.
import matlab.unittest.TestCase
import matlab.unittest.constraints.IsEqualTo
import matlab.unittest.constraints.TableComparator
%% 
% Create a test case for interactive testing. 
testCase = TestCase.forInteractiveUse;
%%
% Use a |TableComparator| instance to compare two empty tables. Verify that
% |table| and |table.empty| result in the same empty table.
testCase.verifyThat(table,IsEqualTo(table.empty,"Using",TableComparator))
%%
% Test if two empty tables with different property values are equal. The
% test fails.
T1 = table;
T1.Properties.Description = "First Empty Table";
T2 = table;
T2.Properties.Description = "Second Empty Table";
testCase.verifyThat(T1,IsEqualTo(T2,"Using",TableComparator))