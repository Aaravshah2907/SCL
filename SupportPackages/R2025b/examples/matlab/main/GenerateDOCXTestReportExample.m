%% Generate DOCX Report After Running Tests
% Run a suite of tests and then generate a DOCX test report from the test
% results.

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
%%
results = runtests("sampleTest");
%%
% Generate a DOCX test report from the test results in a temporary folder.
% By default, the report has portrait orientation.
%%
generateDOCXReport(results)
%%
% Generate another report in landscape orientation, and save it as 
% |myTestReport.docx| in your current folder.
%%
generateDOCXReport(results,"myTestReport.docx",PageOrientation="landscape")
%%
% Open the test report in your current folder.
%% 
open("myTestReport.docx")
