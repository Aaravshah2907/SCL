%% Test Logical Arrays
% When you test using |verifyTrue|, the test fails if the actual value is
% nonscalar.

% Copyright 2020 The MathWorks, Inc.

%%
% Create a test case for interactive testing. 
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%% 
% Test the value |[true true]|. The test fails because the value is
% nonscalar.
%%
verifyTrue(testCase,[true true])
