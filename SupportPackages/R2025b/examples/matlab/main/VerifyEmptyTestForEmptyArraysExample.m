%% Test for Empty Numeric Arrays
%%
% Create a test case for interactive testing.
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% Verify that an array with a zero dimension is empty.
verifyEmpty(testCase,ones(2,5,0,3))
%%
% Test if the vector |[2 3]| is empty. The test fails.
verifyEmpty(testCase,[2 3],"Value must be empty.")
%% 
% Copyright 2012 The MathWorks, Inc.