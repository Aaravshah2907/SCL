function plan = buildfile
% Create a plan from task functions
plan = buildplan(localfunctions);
end

function testTask(context,tests,options)
% Run unit tests

arguments
    context
    tests string = context.Plan.RootFolder
    options.OutputDetail (1,1) string = "terse"
end

results = runtests(tests, ...
    IncludeSubfolders=true, ...
    OutputDetail=options.OutputDetail);
assertSuccess(results);
end