%% Track a Green Ball Using Web Camera on Beaglebone Black Board
%
% This example shows you how to use MATLAB(R) to process images captured from
% a web camera on BeagleBone(R) Black board to track a green ball.
 
% Copyright 2015 The MathWorks, Inc.
 

%% Introduction
%
% The MATLAB Support Package for BeagleBone Black Hardware allows you to
% capture images from the web camera and bring those right into MATLAB for
% processing. Using this capability we will develop an ball tracking
% algorithm.

%% Prerequisites
%
% * We recommend completing
% <docid:mlsupportpkg#example-beagleboneio_gettingstarted Getting Started with MATLAB Support Package for BeagleBone Black Hardware> example. 


%% Required Hardware
% 
% To run this example you will need the following hardware:
% 
% * BeagleBone Black hardware
% * A 5V power supply
% * A web camera, e.g. Logitech Webcam C600

%% Create a Web Camera object
% Connect a compatible USB camera to the USB host port of your BeagleBone
% Black hardware. Note that some USB cameras draw too much current from the
% USB port of BeagleBone Black hardware and may not work properly. Use a
% powered USB hub in such cases. Make sure that the AvailableWebcam
% property of the beaglebone object shows the USB camera. If you do not see
% the USB camera, your USB camera is not recognized properly. Try rebooting
% your BeagleBone Black with the camera attached.
%
% Create a web camera object by executing the following commands on the MATLAB
% prompt.
%
%  bbb = beaglebone;
%
% Check the AvailableWebcams property of the bbb object to find the web
% camera name. Create webcam object using this name. Without specifying the
% camera name, it uses the one found automatically.
%
%  cam = webcam(bbb);
%
% The cam is a handle to a webcam object. Let's display the images
% captured from web camera in MATLAB.
% 
%  for i = 1:100
%      img = snapshot(cam);
%      imagesc(img);
%      drawnow;
%  end
%


%% Extract color components
%
% We will extract three 2D matrices from the 3D image data corresponding to
% the red, green, and blue components of the image. Before proceeding with
% the rest of the example, we will load a saved image. We will make sure our
% algorithm works on the test image before moving on to live data. 
img = imread('tennis_ball.png');
imagesc(img);
r = img(:, :, 1);
g = img(:, :, 2);
b = img(:, :, 3);


%% Calculate green
%
% Next we approximate the intensity of the green component 
%
justGreen = g - r/2 - b/2;


%% Threshold the green image
%
% We threshold the image to find the regions of image that we consider to
% be green enough.
bw = justGreen > 40;
imagesc(bw);

%% Find center 
%
% Find the center of the image and mark it with a dot.
[x, y] = find(bw);
if ~isempty(x) && ~isempty(y)
    xm = round(mean(x));
    ym = round(mean(y));
    xx = max(1, xm-5):min(xm+5, size(bw, 1));
    yy = max(1, ym-5):min(ym+5, size(bw, 2));
    bwbw = zeros(size(bw), 'uint8');
    bwbw(xx, yy) = 255;
end
imagesc(justGreen + bwbw);


%% Run detection algorithm on live data 
% 
% We can create a MATLAB function, trackball.m, out of the MATLAB code we
% developed in the previous sections of this example. View the MATLAB
% function in the editor.
%
%  edit('trackball.m');
%
% The function trackball() takes an image and a threshold for green
% detection and returns the results of green detection algorithm. We will
% call this function on the images captured in a loop. Before running the
% MATLAB code snippet below, get hold of a tennis ball and place it in the
% view of the BeagleBone Black Web Camera. While the MATLAB code is running,
% move the ball around.
%
%  figure;
%  for i = 1:200
%      [img, bw] = trackball(snapshot(cam), 40); 
%      subplot(2, 1, 1);
%      imagesc(img);
%      subplot(2, 1, 2);
%      imagesc(bw);
%      drawnow;
%  end