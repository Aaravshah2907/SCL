%% Test for Array Lengths
% Test if the actual value has the specified length.

% Copyright 2020 The MathWorks, Inc.

%%
% Create a test case for interactive testing.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% Verify that the row vector |[1 3 5]| has a length of three.
%%
verifyLength(testCase,[1 3 5],3)
%%
% Verify that the length of an array is the length of its largest
% dimension.
%%
verifyLength(testCase,ones(2,5,3),5)
%%
% Test if the length of a 2-by-2 identity matrix is four. The test fails.
%%
verifyLength(testCase,eye(2),4,"Value must have a length of four.")
%%
% Test the length of a cell array of character vectors.
%%
actual = {'Mercury','Gemini','Apollo'; ...
    'Skylab','Skylab B','ISS'};
verifyLength(testCase,actual,3)

