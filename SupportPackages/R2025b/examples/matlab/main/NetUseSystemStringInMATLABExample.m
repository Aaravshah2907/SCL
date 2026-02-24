%% Use System.String in MATLAB
% This example shows how to use a System.String object in a MATLAB(R) function.
%% 
% Create an object representing the current time. The current time |thisTime| is a |System.String| object.
netDate = System.DateTime.Now;
thisTime = ToShortTimeString(netDate);
class(thisTime)
%% 
% To display |thisTime| in MATLAB, use the
% |string| function to convert the
% |System.String| object to a MATLAB string.
join(["The time is", string(thisTime)])

%% 
% Copyright 2012 The MathWorks, Inc.