%% Generate Single-File HTML Test Report After Running Tests
% Run a suite of tests and then generate a single-file HTML test report
% from the test results.

% Copyright 2021 The MathWorks, Inc.

%% 
% Create a function-based test |sampleTest.m| in your current folder. The
% file contains two tests that pass and one test that fails.
% 
% <include>SampleTest.m</include>
%
%%
%%
% Run the tests in |sampleTest.m|.
results = runtests("sampleTest");
%%
% In your current folder, generate a single-file HTML test report from the
% test results with |"myTestReport.html"| as the HTML filename.
generateHTMLReport(results,"myTestReport.html")
%%
% Open the generated test report.
open("myTestReport.html")