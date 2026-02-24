function plan = buildfile
plan = buildplan(localfunctions);

% Specify the program files to analyze and whether to include indirect dependencies
plan("dependencies").Inputs.FilesToAnalyze = files(plan,"source/**/*.m");
plan("dependencies").Inputs.IncludeIndirectDependencies = false;

% Specify where to write the lists of required files and products
plan("dependencies").Outputs.FileList = files(plan,"fileList.txt");
plan("dependencies").Outputs.ProductList = files(plan,"productList.txt");
end

function dependenciesTask(context)
% Determine required files and products
files = context.Task.Inputs.FilesToAnalyze.paths;

if context.Task.Inputs.IncludeIndirectDependencies
    [fList,pList] = matlab.codetools.requiredFilesAndProducts(files);
else
    [fList,pList] = matlab.codetools.requiredFilesAndProducts(files,"toponly");
end

writelines(fList,context.Task.Outputs.FileList.paths)
writelines({pList.Name},context.Task.Outputs.ProductList.paths)
end

