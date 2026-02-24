%% Test for Array Sizes
% Test if the actual value has the specified size.

% Copyright 2020 The MathWorks, Inc.

%% 
% Create a test case for interactive testing. 
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%% 
% Verify that the size of the row vector |[1 3 5]| is |[1 3]|. 
%%
verifySize(testCase,[1 3 5],[1 3])
%% 
% Test the size of a 2-by-5-by-3 array.
%%
verifySize(testCase,rand(2,5,3),[2 5 3])
%% 
% Test if the size of a 2-by-2 matrix is |[4 1]|. The test fails.
%%
verifySize(testCase,eye(2),[4 1],"Value must be a 4-by-1 vector.")
%% 
% Test the size of a cell array of character vectors.
%%
actual = {'Mercury','Gemini','Apollo'};
verifySize(testCase,actual,[1 3])

