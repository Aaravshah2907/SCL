%% Compare Time to Execute Custom Preallocation to Calling |zeros|
% Create a short function to allocate a matrix using nested loops.
% Preallocating an array using a nested loop is inefficient, but is shown
% here for illustrative purposes.
% 
% <include>preAllocFcn.m</include>
%
% Compare the time to allocate zeros to a matrix using nested loops and
% using the |zeros| function.
x = 1000;
y = 500;
g = @() preAllocFcn(x,y); 
h = @() zeros(x,y);
diffRunTime = timeit(g)-timeit(h)  

%% 
% Copyright 2012 The MathWorks, Inc.