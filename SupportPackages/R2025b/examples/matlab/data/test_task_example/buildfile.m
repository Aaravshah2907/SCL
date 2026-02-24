function plan = buildfile
import matlab.buildtool.tasks.TestTask

% Create a plan with no tasks
plan = buildplan;

% Add a task to run the tests in the project
plan("test") = TestTask;
end