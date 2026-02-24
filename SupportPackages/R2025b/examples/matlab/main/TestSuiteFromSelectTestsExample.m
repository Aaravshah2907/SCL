%% Test Suite from Select Tests
% In your working folder, create a class-based test, |testZeros.m|. This
% class contains five test methods.
%
% <include>testZeros.m</include>
%
% The full test suite has 11 test elements: 6 from the |testClass| method,
% 2 from the |testSize| method, and 1 each from the |testDefaultClass|,
% |testDefaultSize|, and |testDefaultValue| methods.
%%
% Create a test suite from the test elements with test names that contain
% |'Default'|.
suite = testsuite('testZeros','Name','*Default*')
%%
% Create a test suite from the test elements that use the |outSize| parameter
% property.
suite = testsuite('testZeros','ParameterProperty','outSize')
%%
% The test suite contains eight tests that use the |outSize| parameter
% property: six from the |testClass| method and two from the |testSize|
% method.

%% 
% Copyright 2012 The MathWorks, Inc.