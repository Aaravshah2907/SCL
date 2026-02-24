%% Solve Stiff ODE
% An example of a stiff system of equations is the van der Pol equations in
% relaxation oscillation. The limit cycle has regions where the solution
% components change slowly and the problem is quite stiff, alternating with
% regions of very sharp change where it is not stiff.
%
% The system of equations is:
%
% $$\begin{array}{cl} y_1' &= y_2\\y_2' &= 1000(1-y_1^2)y_2-y_1\end{array}$$
%
% The initial conditions are $y_1(0)=2$ and $y_2(0)=0$. The function
% |vdp1000| ships with MATLAB(R) and encodes the equations.
%
% <include>vdp1000.m</include>
%
% Solving this system using |ode45| with the default relative and absolute
% error tolerances (|1e-3| and |1e-6|, respectively) is extremely slow,
% requiring several minutes to solve and plot the solution. |ode45|
% requires millions of time steps to complete the integration, due to
% the areas of stiffness where it struggles to meet the tolerances. 
%
% This is a plot of the solution obtained by |ode45|, which takes a long
% time to compute. Notice the enormous number of time steps required to
% pass through areas of stiffness.
%
% <<../ode45_plot.png>>
%

%%
% Solve the stiff system using the |ode15s| solver, and then plot the first
% column of the solution |y| against the time points |t|. The |ode15s|
% solver passes through stiff areas with far fewer steps than |ode45|.
[t,y] = ode15s(@vdp1000,[0 3000],[2 0]);
plot(t,y(:,1),'-o')

%% 
% Copyright 2012 The MathWorks, Inc.