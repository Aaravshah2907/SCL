%% Create New Files
% Create two new files in a new folder.

%%
% Create a file in a new directory using a character vector. A dialog box appears, asking if 
% you want to create |new_script.m|. Click *Yes* to create and open 
% |tests/new_script.m|.
mkdir tests
edit tests/new_script.m

%%
% Create a second file using a string. Click *Yes* to create and open 
% |tests/new_script2.m|.
S = "tests/new_script2.m";
edit(S)

%% 
% Copyright 2012 The MathWorks, Inc.