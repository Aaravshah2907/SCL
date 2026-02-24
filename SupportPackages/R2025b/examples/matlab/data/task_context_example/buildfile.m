function plan = buildfile
% Create a plan from the task function
plan = buildplan(localfunctions);

% Specify the inputs and outputs of the "pcode" task
plan("pcode").Inputs = "source/**/*.m";
plan("pcode").Outputs = plan("pcode").Inputs.replace(".m",".p");
end

function pcodeTask(context)
% Create P-code files
filePaths = context.Task.Inputs.paths;
pcode(filePaths{:},"-inplace")
end