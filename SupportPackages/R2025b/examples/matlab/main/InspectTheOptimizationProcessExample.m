%% Inspect Optimization Process
% Inspect the results of an optimization, both while it is running and
% after it finishes.
%%
% Set options to provide iterative display, which gives information on the
% optimization as the solver runs. Also, set a plot function to show the
% objective function value as the solver runs.
options = optimset('Display','iter','PlotFcns',@optimplotfval);
%%
% Set an objective function and start point.
%
% <include>objectivefcn1.m</include>
%
% Include the code for |objectivefcn1| as a file on your MATLAB(R) path.
x0 = [0.25,-0.25];
fun = @objectivefcn1;
%%
% Obtain all solver outputs. Use these outputs to inspect the results after
% the solver finishes.
[x,fval,exitflag,output] = fminsearch(fun,x0,options)
%%
% The value of |exitflag| is |1|, meaning |fminsearch| likely converged to
% a local minimum.
%
% The |output| structure shows the number of iterations. The iterative
% display and the plot show this information as well. The |output|
% structure also shows the number of function evaluations, which the
% iterative display shows, but the chosen plot function does not.


%% 
% Copyright 2012 The MathWorks, Inc.