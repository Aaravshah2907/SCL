function plan = buildfile
import matlab.buildtool.tasks.CleanTask
import matlab.buildtool.tasks.MexTask

% Create a plan from task functions
plan = buildplan(localfunctions);

% Add a task to delete outputs and traces
plan("clean") = CleanTask;

% Add a task to build a MEX file
plan("mex") = MexTask("explore.c","output");

% Specify the input and output of the "archive" task
plan("archive").Inputs = plan("mex").MexFile;
plan("archive").Outputs = "mex.zip";
end

function archiveTask(context)
% Create ZIP file
task = context.Task;
zip(task.Outputs.paths,task.Inputs.paths)
end