function plan = buildfile
import matlab.buildtool.tasks.CleanTask
import matlab.buildtool.tasks.MexTask

% Create a plan with no tasks
plan = buildplan;

% Add a task to delete outputs and traces
plan("clean") = CleanTask;

% Add a task group to build MEX files
plan("mex:explore") = MexTask("explore.c","output");
plan("mex:yprime") = MexTask("yprime.c","output");

plan("mex").Description = "Build MEX files";
end