function plan = buildfile
import matlab.buildtool.tasks.TestTask

% Create a plan with no tasks
plan = buildplan;

% Add a task to run tests and generate test and coverage results
plan("test") = TestTask(SourceFiles="quadraticSolver.m", ...
    TestResults="test-results/results.xml", ...
    CodeCoverageResults="code-coverage/results.xml");
end