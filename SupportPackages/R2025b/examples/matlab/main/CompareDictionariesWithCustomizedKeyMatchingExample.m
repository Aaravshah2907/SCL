%% Compare Dictionaries with Customized Key Matching
% 
% Compare dictionaries with keys whose class overloads the 
% <docid:matlab_ref#mw_7187a3e7-3063-44a3-a4c5-edb3f172719e> and
% <docid:matlab_ref#mw_c0da410d-1cf1-47ec-9667-e07971c20b51> functions. 
% The testing framework uses the overloaded functions to identify matching
% dictionary keys when comparing the actual and expected values.

% Copyright 2021 The MathWorks, Inc.

%%
% In a file named |Match.m| in your current folder, create the
% |Match| class that overloads the |keyHash| and |keyMatch| functions.
% When objects of the |Match| class are used as keys, MATLAB ignores the
% timestamps.
%%
% 
% <include>Match.m</include>
%
%% 
% Import the classes used in this example.
import matlab.unittest.TestCase
import matlab.unittest.constraints.IsEqualTo
import matlab.unittest.constraints.DictionaryComparator
import matlab.unittest.constraints.NumericComparator
%% 
% Create a test case for interactive testing. 
testCase = TestCase.forInteractiveUse;
%%
% Create two |Match| objects and compare them using the |IsEqualTo|
% constraint. In this example, the test fails because of the
% different values in the |Timestamp| property.
m1 = Match("soccer");
pause(1)
m2 = Match("soccer");
testCase.verifyThat(m1,IsEqualTo(m2))
%%
% Create two dictionaries that contain the same numeric value using |m1|
% and |m2| as keys, and then compare the dictionaries. Even though |m1| and
% |m2| are not equal due to different values of the |Timestamp| property,
% the test passes because the framework treats |m1| and |m2| as the same
% key.
d1 = dictionary(m1,2022);
d2 = dictionary(m2,2022);
testCase.verifyThat(d1,IsEqualTo(d2, ...
    Using=DictionaryComparator(NumericComparator)))