%% Programmatically Display Function Handle Name as Character Vector 
% Create a function that evaluates a function handle for a single input.
%
% Create the following function in a file, |evaluateHandle.m|, in your working folder.
%
% <include>evaluateHandle.m</include>
%%
% Use a function handle to evaluate the |sin| function at |pi/2|.
fh = @sin;
x = pi/2;
evaluateHandle(fh,x)
%%
% Use a function handle to evaluate $x^2 + 7$ for the specified matrix, |A|.
fh = @(x) x.^2+7;
A = [1 2;0 1];
evaluateHandle(fh,A)

%% 
% Copyright 2012 The MathWorks, Inc.