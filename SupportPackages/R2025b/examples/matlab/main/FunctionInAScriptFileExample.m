%% Function in a Script File
% Define a script in a file named |integrationScript.m| that computes the value
% of the integrand at $2\pi/3$ and computes the area under the curve from 0
% to $\pi$. Include a local function that defines the integrand, $y =
% \sin(x)^3$.

% Compute the value of the integrand at 2*pi/3. 
x = 2*pi/3;
y = myIntegrand(x)

% Compute the area under the curve from 0 to pi. 
xmin = 0;
xmax = pi;
f = @myIntegrand;
a = integral(f,xmin,xmax)

function y = myIntegrand(x)
    y = sin(x).^3;
end

%% 
% Copyright 2012 The MathWorks, Inc.