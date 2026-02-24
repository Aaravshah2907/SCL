%% Precompute Data, Then Create Animation
% Compute all the data before the animation loop. 

h = animatedline;
axis([0 4*pi -1 1])
drawnow % Complete initialization
x = linspace(0,4*pi,10000);
y = sin(x);

for k = 1:length(x)
    addpoints(h,x(k),y(k));
    drawnow limitrate  % Display changes
end
drawnow % Display final updates
%% 
% If you have long computations, precomputing the data can improve performance. 
% Precomputing minimizes the computation time by letting the computation run without 
% interruptions. Additionally, it helps ensure a smooth animation by focusing 
% on only graphics code in the animation loop.
% 
% Copyright 2015 The MathWorks, Inc.
