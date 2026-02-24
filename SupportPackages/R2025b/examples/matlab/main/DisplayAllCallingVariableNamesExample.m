%% Display All Calling Variable Names
% Create the following function in a file, |getname2.m|, in your current
% working folder.
%
% <include>getname2.m</include>
%
% Call the function at the command prompt.
x = {'hello','goodbye'};
y = struct('a',42,'b',78);
z = rand(4);

getname2(x,y,z)
%%
% Call the function using a field of |y|. Because the input argument
% contains dot indexing, the |inputname| function returns an empty |char|
% array for the second variable name and all subsequent variable names.
getname2(x,y.a,z)
%%
% Call the function using the second cell of |x|. Because the input
% argument contains cell indexing, the |inputname| function returns an
% empty |char| array for the first variable name and all subsequent
% variable names.
getname2(x{2},y,z)

%% 
% Copyright 2012 The MathWorks, Inc.