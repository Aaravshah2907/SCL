%% Compare Values Using |StringComparator| Class
% Compare actual and expected values using the |StringComparator| class.

% Copyright 2021 The MathWorks, Inc.

%% 
% First, import the classes used in this example. 
import matlab.unittest.TestCase
import matlab.unittest.constraints.IsEqualTo
import matlab.unittest.constraints.StringComparator
%% 
% Create a test case for interactive testing. 
testCase = TestCase.forInteractiveUse;
%%
% Use a |StringComparator| instance to compare the string |"Milky Way"| to
% itself. The test passes.
testCase.verifyThat("Milky Way",IsEqualTo("Milky Way", ...
    "Using",StringComparator))
%%
% Change the actual value to |'Milky Way'|. The test fails because the
% actual and expected values do not have the same class.
testCase.verifyThat('Milky Way',IsEqualTo("Milky Way", ...
    "Using",StringComparator))
%%
% Compare |"Milky way "| to |"Milky Way"|. The test fails because the 
% values are not equal. 
testCase.verifyThat("Milky way ",IsEqualTo("Milky Way", ...
    "Using",StringComparator))
%%
% For the test to pass, use a comparator that ignores case and 
% white-space characters.
testCase.verifyThat("Milky way ",IsEqualTo("Milky Way", ...
    "Using",StringComparator( ...
    "IgnoringCase",true,"IgnoringWhitespace",true)))