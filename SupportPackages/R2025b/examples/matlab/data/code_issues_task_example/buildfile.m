function plan = buildfile
import matlab.buildtool.tasks.CodeIssuesTask

% Create a plan with no tasks
plan = buildplan;

% Add a task to identify the code issues
plan("check") = CodeIssuesTask;
end
