%% Add Points in Sets for Fast Animation
% Use a loop to add 100,000 points to an animated line. Since the number of 
% points is large, adding one point to the line each time through the loop might 
% be slow. Instead, add 100 points to the line each time through the loop for 
% a faster animation.

h = animatedline;
axis([0,4*pi,-1,1])

numpoints = 100000;
x = linspace(0,4*pi,numpoints);
y = sin(x);
for k = 1:100:numpoints-99
    xvec = x(k:k+99);
    yvec = y(k:k+99);
    addpoints(h,xvec,yvec)
    drawnow    
end
%% 
% Another technique for creating faster animations is to use |drawnow limitrate| 
% instead of |drawnow|.

%% 
% Copyright 2012 The MathWorks, Inc.