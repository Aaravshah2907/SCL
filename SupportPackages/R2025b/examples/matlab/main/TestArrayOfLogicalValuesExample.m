%% Test Array of Logical Values
% When you test using |verifyFalse|, the test fails if the actual value is
% nonscalar.

% Copyright 2020 The MathWorks, Inc.

%%
% Create a test case for interactive testing.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% Test the value |[false false]|. The test fails because the value is
% nonscalar.
%%
verifyFalse(testCase,[false false]) 
