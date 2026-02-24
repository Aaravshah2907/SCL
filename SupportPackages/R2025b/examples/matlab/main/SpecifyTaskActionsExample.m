%% Specify Task Actions
% Specify the actions to perform when a task runs.

% Copyright 2022 The MathWorks, Inc.

%%
% In a file named |runMyTests.m| in your current folder, create a function
% that runs the tests in the current folder and its subfolders, generates
% an HTML test report from the test results, and asserts that the tests
% run without failure. 
%
% <include>runMyTests.m</include>
%
%%
% Import the |Task| class.
import matlab.buildtool.Task
%% 
% Create a plan with no tasks.
plan = buildplan;
%%
% Add a task to the plan that executes the |runMyTests| function.
plan("test") = Task(Actions=@runMyTests);
%%
% Add another action to the task to open the generated test report.
plan("test").Actions(end+1) = @(~)open(fullfile("artifacts","index.html"));
%%
% Display the names of the task actions. The build tool displays the string
% representation of the function handles.
disp({plan("test").Actions.Name}')
%%
% Now, run the task. The build runner performs the actions of the task in
% the order specified. In this example, all the tests pass and the report
% opens.
result = run(plan,"test");