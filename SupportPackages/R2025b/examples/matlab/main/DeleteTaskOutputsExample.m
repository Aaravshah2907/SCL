%% Delete Task Outputs
% Delete the outputs and traces of tasks that support incremental builds by
% using the |CleanTask| class.

% Copyright 2023 The MathWorks, Inc.
%% 
% Open the example and then navigate to the |clean_task_example| folder,
% which contains a build file as well as a C source file named |explore.c|.
cd clean_task_example
%%
% This code shows the contents of the build file. The build file contains
% two built-in tasks and one task created with a local task function:
% 
% * The |"clean"| task deletes outputs and traces of the other
% tasks in the build file.
% * The |"mex"| task compiles |explore.c| into a MEX file and saves the
% result to a folder named |output| in your current folder.
% You must have a supported C compiler installed on your system to run this
% task.
% * The |"archive"| task creates an archive of its inputs.
%
% <include>clean_task_example\buildfile.m</include>
%
%%
% Run the |"archive"| task. Because the input of the |"archive"|
% task is the output of the |"mex"| task, the build tool runs the |"mex"|
% task before running the |"archive"| task.
buildtool archive
%%
% Run the |"archive"| task again. The build tool skips both of the tasks
% because none of the inputs or outputs of the tasks have changed.
buildtool archive
%%
% Run the |"clean"| task to delete outputs and traces of the other
% tasks in the plan. When you delete the outputs or the trace of a task, 
% the build tool no longer considers the task as up to date.
buildtool clean
%%
% Rerun the |"archive"| task. The build tool also runs the |"mex"| task
% because it is no longer up to date.
buildtool archive
%%
% Now, delete only the output and trace of the |"archive"| task.
buildtool clean("archive")
%%
% Run the |"archive"| task again to produce a fresh archive. The build tool
% skips the |"mex"| task because it is up to date.
buildtool archive