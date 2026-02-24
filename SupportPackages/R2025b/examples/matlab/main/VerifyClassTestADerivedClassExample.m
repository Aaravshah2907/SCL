%% Test Instance of a Derived Class
% Use the |verifyClass| method to test for exact class match.

% Copyright 2020 The MathWorks, Inc.

%%
% In a file in your current folder, create the |ExampleHandle| handle 
% class.
%
% <include>ExampleHandle.m</include>
%
%%
% Create an instance of the defined class.
%%
actual = ExampleHandle;
%%
% Create a test case for interactive testing, and then verify that the
% class of |actual| is |ExampleHandle|.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
verifyClass(testCase,actual,?ExampleHandle)
%%
% Repeat the test using the |handle| class. The test fails because |handle|
% is not the exact class of the actual value.
%%
verifyClass(testCase,actual,?handle)