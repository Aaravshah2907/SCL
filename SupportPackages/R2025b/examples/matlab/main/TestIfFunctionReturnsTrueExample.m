%% Test if Function Returns True
% Test if the actual value is a function handle that returns true.

% Copyright 2020 The MathWorks, Inc.

%%
% Create a test case for interactive testing.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% Test the |true| function. 
%%
verifyReturnsTrue(testCase,@true)
%%
%%
% Test the |false| function. The test fails because |false| does not
% return true.
%%
verifyReturnsTrue(testCase,@false)
%%
% Test if a call to |isequal| returns true given two equivalent numeric
% values.
%%
verifyReturnsTrue(testCase,@() isequal(1,single(1)))
%%
% Verify that it is true that two different letters are not the same. 
%%
verifyReturnsTrue(testCase,@() ~strcmp('a','b'))
%%
% Test a function that returns a vector of |true| values. The test fails
% because the returned value is nonscalar.
%%
verifyReturnsTrue(testCase,@() strcmp('a',{'a','a'}))
%%
% Test a function that returns a numeric value. The test fails.
%%
verifyReturnsTrue(testCase,@ones, ...
    "Returned value must be a logical scalar.")