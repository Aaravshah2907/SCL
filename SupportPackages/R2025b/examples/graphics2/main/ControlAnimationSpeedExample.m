%% Time Screen Updates for Efficiency
% Run through several iterations of the animation loop before drawing the updates on the screen. 
% Use this technique when |drawnow| is too slow and |drawnow limitrate| is too fast. 
% 
% For example, update the screen every 1/30 seconds. Use the |tic| and |toc| 
% commands to keep track of how much time passes between screen updates. 

h = animatedline;
axis([0,4*pi,-1,1])
numpoints = 10000;
x = linspace(0,4*pi,numpoints);
y = sin(x);
a = tic; % start timer
for k = 1:numpoints
    addpoints(h,x(k),y(k))
    b = toc(a); % check timer
    if b > (1/30) 
        drawnow % update screen every 1/30 seconds
        a = tic; % reset timer after updating
    end
end
drawnow % draw final frame
%% 
% A smaller interval updates the screen more often and results in a slower 
% animation. For example, use |b > (1/1000)| to slow down the animation.
% 
% Copyright 2015 The MathWorks, Inc.
