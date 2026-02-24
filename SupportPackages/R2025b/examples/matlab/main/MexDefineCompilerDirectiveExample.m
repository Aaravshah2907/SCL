%% Define Compiler Directive
% The |mxcreatecharmatrixfromstr.c| example uses a |#define| symbol 
% |SPACE_PADDING| to determine what character to use between character 
% vectors in a matrix. To set the value, build the MEX file with the |-D| option. 
%% 
% Copy the example to the current folder.
copyfile(fullfile(matlabroot,'extern','examples','mx','mxcreatecharmatrixfromstr.c'),'.','f')
%% 
% Set the |SPACE_PADDING| directive to add a space between values.
mex mxcreatecharmatrixfromstr.c -DSPACE_PADDING

%% 
% Copyright 2012 The MathWorks, Inc.