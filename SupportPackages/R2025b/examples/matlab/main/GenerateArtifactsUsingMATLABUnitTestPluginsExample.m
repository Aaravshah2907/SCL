%% Generate Artifacts Using MATLAB Unit Test Plugins

% Copyright 2021 The MathWorks, Inc.

%%
% The MATLAB(R) unit testing framework enables you to customize your test
% runner using the plugin classes in the |matlab.unittest.plugins| namespace.
% You can use some of these plugin classes to generate test reports and
% artifacts compatible with continuous integration (CI) platforms:
% 
% * <docid:matlab_ref#bvcj_ru> creates a plugin that directs the test runner
% to produce a test result report. Using this plugin, you can produce
% readable and archivable test reports.
% * <docid:matlab_ref#bt8q3p3-1> creates a plugin that produces a Test
% Anything Protocol (TAP) stream.
% * <docid:matlab_ref#buw70x7> creates a plugin that produces JUnit-style
% XML output.
% * <docid:matlab_ref#bub472u> creates a plugin that produces a coverage
% report for MATLAB source code.
%
% You also can generate CI-compatible artifacts when you run Simulink(R)
% Test(TM) test cases. For more information, see 
% <docid:sltest_ug#mw_6a67d0df-1d2f-4214-b4f5-f8106b4f51d4>.
%%
%% Run Tests with Customized Test Runner
% This example shows how to create a test suite and customize the test
% runner to report on test run progress and produce CI-compatible
% artifacts.
%
% In a file in your current folder, create the function |quadraticSolver|,
% which returns the roots of quadratic polynomials.
%
% <include>quadraticSolver.m</include>
%
% To test |quadraticSolver|, create the test class |SolverTest| in your
% current folder.
%
% <include>SolverTest.m</include>
%
% At the command prompt, create a test suite from the |SolverTest| class.
%%
suite = testsuite("SolverTest");
%% 
% Create a |TestRunner| instance that produces output using the
% <docid:matlab_ref#ref_q23kel2vs20> method. This method enables you to set
% the maximum verbosity level for logged diagnostics and the display level
% for test event details. In this example, the test runner displays test
% run progress at the |matlab.automation.Verbosity.Detailed| level (level 3).
import matlab.unittest.TestRunner
runner = TestRunner.withTextOutput("OutputDetail",3);
%%
% Create a |TestReportPlugin| instance that sends output to the file 
% |testreport.pdf| and add the plugin to the test runner.
import matlab.unittest.plugins.TestReportPlugin
pdfFile = "testreport.pdf";
p1 = TestReportPlugin.producingPDF(pdfFile);
runner.addPlugin(p1)
%%
% Create an |XMLPlugin| instance that writes JUnit-style XML output to the
% file |junittestresults.xml|. Then, add the plugin to the test runner.
import matlab.unittest.plugins.XMLPlugin
xmlFile = "junittestresults.xml";
p2 = XMLPlugin.producingJUnitFormat(xmlFile);
runner.addPlugin(p2)
%%
% Create a plugin that outputs a Cobertura code coverage report for the
% source code in the file |quadraticSolver.m|. Instruct the plugin to
% write its output to the file |cobertura.xml| and add the plugin to the
% test runner.
import matlab.unittest.plugins.CodeCoveragePlugin
import matlab.unittest.plugins.codecoverage.CoberturaFormat
sourceCodeFile = "quadraticSolver.m";
reportFile = "cobertura.xml";
reportFormat = CoberturaFormat(reportFile);
p3 = CodeCoveragePlugin.forFile(sourceCodeFile,"Producing",reportFormat);
runner.addPlugin(p3)
%%
% Run the tests.
results = runner.run(suite)
%%
% List the files in your current folder. The three specified artifacts are
% stored in your current folder.
dir
%%
% You can process the generated artifacts on CI platforms. You also can
% view the contents of the generated artifacts. For example, open the PDF
% test report.
open("testreport.pdf")