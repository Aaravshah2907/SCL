%% Test if Actual Value Matches Regular Expression

% Copyright 2020 The MathWorks, Inc.

%% 
% Create a test case for interactive testing.
%%
testCase = matlab.unittest.TestCase.forInteractiveUse;
%% 
% Define the actual value.
%%
actual = "Some Text";
%% 
% Verify that the actual value matches |"^Som"|. 
%%
verifyMatches(testCase,actual,"^Som")
%% 
% Show that case matters. The following test fails because the actual value does 
% not start with a lowercase letter.  
%%
verifyMatches(testCase,actual,"^som","Test is case sensitive.")
%% 
% Define another regular expression. The |[Tt]?| contained in the
% expression indicates that either |"T"| or |"t"| matches at that location
% 0 times or 1 time.
%%
expression = "Some [Tt]?ext";
%% 
% Verify that the actual value matches the specified expression.
%%
verifyMatches(testCase,actual,expression)