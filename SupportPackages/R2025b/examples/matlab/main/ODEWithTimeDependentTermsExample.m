%% ODE with Time-Dependent Terms
% Consider the following ODE with time-dependent parameters
%
% $$y'(t) + f(t)y(t) = g(t).$$
%
% The initial condition is $y_0 = 1$. The function |f(t)| is defined by the
% n-by-1 vector |f| evaluated at times |ft|. The function |g(t)| is defined
% by the m-by-1 vector |g| evaluated at times |gt|.
%
% Create the vectors |f| and |g|.
ft = linspace(0,5,25);
f = ft.^2 - ft - 3;

gt = linspace(1,6,25);
g = 3*sin(gt-0.25);

%%
% Write a function named |myode| that interpolates |f| and |g| to obtain
% the value of the time-dependent terms at the specified time. Save the
% function in your current folder to run the rest of the example. 
%
% The |myode| function accepts extra input arguments to evaluate the ODE at
% each time step, but |ode45| only uses the first two input arguments |t|
% and |y|.
%
% <include>myode.m</include>
%

%%
% Solve the equation over the time interval |[1 5]| using |ode45|. Specify
% the function using a function handle so that |ode45| uses only the first
% two input arguments of |myode|. Also, loosen the error thresholds using
% |odeset|.
tspan = [1 5];
ic = 1;
opts = odeset('RelTol',1e-2,'AbsTol',1e-4);
[t,y] = ode45(@(t,y) myode(t,y,ft,f,gt,g), tspan, ic, opts);

%%
% Plot the solution, |y|, as a function of the time points, |t|.
plot(t,y)

%% 
% Copyright 2012 The MathWorks, Inc.