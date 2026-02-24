%% ODE with Stringent Error Tolerances
% Compared to |ode45|, the |ode113|, |ode78|, and |ode89| solvers are
% better at solving problems with stringent error tolerances. A common
% situation where |ode113| excels is in orbital dynamics problems, where
% the solution curve is smooth and requires high accuracy.

%%
% The two-body problem considers two interacting masses |m1| and |m2|
% orbiting in a common plane. In this example, one of the masses is
% significantly larger than the other. With the heavy body at the origin,
% the equations of motion are
%
% $$\begin{array}{cl} x'' &= -x/r^3\\ y'' &= -y/r^3,\end{array}$$
%
% where 
%
% $$r = \sqrt{x^2+y^2}.$$
%
% To solve the problem, first convert to a system of four first-order ODEs
% using the substitutions
%
% $$\begin{array}{cl} y_1 &= x\\ y_2 &= x'\\ y_3 &= y\\ y_4 &=
% y'.\end{array}$$
%
% The substitutions produce the first-order system
%
% $$\begin{array}{cl} y'_1 &= y_2\\ y'_2 &= -y_1/r^3\\ y'_3 &= y_4 \\ y'_4
% &= -y_3/r^3.\end{array}$$
%

%%
% The function |twobodyode| codes the system of equations for the two-body
% problem.
%
% <include>twobodyode</include>
% 

%%
% Save |twobodyode.m| in your working directory, then solve the ODE using
% |ode113|. Specify stringent error tolerances of |1e-13| for |RelTol| and
% |1e-14| for |AbsTol|.
opts = odeset('Reltol',1e-13,'AbsTol',1e-14,'Stats','on');
tspan = [0 10*pi];
y0 = [2 0 0 0.5];

[t,y] = ode113(@twobodyode, tspan, y0, opts);
plot(t,y)
legend('x','x''','y','y''','Location','SouthEast')
title('Position and Velocity Components')

%%
figure
plot(y(:,1),y(:,3),'-o',0,0,'ro')
axis equal
title('Orbit of Smaller Mass')

%%
% Compared to |ode45|, the |ode113| solver is able to obtain the solution
% faster and with fewer function evaluations.


%% 
% Copyright 2021 The MathWorks, Inc.