function [outImg,posIncFactor] = raspi_yolov2_detect(inputImg)
% RASPI_YOLOV2_DETECT This function uses a YOLOv2 based DNN saved in as a
% mat file. The 'inputImg' will be passed to the detector network and if
% object is detected, 'outImg' will have those details with proper bounding
% box. 'posIncFactor' indicates the roatation factor required to maintain
% the object at the center of the frame.

% Copyright 2020 The MathWorks, Inc.
%#codegen
imageSize = [224 224 3]; % Input image size for the network
assert(all(size(inputImg) == imageSize));
assert(isa(inputImg,'uint8'));

persistent yolov2Obj;
if isempty(yolov2Obj)
    yolov2Obj = coder.loadDeepLearningNetwork('detectorSaved.mat');
end

%Initialize text to display
textToDisplay = '......'; %#ok<NASGU>

% Detect object within inputImg
[bboxes,val,labels] = yolov2Obj.detect(inputImg,'Threshold',0.5); %#ok<ASGLU>

% Annotate detections in the image.
if isempty(bboxes)
    outImg       = inputImg;
    posIncFactor = 1;
else
    textToDisplay = sprintf('%f',val(1));
    outImg        = insertObjectAnnotation(inputImg,'rectangle',bboxes,textToDisplay);
    boxCenter     = [floor( bboxes(1) + (bboxes(3)/2) ), floor( bboxes(2) + (bboxes(4)/2) )];
    posIncFactor  = (-1)*(boxCenter(1) - (imageSize(1)/2))/(imageSize(1)/2);
end
end