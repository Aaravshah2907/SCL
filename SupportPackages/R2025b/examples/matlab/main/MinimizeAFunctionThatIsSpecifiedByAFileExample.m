%% Minimize a Function Specified by a File
% Minimize an objective function whose values are given by executing a
% file. A function file must accept a real vector |x| and return a real
% scalar that is the value of the objective function.
%
% Copy the following code and include it as a file named |objectivefcn1.m|
% on your MATLAB(R) path.
%
% <include>objectivefcn1.m</include>
%
% Start at |x0 = [0.25,-0.25]| and search for a minimum of |objectivefcn|.
x0 = [0.25,-0.25];
x = fminsearch(@objectivefcn1,x0)

%% 
% Copyright 2012 The MathWorks, Inc.