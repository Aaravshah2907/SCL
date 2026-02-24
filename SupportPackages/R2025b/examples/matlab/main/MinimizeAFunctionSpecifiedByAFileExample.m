%% Minimize a Function Specified by a File
% Minimize a function that is specified by a separate function file. A
% function accepts a point |x| and returns a real scalar representing the
% value of the objective function at |x|.
%
% Write the following function as a file, and save the file as
% |scalarobjective.m| on your MATLAB(R) path.
%
% <include>scalarobjective.m</include>
%
% Find the |x| that minimizes |scalarobjective| on the interval 1 <= |x| <= 3.
x = fminbnd(@scalarobjective,1,3)


%% 
% Copyright 2012 The MathWorks, Inc.