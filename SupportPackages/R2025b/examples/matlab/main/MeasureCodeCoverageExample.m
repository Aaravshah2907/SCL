%% Retrieve Code Coverage Information
% Run your tests and collect code coverage results by using the
% |runtests| function.

% Copyright 2021 The MathWorks, Inc.

%%
% In a file named |quadraticSolver.m| in your current folder, create the
% |quadraticSolver| function. The function takes as inputs the
% coefficients of a quadratic polynomial and returns the roots of that
% polynomial. If the coefficients are specified as nonnumeric values,
% the function throws an error.
% 
% <include>quadraticSolver.m</include>
%
%%
% To test the |quadraticSolver| function, create the |SolverTest| class
% in a file named |SolverTest.m| in your current folder. Define three
% |Test| methods that test the function against real solutions, imaginary
% solutions, and nonnumeric inputs.
% 
% <include>SolverTest.m</include>
%
%%
% Run the tests in the |SolverTest| class and also perform a code coverage
% analysis by specifying the |ReportCoverageFor| name-value argument. To
% programmatically access the coverage results in addition to generating a
% code coverage report, invoke the |runtests| function with two output
% arguments. After the tests run, the first output contains the test 
% results and the second output contains the coverage results.
[testResults,coverageResults] = runtests("SolverTest", ...
    "ReportCoverageFor","quadraticSolver.m")