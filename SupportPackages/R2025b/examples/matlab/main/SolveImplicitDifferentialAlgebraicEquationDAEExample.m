%% Solve Robertson Problem as Implicit Differential Algebraic Equations (DAEs)
% This example reformulates a system of ODEs as a fully implicit system of
% differential algebraic equations (DAEs). The Robertson problem coded by
% <matlab:edit('hb1ode') hb1ode.m> is a classic test problem for programs
% that solve stiff ODEs. The system of equations is
%
% $$\begin{array}{cl} y'_1 &= -0.04y_1 + 10^4 y_2y_3\\ y'_2 &= 0.04y_1 -
% 10^4 4y_2y_3-(3 \times 10^7)y_2^2\\ y'_3 &= (3 \times
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
% The problem can be rewritten as a system of DAEs by using the
% conservation law to determine the state of $y_3$. This reformulates the
% problem as the implicit DAE system
%
% $$\begin{array}{cl} 0 &= y'_1 +0.04y_1 - 10^4 y_2y_3\\ 0 &= y'_2 -0.04y_1
% + 10^4 y_2y_3+(3 \times 10^7)y_2^2\\ 0 &= y_1 + y_2 + y_3 -
% 1.\end{array}$$
%
% The function |robertsidae| encodes this DAE system. 
%
% <include>robertsidae.m</include>
%
% The full example code for this formulation of the Robertson problem is
% available in <matlab:edit('ihb1dae.m') ihb1dae.m>.

%%
% Set the error tolerances and the value of $\partial f / \partial y'$.
options = odeset('RelTol',1e-4,'AbsTol',[1e-6 1e-10 1e-6], ...
   'Jacobian',{[],[1 0 0; 0 1 0; 0 0 0]});

%%
% Use |decic| to compute consistent initial conditions from guesses. Fix
% the first two components of |y0| to get the same consistent initial
% conditions as found by |ode15s| in <matlab:edit('hb1dae.m') hb1dae.m>,
% which formulates this problem as a semi-explicit DAE system.
y0 = [1; 0; 1e-3];
yp0 = [0; 0; 0];
[y0,yp0] = decic(@robertsidae,0,y0,[1 1 0],yp0,[],options);

%%
% Solve the system of DAEs using |ode15i|. 
tspan = [0 4*logspace(-6,6)];
[t,y] = ode15i(@robertsidae,tspan,y0,yp0,options);

%%
% Plot the solution components. Since the second solution component is
% small relative to the others, multiply it by |1e4| before plotting.
y(:,2) = 1e4*y(:,2);
semilogx(t,y)
ylabel('1e4 * y(:,2)')
title('Robertson DAE problem with a Conservation Law, solved by ODE15I')

%% 
% Copyright 2012 The MathWorks, Inc.