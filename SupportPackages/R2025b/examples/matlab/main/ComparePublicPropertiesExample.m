%% Compare Public Properties of Different Types
% Compare the public properties of two objects using a comparator that
% supports all data types.

% Copyright 2021 The MathWorks, Inc.

%%
% In a file named |Student.m| in your current folder, create the
% |Student| class. The class has two public properties and one private
% property.
%%
% 
% <include>Student.m</include>
%
%% 
% Import the classes used in this example.
import matlab.unittest.TestCase
import matlab.unittest.constraints.IsEqualTo
import matlab.unittest.constraints.PublicPropertyComparator
%%
% Create a test case for interactive testing. 
testCase = TestCase.forInteractiveUse;
%%
% Create two |Student| objects and compare them using the |IsEqualTo|
% constraint. In this example, the test fails because of the different
% values in the private property.
s1 = Student("Mary Jones",20,"physics");
s2 = Student("Mary Jones",20,"biology");
testCase.verifyThat(s1,IsEqualTo(s2))
%%
% Repeat the test using a |PublicPropertyComparator| instance. Because the
% |Name| and |Age| properties are of different types, perform the
% comparison by using a comparator that supports all data types. Even
% though |s1.Field| and |s2.Field| have different values, the test passes
% because the comparator examines only the public properties of |s1| and
% |s2|.

testCase.verifyThat(s1,IsEqualTo(s2, ...
    "Using",PublicPropertyComparator.supportingAllValues))
%%
% Create a new |Student| object and compare it to |s1|. The test fails
% because |s1.Name| and |s3.Name| have different values.
s3 = Student("mary jones",20,"chemistry");
testCase.verifyThat(s1,IsEqualTo(s3, ...
    "Using",PublicPropertyComparator.supportingAllValues))
%%
% For the test to pass, use a comparator that ignores case.
testCase.verifyThat(s1,IsEqualTo(s3, ...
    "Using",PublicPropertyComparator.supportingAllValues( ...
    "IgnoringCase",true)))
%%
% Alternatively, you can instruct the comparator to ignore the |Name| 
% property during comparison.
testCase.verifyThat(s1,IsEqualTo(s3, ...
    "Using",PublicPropertyComparator.supportingAllValues( ...
    "IgnoringProperties","Name")))