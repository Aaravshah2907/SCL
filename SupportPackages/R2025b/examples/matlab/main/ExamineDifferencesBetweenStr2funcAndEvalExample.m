%% Examine Differences Between |str2func| and |eval|
% Create a function that returns two function handles used to simulate the
% roll of dice. The first die (|d1|) returns a number from 1 through 6, but
% the second die (|d2|) always returns the number 1.
%
% Create the following function in a folder on your MATLAB path. When
% |str2func| is used with a character vector representing an anonymous 
% function, it does not have access to the local function. Therefore, MATLAB
% calls the built-in |randi| function, and returns a number from 1 through
% 6. The |eval| function does have access to the local function, so |d2| uses the
% overloaded |randi| and always returns 1.
% 
% <include>diceRoll.m</include>
%%
% At the command prompt, call the |diceRoll| function.
[p1,p2] = diceRoll
%%
% Both |p1| and |p2| appear to be associated with the same anonymous
% function.
%
% Invoke the function handles. The result from |p1| varies from 1 through
% 6. The result from |p2| is always 1.
p1()
p2()

%% 
% Copyright 2012 The MathWorks, Inc.