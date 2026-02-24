function plan = buildfile
import matlab.buildtool.tasks.MexTask

% Create a plan with no tasks
plan = buildplan;

% Add a task group to build MEX files
plan("mex") = MexTask.forEachFile("scalar*.c","output", ...
    CommonSourceFiles="shared.c");
end