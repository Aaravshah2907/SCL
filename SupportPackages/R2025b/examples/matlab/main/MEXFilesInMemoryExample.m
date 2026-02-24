%% MEX Files in Memory
% Call the MEX function |arrayProduct|, and then verify that the function
% is in memory. You must have a supported C compiler installed on your
% system to run this example.

% Copyright 2020 The MathWorks, Inc.

%% 
% Clear the memory. Then, copy the source code example from the |examples|
% folder.
%%
clear all
copyfile(fullfile(matlabroot,"extern","examples","mex","arrayProduct.c"),".","f")
%% 
% Build the MEX file and test it. The output displays information specific
% to your compiler.
%%
mex arrayProduct.c
s = 5; 
A = [1.5 2 9];
B = arrayProduct(s,A)
%% 
% Return the list of MEX files that are currently loaded. Verify that the
% list includes |arrayProduct|.
%%
[F1,M1] = inmem;
ismember("arrayProduct",M1)
%% 
% Now, return the full names of the MEX files, including the file path and
% extension. The output displays |arrayProduct| in your current folder.
%%
[F2,M2] = inmem("-completenames");
M2