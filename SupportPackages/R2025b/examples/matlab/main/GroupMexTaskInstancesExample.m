%% Build MEX Files Using Task Group
% Build MEX files by using a group of |matlab.buildtool.tasks.MexTask|
% instances. You must have a supported C compiler installed on your system
% to run this example.

% Copyright 2024 The MathWorks, Inc.

%% 
% Open the example and then navigate to the |task_group_example| folder,
% which contains a build file as well as two C source files named
% |explore.c| and |yprime.c|.
cd task_group_example
%%
% This code shows the contents of the build file:
% 
% * The |"clean"| task deletes outputs and traces of the other
% tasks in the build file.
% * The |"mex"| task group contains two tasks named |"mex:explore"| and
% |"mex:yprime"|. Each of these tasks compiles a source file into a MEX
% file and saves the result to a folder named |output| in your current
% folder.
%
% <include>task_group_example\buildfile.m</include>
%
%%
% Run the |"mex"| task group. The |"mex:explore"| and |"mex:yprime"| tasks
% in the task group build binary MEX files and save them to the |output|
% folder. The build run progress includes information specific to your
% compiler.
buildtool mex
%%
% Run the |"mex:explore"| task in isolation. The build tool skips the
% task because neither its input nor output has changed.
buildtool mex:explore
%%
% Run the |"clean"| task to delete outputs and traces of the other
% tasks in the plan. When you delete the outputs or the trace of a task, 
% the build tool no longer considers the task as up to date.
buildtool clean
%%
% Rerun the |"mex:explore"| task to build a fresh MEX file.
buildtool mex:explore
%%
% Now, run the |"mex"| task group again. The build tool runs only the
% |"mex:yprime"| task in the task group. It skips the |"mex:explore"|
% task because the task is up to date.
buildtool mex