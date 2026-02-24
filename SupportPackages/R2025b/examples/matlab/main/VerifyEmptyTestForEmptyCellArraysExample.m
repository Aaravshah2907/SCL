%% Test for Empty Cell Arrays
%%
% Create a test case for interactive testing.
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% Test an empty cell array. The test passes.
verifyEmpty(testCase,{})
%%
% Test a cell array of empty numeric arrays. The test fails.
verifyEmpty(testCase,{[],[],[]})
%% 
% Copyright 2012 The MathWorks, Inc.