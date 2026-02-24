%% Access Diagnostics Recorded by Default Test Runner
% Run a suite of tests using a default test runner, and then access the
% diagnostics recorded on the test results.

% Copyright 2024 The MathWorks, Inc.

%% 
% Create a function-based test file named |sampleTest.m| in your current
% folder. The file contains two tests that pass and one test that
% intentionally fails.
% 
% <include>sampleTest.m</include>
%
%% 
% Create a test suite from the tests in |sampleTest.m|. Then, create a
% default test runner and run the tests.
%%
suite = testsuite("SampleTest");
runner = matlab.unittest.TestRunner.withDefaultPlugins;
results = run(runner,suite);
%% 
% Display the result of the second test.
%%
results(2)
%% 
% A default test runner includes a 
% |matlab.unittest.plugins.DiagnosticsRecordingPlugin| instance to
% record diagnostics on test results. Access the recorded diagnostics
% for the second test using the |DiagnosticRecord| field in the |Details|
% property of the corresponding |TestResult| object.
%%
records = results(2).Details.DiagnosticRecord