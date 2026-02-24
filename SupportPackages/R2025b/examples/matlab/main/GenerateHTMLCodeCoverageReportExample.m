%% Generate Interactive Code Coverage Report
% Run a suite of tests and generate an interactive code coverage report
% in HTML format for your source code.

% Copyright 2021 The MathWorks, Inc.

%%
% In a folder named |sourceFolder| in your current folder, create the 
% |quadraticSolver| function. The function takes as inputs the
% coefficients of a quadratic polynomial and returns the roots of that
% polynomial. If the coefficients are specified as nonnumeric values, the
% function throws an error.
% 
% <include>sourceFolder/quadraticSolver.m</include>
%
%%
% To test the |quadraticSolver| function, create the |SolverTest| class in
% a folder named |testsFolder| in your current folder. Define
% three |Test| methods that test the function against real solutions,
% imaginary solutions, and nonnumeric inputs.
% 
% <include>testsFolder/SolverTest.m</include>
%
%%
% To run the tests and generate a code coverage report, first add 
% |sourceFolder| to the path.
addpath("sourceFolder")
%%
%%
% Create a test suite from |testsFolder|.
suite = testsuite("testsFolder");
%%
% Create a test runner and customize it using a plugin that generates an
% interactive code coverage report for the code in |sourceFolder|. Specify
% that the plugin writes its output to a folder named |coverageReport| in
% your current folder.
import matlab.unittest.plugins.CodeCoveragePlugin
import matlab.unittest.plugins.codecoverage.CoverageReport
runner = testrunner("textoutput");
reportFormat = CoverageReport("coverageReport");
p = CodeCoveragePlugin.forFolder("sourceFolder","Producing",reportFormat);
runner.addPlugin(p)
%%
% Run the tests. In this example, all the tests pass and the source code
% receives full coverage. The plugin generates an interactive code coverage
% report in the specified folder |coverageReport|, created in your current
% folder. By default, the main file of the report is |index.html|.
results = runner.run(suite);
%%
% Open the main file of the report.
open(fullfile("coverageReport","index.html"))