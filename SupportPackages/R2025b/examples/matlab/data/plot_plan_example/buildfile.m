function plan = buildfile
import matlab.buildtool.tasks.CleanTask
import matlab.buildtool.tasks.MexTask

% Create a plan from task functions
plan = buildplan(localfunctions);

% Add a task to delete outputs and traces
plan("clean") = CleanTask;

% Add a task group to build MEX files
plan("mex:explore") = MexTask("explore.c","output");
plan("mex:yprime") = MexTask("yprime.c","output");

plan("mex").Description = "Build MEX files";

% Specify the inputs and outputs of the "archive" task
plan("archive").Inputs = [plan("mex").Tasks.MexFile];
plan("archive").Outputs = "mex.zip";
end

function archiveTask(context)
% Create ZIP file
task = context.Task;
zip(task.Outputs.paths,task.Inputs.paths)
end