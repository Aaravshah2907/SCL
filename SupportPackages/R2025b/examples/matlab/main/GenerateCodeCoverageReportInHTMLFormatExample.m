%% Generate Code Coverage Report in HTML Format
% Run a suite of tests and generate a code coverage report for source code
% in a namespace.

% Copyright 2021 The MathWorks, Inc.

%%
% In a namespace named |sourceNamespace| in your current folder, create the 
% |quadraticSolver| function. The function takes as inputs the
% coefficients of a quadratic polynomial and returns the roots of that
% polynomial. If the coefficients are specified as nonnumeric values, the
% function throws an error.
% 
% <include>quadraticSolver.m</include>
%
%%
% To test the |quadraticSolver| function, create the |SolverTest| class in
% a namespace named |testsNamespace| in your current folder. Define
% three |Test| methods that test the function against real solutions,
% imaginary solutions, and nonnumeric inputs.
% 
% <include>SolverTest.m</include>
%
%%
% Create a test suite from |testsNamespace|.
suite = testsuite("testsNamespace");
%%
% Create a test runner and customize it using a plugin that generates an
% HTML code coverage report for the code in |sourceNamespace|. Instruct the
% plugin to write its output to a folder named |coverageReport| in your
% current folder.
import matlab.unittest.plugins.CodeCoveragePlugin
import matlab.unittest.plugins.codecoverage.CoverageReport
runner = testrunner("textoutput");
reportFormat = CoverageReport("coverageReport");
p = CodeCoveragePlugin.forNamespace("sourceNamespace", ...
    "Producing",reportFormat);
runner.addPlugin(p)
%%
% Run the tests. In this example, all the tests pass and the source code
% receives full coverage. The plugin generates an HTML code coverage report
% in the specified folder |coverageReport|, created in your current folder. 
% By default, the main file of the report is |index.html|.
results = runner.run(suite);
%%
% Open the main file of the report.
open(fullfile("coverageReport","index.html"))