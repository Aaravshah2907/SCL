function plan = buildfile
import matlab.buildtool.tasks.CodeIssuesTask
import matlab.buildtool.tasks.TestTask

% Create a plan with no tasks
plan = buildplan;

% Add the "check" task to identify code issues
plan("check") = CodeIssuesTask;

% Add the "test" task to run tests
plan("test") = TestTask;

% Make the "test" task the default task in the plan
plan.DefaultTasks = "test";
end