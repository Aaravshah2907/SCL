function raspi_arducam_panorama
% This function is responsible for capturing 4 images using ArduCam Multi
% Camera Adapter Module v1.2 and stitch these images for a panoramic view
%
% Hardware Setup:
%       Raspberry Pi 3 Model B+ with OpenCV libraries installed
%       ArduCam Mutli Camera Adapter Module v2
%       4 5MP OV5647 Cameras

% Copyright 2023 The MathWorks, Inc.

%#codegen

% Define image width and height.
imgHeight = 480;
imgWidth = 640;

% Define image resolution.
imgResolution = '640x480';

% Define number of images.
numImages = 4;

% Create image array to store the captured images.
imgArray = uint8(zeros(imgHeight,imgWidth,3,numImages));

% Create an array of 2-D projective geometric transformation.
tforms = {projtform2d(eye(3, 'single')) projtform2d(eye(3, 'single')) projtform2d(eye(3, 'single')) projtform2d(eye(3, 'single'))};

% Creates an alpha blender System object
blender = vision.AlphaBlender('Operation', 'Binary mask', 'MaskSource', 'Input port');

% Create a raspi object.
raspiObj = raspi();

% Create arducam object
camObj = arducam(raspiObj,'MultiCamAdapter','Resolution',imgResolution);
availableCameras = {'CAMERA A','CAMERA B','CAMERA C','CAMERA D'};

% Main loop
for loopCount = 1:10

    % Initialize the empty panorama. Create a panorama canvas which is twice
    % the captured image height and width.
    panoramaImgHeight = 2*imgHeight;
    panoramaImgWidth = 2*imgWidth;
    panorama = uint8(zeros(panoramaImgHeight, panoramaImgWidth, 3));

    % Capture first image from the cameraboard and convert to grayscale.
    selectCamera(camObj,availableCameras{1});
    imgArray(:,:,:,1) = snapshot(camObj);
    grayImage = im2gray(imgArray(:,:,:,1));

    % Detect SURF features for the first image and extract features.
    points = detectSURFFeatures(grayImage);
    [features, points] = extractFeatures(grayImage,points, 'Method','SURF');

    % Iterate over remaining images
    for n = 2:numImages
        % Store points and features for image (n-1).
        pointsPrevious = points;
        featuresPrevious = features;

        % Capture an image.
        selectCamera(camObj,availableCameras{n});
        imgArray(:,:,:,n) = snapshot(camObj);

        % Convert image to grayscale.
        grayImage = im2gray(imgArray(:,:,:,n));

        % Detect and extract SURF features for the captured images.
        points = detectSURFFeatures(grayImage);
        [features, points] = extractFeatures(grayImage, points);

        % Find correspondences between current image and previous image.
        indexPairs = matchFeatures(features, featuresPrevious, 'Unique', true);

        % Extract the matched point locations.
        matchedPoints  = points.Location(indexPairs(:,1),:);
        matchedPointsPrev = pointsPrevious.Location(indexPairs(:,2),:);

        % Estimate the transformation between current image and previous image.
        tforms{n} = estgeotform2d(matchedPoints, matchedPointsPrev,...
            'projective', 'Confidence', 99.9, 'MaxNumTrials', 5000);

        % Compute T(1) * T(2) * ... * T(n-1) * T(n).
        tforms{n}.A = tforms{n-1}.A * tforms{n}.A;
    end

    % Compute the output limits for each transformation.
    xlim = zeros(numel(tforms) ,2);
    ylim = zeros(numel(tforms) ,2);
    [xlim(1,:), ylim(1,:)] = outputLimits(tforms{1}, [1 0], [1 0]);
    for i = 2:numel(tforms)
        [xlim(i,:), ylim(i,:)] = outputLimits(tforms{i}, [1 imgWidth], [1 imgHeight]);
    end

    % Compute the average X limits for each transformation and find the image
    % that is in the center. Only the X limits are used here because the
    % cameras are horizontally placed.
    avgXLim = mean(xlim, 2);
    [~,idx] = sort(avgXLim);
    centerIdx = floor((numel(tforms)+1)/2);
    centerImageIdx = idx(centerIdx);

    % Apply the center image's inverse transformation to all the others.
    Tinv = invert(tforms{centerImageIdx});
    for i = 1:numel(tforms)
        tforms{i}.A = Tinv.A * tforms{i}.A;
    end

    % Use the outputLimits method to compute the minimum and maximum output
    % limits over all transformations.
    [xlim(1,:), ylim(1,:)] = outputLimits(tforms{1}, [1 0], [1 0]);
    for i = 2:numel(tforms)
        [xlim(i,:), ylim(i,:)] = outputLimits(tforms{i}, [1 imgWidth], [1 imgHeight]);
    end

    % Find the minimum and maximum output limits.
    xMin = min([1; xlim(:)]);
    xMax = max([imgWidth; xlim(:)]);

    yMin = min([1; ylim(:)]);
    yMax = max([imgHeight; ylim(:)]);

    % Create a 2-D spatial reference object defining the size of the panorama.
    xLimits = [xMin xMax];
    yLimits = [yMin yMax];
    panoramaView = imref2d([panoramaImgWidth panoramaImgHeight], xLimits, yLimits);


    % Create the panorama.
    for i = 1:numImages

        % Transform images into the panorama.
        wrapedImage = imwarp(imgArray(:,:,:,i), tforms{i}, 'OutputView', panoramaView);

        % Generate a binary mask.
        mask = imwarp(true(size(imgArray(:,:,:,i),1),size(imgArray(:,:,:,i),2)), tforms{i}, 'OutputView', panoramaView);

        % Overlay the warpedImage onto the panorama.
        panorama = blender(panorama,wrapedImage,mask);
    end


    % Display the panoramic image
    displayImage(raspiObj,panorama);
end
end