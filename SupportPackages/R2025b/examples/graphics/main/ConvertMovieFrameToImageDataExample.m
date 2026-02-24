%% Convert Movie Frame to Image Data

% Copyright 2015 The MathWorks, Inc.

%%
% Create a surface plot. The data tip gives the x-, y- and z-coordinate of
% points along the surface.
surf(peaks)     
%% 
% Use |getframe| to capture the plot as a movie frame. The |'colormap'|
% field is empty, therefore the movie frame contains a truecolor (RGB)
% image.
F = getframe
%%
% Convert the captured movie frame to image data.
RGB = frame2im(F); 
%%
% Display the truecolor image. The data tip gives information about the
% column and row indices and RGB value of pixels.
figure
imshow(RGB)