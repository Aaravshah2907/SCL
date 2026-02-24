%% Pass Extra Parameters to ODE Function
% |ode113| only works with functions that use two input arguments, |t| and
% |y|. However, you can pass in extra parameters by defining them outside
% the function and passing them in when you specify the function handle.
%
% Solve the ODE
%
% $$y'' = \frac{A}{B} t y.$$
%
% Rewriting the equation as a first-order system yields
%
% $$\begin{array}{cl} y'_1 &= y_2\\ y'_2 &= \frac{A}{B} t y_1.
% \end{array}$$
%
% |odefcn.m| represents this system of equations as a function that accepts
% four input arguments: |t|, |y|, |A|, and |B|.
%
% <include>odefcn.m</include>
%

%%
% Solve the ODE using |ode113|. Specify the function handle such that it
% passes in the predefined values for |A| and |B| to |odefcn|.
A = 1;
B = 2;
tspan = [0 5];
y0 = [0 0.01];
[t,y] = ode113(@(t,y) odefcn(t,y,A,B), tspan, y0);

%%
% Plot the results.
plot(t,y(:,1),'-o',t,y(:,2),'-.')

%% 
% Copyright 2012 The MathWorks, Inc.