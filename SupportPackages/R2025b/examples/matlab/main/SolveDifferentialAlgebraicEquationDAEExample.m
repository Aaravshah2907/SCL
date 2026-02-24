%% Solve Robertson Problem as Semi-Explicit Differential Algebraic Equations (DAEs)
% This example reformulates a system of ODEs as a system of differential
% algebraic equations (DAEs). The Robertson problem found in
% <matlab:edit('hb1ode') hb1ode.m> is a classic test problem for programs
% that solve stiff ODEs. The system of equations is
%
% $$\begin{array}{cl} y'_1 &= -0.04y_1 + 10^4 y_2y_3\\ y'_2 &= 0.04y_1 -
% 10^4 y_2y_3- (3 \times 10^7)y_2^2\\ y'_3 &= (3 \times
% 10^7)y_2^2.\end{array}$$
% 
% |hb1ode| solves this system of ODEs to steady state with the initial
% conditions $y_1 = 1$, $y_2 = 0$, and $y_3 = 0$. But the equations also
% satisfy a linear conservation law,
%
% $$y'_1 + y'_2 + y'_3 = 0.$$
%
% In terms of the solution and initial conditions, the conservation law is
%
% $$y_1 + y_2 + y_3 = 1.$$
%
% The system of equations can be rewritten as a system of DAEs by using the
% conservation law to determine the state of $y_3$. This reformulates the
% problem as the DAE system
%
% $$\begin{array}{cl} y'_1 &= -0.04y_1 + 10^4 y_2y_3\\ y'_2 &= 0.04y_1 -
% 10^4 y_2y_3-(3 \times 10^7)y_2^2\\ 0 &= y_1 + y_2 + y_3 - 1.\end{array}$$
%
% The differential index of this system is 1, since only a single
% derivative of $y_3$ is required to make this a system of ODEs. Therefore,
% no further transformations are required before solving the system. 
%
% The function |robertsdae| encodes this DAE system. Save |robertsdae.m| in
% your current folder to run the example. 
%
% <include>robertsdae.m</include>
%
% The full example code for this formulation of the Robertson problem is
% available in <matlab:edit('hb1dae.m') hb1dae.m>.

%%
% Solve the DAE system using |ode15s|. Consistent initial conditions for
% |y0| are obvious based on the conservation law. Use |odeset| to set the
% options:
%
% * Use a constant mass matrix to represent the left hand side of the
% system of equations.
%
% $$\left( \begin{array}{c} y'_1\\ y'_2\\ 0 \end{array} \right) = M y'
% \rightarrow M = \left( \begin{array}{ccc} 1 & 0 & 0\\ 0 & 1 & 0\\ 0 & 0 &
% 0 \end{array} \right)$$
%
% * Set the relative error tolerance to |1e-4|.
% * Use an absolute tolerance of |1e-10| for the second solution component,
% since the scale varies dramatically from the other components.
% * Leave the |'MassSingular'| option at its default value |'maybe'| to
% test the automatic detection of a DAE.
%
y0 = [1; 0; 0];
tspan = [0 4*logspace(-6,6)];
M = [1 0 0; 0 1 0; 0 0 0];
options = odeset('Mass',M,'RelTol',1e-4,'AbsTol',[1e-6 1e-10 1e-6]);
[t,y] = ode15s(@robertsdae,tspan,y0,options);

%%
% Plot the solution.
y(:,2) = 1e4*y(:,2);
semilogx(t,y);
ylabel('1e4 * y(:,2)');
title('Robertson DAE problem with a Conservation Law, solved by ODE15S');


%% 
% Copyright 2012 The MathWorks, Inc.