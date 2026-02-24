%% Solve Nonstiff ODEs
% This page contains two examples of solving nonstiff ordinary differential
% equations using |ode45|. MATLAB(R) has several solvers for nonstiff ODEs.
%
% * |ode45|
% * |ode23|
% * |ode78|
% * |ode89|
% * |ode113|
%
% For most nonstiff problems, |ode45| performs best. However, |ode23| is
% recommended for problems that permit a slightly cruder error tolerance or
% in the presence of moderate stiffness. Likewise, |ode113| can be more
% efficient than |ode45| for problems with more stringent error tolerances
% or when the ODE function is computationally expensive to evaluate.
% |ode78| and |ode89| are high-order solvers that excel with long
% integrations where accuracy is crucial for stability.
%
% If the nonstiff solvers take a long time to solve the problem or
% consistently fail the integration, then the problem might be _stiff_. See
% <docid:matlab_math.bu22m86 Solve Stiff ODEs> for more information.

%% Example: Nonstiff van der Pol Equation
% The van der Pol equation is a second order ODE
%
% $$y''_1 - \mu \left( 1 - y_1^2\right) y'_1+y_1=0,$$
%
% where $\mu > 0$ is a scalar parameter. Rewrite this equation as a system
% of first-order ODEs by making the substitution $y'_1 = y_2$. The
% resulting system of first-order ODEs is
%
% $$
% \begin{array}{cl}
% y'_1 &= y_2\\
% y'_2 &= \mu (1-y_1^2) y_2 - y_1.\end{array}
% $$
%

%% 
% The system of ODEs must be coded into a function file that the ODE solver
% can use. The general functional signature of an ODE function is
%
%    dydt = odefun(t,y)
%
% That is, the function must accept both |t| and |y| as inputs, even if it
% does not use |t| for any computations. 
%
% The function file |vdp1.m| codes the van der Pol equation using $\mu =
% 1$. The variables $y_1$ and $y_2$ are represented by |y(1)| and |y(2)|,
% and the two-element column vector |dydt| contains the expressions for
% $y'_1$ and $y'_2$.
%
% <include>vdp1.m</include>
%

%% 
% Solve the ODE using the |ode45| function on the time interval |[0 20]|
% with initial values |[2 0]|. The output is a column vector of time points
% |t| and a solution array |y|. Each row in |y| corresponds to a time
% returned in the corresponding row of |t|. The first column of |y|
% corresponds to $y_1$, and the second column to $y_2$.
[t,y] = ode45(@vdp1,[0 20],[2; 0]);

%%
% Plot the solutions for $y_1$ and $y_2$ against |t|.
plot(t,y(:,1),'-o',t,y(:,2),'-o')
title('Solution of van der Pol Equation (\mu = 1) using ODE45');
xlabel('Time t');
ylabel('Solution y');
legend('y_1','y_2')

%%
% The |vdpode| function solves the same problem, but it accepts a
% user-specified value for $\mu$. The van der Pol equations become stiff as
% $\mu$ increases. For example, with the value $\mu = 1000$ you need to use
% a stiff solver such as |ode15s| to solve the system.

%% Example: Nonstiff Euler Equations
% The Euler equations for a rigid body without external forces are a
% standard test problem for ODE solvers intended for nonstiff problems.
%
% The equations are
%
% $$ \begin{array}{cl} y'_1 &= y_2y_3 \\ y'_2 &= -y_1y_3 \\ y'_3 &=
% -0.51y_1y_2. \end{array}$$
%

%% 
% The function file |rigidode| defines and solves this first-order system
% of equations over the time interval |[0 12]|, using the vector of initial
% conditions |[0; 1; 1]| corresponding to the initial values of $y_1$,
% $y_2$, and $y_3$. The local function |f(t,y)| encodes the system of
% equations.
%
% |rigidode| calls |ode45| with no output arguments, so the solver uses the
% default output function |odeplot| to automatically plot the solution
% points after each step.
%
% <include>rigidode.m</include>
%

%% 
% Solve the nonstiff Euler equations by calling the |rigidode| function.
rigidode
title('Solution of Rigid Body w/o External Forces using ODE45')
legend('y_1','y_2','y_3','Location','Best')


%% 
% Copyright 2021 The MathWorks, Inc.