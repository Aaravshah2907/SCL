function plan = buildfile
import matlab.buildtool.TaskGroup
import matlab.buildtool.tasks.MexTask

% Create a plan with no tasks
plan = buildplan;

% Add a task group to build MEX files
plan("mex") = TaskGroup( ...
    [MexTask("explore.c","output") MexTask("yprime.c","output")], ...
    TaskNames=["explore" "yprime"], ...
    Description="Build MEX files");
end