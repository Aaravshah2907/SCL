%% Compare Function Handles
%% Compare Handles Constructed from Named Function
% MATLAB&reg; considers function handles that you construct from the same named
% function to be equal. The isequal function returns a value of |true| when
% comparing these types of handles.
fun1 = @sin;
fun2 = @sin;
isequal(fun1,fun2)
%%
% If you save these handles to a MAT-file, and then load them back into the
% workspace, they are still equal.
%% Compare Handles to Anonymous Functions
% Unlike handles to named functions, function handles that represent the
% same anonymous function are not equal. They are considered unequal
% because MATLAB cannot guarantee that the frozen values of nonargument
% variables are the same. For example, in this case, A is a nonargument
% variable.
A = 5;
h1 = @(x)A * x.^2;
h2 = @(x)A * x.^2;
isequal(h1,h2)
%%
% If you make a copy of an anonymous function handle, the copy and the
% original are equal.
h1 = @(x)A * x.^2;
h2 = h1;
isequal(h1,h2)
%% Compare Handles to Nested Functions
% MATLAB considers function handles to the same nested function to be equal
% only if your code constructs these handles on the same call to the
% function containing the nested function. This function constructs two
% handles to the same nested function.
% 
% <include>test_eq.m</include>
%
% Function handles constructed from the same nested function and on the
% same call to the parent function are considered equal.
[h1,h2] = test_eq(4,19,-7);
isequal(h1,h2)
%% 
% Function handles constructed from different calls are not considered equal.
[q1,q2] = test_eq(4,19,-7);
isequal(h1,q1)

%% 
% Copyright 2012 The MathWorks, Inc.