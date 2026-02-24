%% Add Diagnostics to Execute upon Test Failure

% Copyright 2020 The MathWorks, Inc.

%%
% In your current folder, create the |SampleOnFailureTest| test class.
%
% <include>SampleOnFailureTest.m</include>
%
% At the command prompt, run the tests. The |SampleOnFailureTest| class has 
% these results:
%
% * The diagnostic message |'Failure Detected'| is displayed for each test 
% with a verification, assertion, or fatal assertion failure, because
% |addFailureDiag| calls |onFailure| in a |TestMethodSetup| block.
% * The |verificationFailTest| test adds another diagnostic upon failure that
% displays the current date and time.
% * The |assumptionFailTest| test fails by assumption. Therefore, the
% |'Failure Detected'| message is not displayed.
% * The |assertionFailTest| test plots the data. If the test fails,
% the testing framework saves the plot.
%
%%
results = runtests('SampleOnFailureTest');