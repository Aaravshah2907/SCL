%% Compare Values Using |PublicPropertyComparator| Class
% Compare actual and expected values using the |PublicPropertyComparator|
% class.

% Copyright 2021 The MathWorks, Inc.

%%
% In a file named |Employee.m| in your current folder, create the
% |Employee| class. The class has a public property |Name| and a private
% property |Location|.
%%
% 
% <include>Employee.m</include>
%
%% 
% Import the classes used in this example.
import matlab.unittest.TestCase
import matlab.unittest.constraints.IsEqualTo
import matlab.unittest.constraints.PublicPropertyComparator
import matlab.unittest.constraints.StringComparator
%% 
% Create a test case for interactive testing. 
testCase = TestCase.forInteractiveUse;
%%
% Use a |PublicPropertyComparator| instance to compare two empty |Employee|
% objects. The test passes.
testCase.verifyThat(Employee.empty,IsEqualTo(Employee.empty, ...
    "Using",PublicPropertyComparator))
%%
% Create two nonempty |Employee| objects and compare them using the
% |IsEqualTo| constraint. In this example, the test fails because of the
% different values in the |Location| property.
e1 = Employee("Sam","Building A");
e2 = Employee("Sam","Building B");
testCase.verifyThat(e1,IsEqualTo(e2))
%%
% Repeat the test using a |PublicPropertyComparator| instance. To perform
% the comparison, pass an appropriate comparator to the 
% |PublicPropertyComparator| constructor. Even though
% |e1.Location| and |e2.Location| have different values, the test
% passes because the comparator examines only the public property of
% |e1| and |e2|.
testCase.verifyThat(e1,IsEqualTo(e2, ...
    "Using",PublicPropertyComparator(StringComparator)))
%%
% Create a new |Employee| object and compare it to |e1|. The test fails
% because |e1.Name| and |e3.Name| have different values.
e3 = Employee("sam","Building C");
testCase.verifyThat(e1,IsEqualTo(e3, ...
    "Using",PublicPropertyComparator(StringComparator)))
%%
% For the test to pass, use a comparator that ignores case.
testCase.verifyThat(e1,IsEqualTo(e3, ...
    "Using",PublicPropertyComparator( ...
    StringComparator("IgnoringCase",true))))
%%
% Alternatively, you can instruct the comparator to ignore the |Name| 
% property during comparison.
testCase.verifyThat(e1,IsEqualTo(e3, ...
    "Using",PublicPropertyComparator( ...
    StringComparator,"IgnoringProperties","Name")))