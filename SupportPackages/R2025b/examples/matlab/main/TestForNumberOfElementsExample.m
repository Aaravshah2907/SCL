%% Test for Numbers of Elements
% Test if the actual value has the specified number of elements.

% Copyright 2020 The MathWorks, Inc.

%% 
% Create a test case for interactive testing. 
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%% 
% Verify that a scalar has an element count of one.
%%
verifyNumElements(testCase,3,1)
%% 
% Test the element count of a matrix |[1 2 3; 4 5 6]|. The test fails
% because the matrix has six elements.
%%
verifyNumElements(testCase,[1 2 3; 4 5 6],5)
%% 
% Verify that an identity matrix has the expected number of elements.
%%
n = 7;
verifyNumElements(testCase,eye(n),n^2)
%% 
% Test the element count of a cell array of character vectors.
%%
actual = {'Mercury','Gemini','Apollo'};
verifyNumElements(testCase,actual,3)
%% 
% Test the element count of a scalar structure with two fields. The test
% fails because the structure has only one element.
%%
s.field1 = 1;
s.field2 = zeros(1,10);
verifyNumElements(testCase,s,2,"Value must have two elements.")
