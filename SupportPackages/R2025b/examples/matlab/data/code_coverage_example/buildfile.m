function plan = buildfile
import matlab.buildtool.tasks.TestTask

% Create a plan with no tasks
plan = buildplan;

% Add a task to run tests and produce coverage results
plan("test") = TestTask(SourceFiles="quadraticSolver.m").addCodeCoverage( ...
    "code-coverage/results.xml");
end