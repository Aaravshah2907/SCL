%% Compare Values Using |DictionaryComparator| Class
% Compare actual and expected values using the |DictionaryComparator|
% class.

% Copyright 2021 The MathWorks, Inc.

%%
% First, import the classes used in this example.
import matlab.unittest.TestCase
import matlab.unittest.constraints.IsEqualTo
import matlab.unittest.constraints.DictionaryComparator
import matlab.unittest.constraints.NumericComparator
import matlab.unittest.constraints.StringComparator
%%
% Create a test case for interactive testing.
testCase = TestCase.forInteractiveUse;
%% 
% Use a |DictionaryComparator| instance to compare two unconfigured 
% dictionaries with no keys or values. The test passes.
testCase.verifyThat(dictionary,IsEqualTo(dictionary, ...
    Using=DictionaryComparator))
%%
% To compare dictionaries that are configured, pass an
% appropriate comparator to the |DictionaryComparator| constructor. For
% example, compare two dictionaries containing numeric values. The test
% passes.
d1 = dictionary(["key1" "key2"],[1 2]);
d2 = dictionary("key1",1,"key2",2);
testCase.verifyThat(d1,IsEqualTo(d2, ...
    Using=DictionaryComparator(NumericComparator)))
%%
% Modify one of the dictionaries by introducing a new key-value pair. If 
% you compare the dictionaries again, the test fails because the
% dictionaries do not have the same keys.
d1("key3") = 4;
testCase.verifyThat(d1,IsEqualTo(d2, ...
    Using=DictionaryComparator(NumericComparator)))
%%
% Compare nested dictionaries that contain strings by instructing the
% comparator to operate recursively. The test passes.
group1 = dictionary([1 2],["Andy" "David"]);
group2 = dictionary([1 2 3],["Katia" "Curtis" "Nick"]);
d3 = dictionary("g1",group1,"g2",group2);
d4 = dictionary("g2",group2,"g1",group1);
testCase.verifyThat(d3,IsEqualTo(d4, ...
    Using=DictionaryComparator(StringComparator,Recursively=true)))