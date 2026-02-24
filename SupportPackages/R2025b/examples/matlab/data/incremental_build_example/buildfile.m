function plan = buildfile
% Create a plan from the task functions
plan = buildplan(localfunctions);

% Specify the inputs and outputs of the "pcode" task
plan("pcode").Inputs = "source/**/*.m";
plan("pcode").Outputs = plan("pcode").Inputs.replace(".m",".p");

% Specify the inputs and outputs of the "archive" task
plan("archive").Inputs = plan("pcode").Outputs;
plan("archive").Outputs = "source.zip";
end

function pcodeTask(context)
% Create P-code files
filePaths = context.Task.Inputs.paths;
pcode(filePaths{:},"-inplace")
end

function archiveTask(context)
% Create ZIP file
task = context.Task;
zip(task.Outputs.paths,task.Inputs.paths)
end