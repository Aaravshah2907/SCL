%% 4-D Interpolation  

% Copyright 2015-2023 The MathWorks, Inc.


%% 
% Define an anonymous function that represents $f =
% te^{-x^{2}-y^{2}-z^{2}}$.
%  
f = @(x,y,z,t) t.*exp(-x.^2 - y.^2 - z.^2);  

%% 
% Create a grid of points in $R^4$. Then, pass the points through the function
% to create the sample values, |V|. 
[x,y,z,t] = ndgrid(-1:0.2:1,-1:0.2:1,-1:0.2:1,0:2:10);
V = f(x,y,z,t);  

%% 
% Now, create the query grid. 
[xq,yq,zq,tq] = ...
ndgrid(-1:0.05:1,-1:0.08:1,-1:0.05:1,0:0.5:10);  

%% 
% Interpolate |V| at the query points. 
Vq = interpn(x,y,z,t,V,xq,yq,zq,tq);  

%% 
% Create a movie to show the results. 
figure;
nframes = size(tq, 4);
for j = 1:nframes
   slice(yq(:,:,:,j),xq(:,:,:,j),zq(:,:,:,j),...
         Vq(:,:,:,j),0,0,0);
   clim([0 10]);
   M(j) = getframe;
end
movie(M);      

