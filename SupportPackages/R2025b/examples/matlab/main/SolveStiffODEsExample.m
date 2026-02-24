%% Solve Stiff ODEs
% This page contains two examples of solving stiff ordinary differential
% equations using |ode15s|. MATLAB(R) has four solvers designed for stiff
% ODEs.
%
% * |ode15s|
% * |ode23s|
% * |ode23t|
% * |ode23tb|
%
% For most stiff problems, |ode15s| performs best. However, |ode23s|,
% |ode23t|, and |ode23tb| can be more efficient if the problem permits a
% crude error tolerance.

%% What is a Stiff ODE?
% For some ODE problems, the step size taken by the solver is forced down
% to an unreasonably small level in comparison to the interval of
% integration, even in a region where the solution curve is smooth. These
% step sizes can be so small that traversing a short time interval might
% require millions of evaluations. This can lead to the solver failing the
% integration, but even if it succeeds it will take a very long time to do
% so.
%
% Equations that cause this behavior in ODE solvers are said to be _stiff_.
% The problem that stiff ODEs pose is that explicit solvers (such as
% |ode45|) are untenably slow in achieving a solution. This is why |ode45|
% is classified as a _nonstiff solver_ along with |ode23|, |ode78|,
% |ode89|, and |ode113|.
%
% Solvers that are designed for stiff ODEs, known as _stiff solvers_,
% typically do more work per step. The pay-off is that they are able to
% take much larger steps, and have improved numerical stability compared to
% the nonstiff solvers.

%% Solver Options
% For stiff problems, specifying the Jacobian matrix using |odeset| is
% particularly important. Stiff solvers use the Jacobian matrix $\partial
% f_i / \partial y_j$ to estimate the local behavior of the ODE as the
% integration proceeds, so supplying the Jacobian matrix (or, for large
% sparse systems, its sparsity pattern) is critical for efficiency and
% reliability. Use the |Jacobian|, |JPattern|, or |Vectorized| options of
% |odeset| to specify information about the Jacobian. If you do not supply
% the Jacobian then the solver estimates it numerically using finite
% differences.
%
% See <docid:matlab_ref.bu2m9z6 odeset> for a complete listing of other solver
% options.

%% Example: Stiff van der Pol Equation
% The van der Pol equation is a second order ODE
%
% $$y''_1 - \mu \left( 1 - y_1^2\right) y'_1+y_1=0,$$
%
% where $\mu > 0$ is a scalar parameter. When $\mu = 1$, the resulting
% system of ODEs is nonstiff and easily solved using |ode45|. However, if
% you increase $\mu$ to 1000, then the solution changes dramatically and
% exhibits oscillation on a much longer time scale. Approximating the
% solution of the initial value problem becomes more difficult. Because
% this particular problem is stiff, a solver intended for nonstiff
% problems, such as |ode45|, is too inefficient to be practical. Use a
% stiff solver such as |ode15s| for this problem instead.

%% 
% Rewrite the van der Pol equation as a system of first-order ODEs by
% making the substitution $y'_1 = y_2$. The resulting system of first-order
% ODEs is
%
% $$
% \begin{array}{cl}
% y'_1 &= y_2\\
% y'_2 &= \mu (1-y_1^2) y_2 - y_1 .\end{array}
% $$
%

%% 
% The |vdp1000| function evaluates the van der Pol equation using $\mu =
% 1000$. 
%
% <include>vdp1000.m</include>
%

%% 
% Use the |ode15s| function to solve the problem with an initial conditions
% vector of |[2; 0]|, over a time interval of |[0 3000]|. For scaling
% reasons, plot only the first component of the solution.
[t,y] = ode15s(@vdp1000,[0 3000],[2; 0]);
plot(t,y(:,1),'-o');
title('Solution of van der Pol Equation, \mu = 1000');
xlabel('Time t');
ylabel('Solution y_1');

%%
% The |vdpode| function also solves the same problem, but it accepts a
% user-specified value for $\mu$. The equations become increasingly stiff
% as $\mu$ increases.

%% Example: Sparse Brusselator System
% The classic Brusselator system of equations is potentially large, stiff,
% and sparse. The Brusselator system models diffusion in a chemical
% reaction, and is represented by a system of equations involving $u$, $v$,
% $u'$, and $v'$.
%
% $$ \begin{array}{cl} u'_i &= 1+u_i^2v_i-4u_i+ \alpha \left( N + 1 \right)
% ^2 \left( u_{i-1}-2_i+u_{i+1} \right)\\ v'_i &= 3u_i-u_i^2v_i + \alpha
% \left( N+1 \right) ^2 \left( v_{i-1} - 2v_i+v_{i+1} \right) \end{array}$$
%
% The function file |brussode| solves this set of equations on the time
% interval |[0,10]| with $\alpha = 1/50$. The initial conditions are
%
% $$\begin{array}{cl} u_j(0) &= 1+\sin(2 \pi x_j)\\ v_j(0) &=
% 3,\end{array}$$
%
% where $x_j = i/N+1$ for $i=1,...,N$. Therefore, there are $2N$ equations
% in the system, but the Jacobian $\partial f / \partial y$ is a banded
% matrix with a constant width of 5 if the equations are ordered as
% $u_1,v_1,u_2,v_2,...$. As $N$ increases, the problem becomes increasingly
% stiff, and the Jacobian becomes increasingly sparse.

%% 
% The function call |brussode(N)|, for $N \ge 2$, specifies a value for |N|
% in the system of equations, corresponding to the number of grid points.
% By default, |brussode| uses $N = 20$.
%
% |brussode| contains a few subfunctions:
%
% * The nested function |f(t,y)| encodes the system of equations for the
% Brusselator problem, returning a vector.
% * The local function |jpattern(N)| returns a sparse matrix of 1s and 0s
% showing the locations of nonzeros in the Jacobian. This matrix is
% assigned to the |JPattern| field of the options structure. The ODE solver
% uses this sparsity pattern to generate the Jacobian numerically as a
% sparse matrix. Supplying this sparsity pattern in the problem
% significantly reduces the number of function evaluations required to
% generate the 2N-by-2N Jacobian, from 2N evaluations to just 4.
%
% <include>brussode.m</include>
%

%% 
% Solve the Brusselator system for $N=20$ by running the function
% |brussode|.
brussode

%%
% Solve the system for $N=50$ by specifying an input to |brussode|.
brussode(50)

%% 
% Copyright 2021 The MathWorks, Inc.