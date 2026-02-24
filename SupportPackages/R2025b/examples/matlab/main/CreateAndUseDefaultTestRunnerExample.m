%% Create and Use Default Test Runner
% Run a suite of tests with a default runner and access the results.

% Copyright 2022 The MathWorks, Inc.

%% 
% Create a function-based test |sampleTest.m| in your current folder. The
% file contains two tests that pass and one test that intentionally fails.
% 
% <include>sampleTest.m</include>
%
%% 
% Create a test suite from the tests in |sampleTest.m|. Then, create a
% default runner and run the tests.
%%
suite = testsuite('SampleTest');
runner = testrunner;
results = run(runner,suite);
%% 
% Display the results from the second test.
%%
results(2)
%% 
% When you run tests with a default runner, the testing framework uses
% a |DiagnosticsRecordingPlugin| instance to record diagnostics on test
% results. Access the recorded diagnostics for the second test using
% the |DiagnosticRecord| field in the |Details| property on the
% |TestResult| object.
%%
records = results(2).Details.DiagnosticRecord