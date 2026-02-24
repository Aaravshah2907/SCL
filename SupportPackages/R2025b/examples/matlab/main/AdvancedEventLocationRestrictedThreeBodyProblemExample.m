%% Advanced Event Location: Restricted Three Body Problem
% This example shows how to use the directional components of an event
% function. The example file |orbitode| simulates a restricted three body
% problem where one body is orbiting two much larger bodies. The events
% function determines the points in the orbit where the orbiting body is
% closest and farthest away. Since the value of the events function is the
% same at the closest and farthest points of the orbit, the direction of
% zero crossing is what distinguishes them.

%%
% The equations for the restricted three body problem are
%
% $$\begin{array}{cl} y'_1 &= y_3\\ y'_2 &= y_4 \\ y'_3 &= 2y_4 + y_1 -
% \frac{\mu^* (y_1 + \mu)}{r_1^3} - \frac{\mu(y_1 - \mu^*}{r_2^3}\\ y'_4 &=
% -2y_3 + y_2 - \frac{\mu^* y_2}{r_1^3} - \frac{\mu y_2}{r_2^3},
% \end{array}$$
%
% where
%
% $$\begin{array}{cl} \mu &= 1/82.45\\ \mu^* &= 1-\mu\\ r_1 &=
% \sqrt{(y_1+\mu)^2+y_2^2}\\ r_2 &= \sqrt{(y_1-\mu^*)^2 +
% y_2^2}.\end{array}$$
%

%%
% The first two solution components are coordinates of the body of
% infinitesimal mass, so plotting one against the other gives the orbit of
% the body. 

%%
% The events function nested in |orbitode.m| searches for two events. One
% event locates the point of maximum distance from the starting point, and
% the other locates the point where the spaceship returns to the starting
% point. The events are located accurately, even though the step sizes used
% by the integrator are not determined by the locations of the events. In
% this example, the ability to specify the direction of the zero crossing
% is critical. Both the point of return to the starting point and the point
% of maximum distance from the starting point have the same event values,
% and the direction of the crossing is used to distinguish them. An events
% function that codes this behavior is
%
% <include>orbitEvents.m</include>
%

%%
% Type |orbitode| to run the example.
orbitode

%% 
% Copyright 2012 The MathWorks, Inc.