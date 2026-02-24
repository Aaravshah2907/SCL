% CREATEOBJECTDECTOR - run the script to create a YOLOv2 object detector
% based on the gTruth label data.  

% Copyright 2020 The MathWorks, Inc
%%
labelData   = 'objectLabel.mat'; % mat file with object label (gTruth data)
imageSize   = [224 224 3];       % Size of input image for the network
numClasses  = 1;                 % Number of objects to detect
sampleImage = 'sampleImage.jpg'; % Sample image for verifying 
%%
%---------------------------------------------
% Create a YOLO v2 object detection network.
%--------------------------------------------- 
% Use a pretrained ResNet-18 as base of YOLO v2. This requires  the Deep
% Learning Toolbox Model for ResNet-18 Network Addon. 
network = resnet18();

% Specify the network layer to use for feature extraction. Use 
% 'analyzeNetwork' to see all the layer names in a network. 
% The below steps will delete the layers after the feature layer from the 
% feature extraction network.  A good feature extraction layer for YOLOv2
% is one where the output features width and height are between 8 and 16 
% times smaller than the input image.
% In this case, the input dimension is [224 224 3]. So, search for 
% something that is around 224/16 ~14. On analyzing resnet18, res3b_relu 
% was found to be downsampled by a factor of 16. This amount of 
% downsampling is a good tradeoff between spatial resolution and the 
% strength of the extracted features (features extracted further down the 
% network encode stronger image features at the cost of spatial resolution). 
featureLayer = 'res3b_relu';

% Specify the anchor boxes. 
anchorBoxes  = [64,64];

% Create the YOLO v2 object detection network. 
lgraph       = yolov2Layers(imageSize, numClasses, anchorBoxes,...
                            network, featureLayer);

% Visualize the network using the network analyzer.
% analyzeNetwork(lgraph)

options = trainingOptions('sgdm', 'InitialLearnRate',0.001,...
                          'Verbose',true, 'MiniBatchSize',16,...
                          'MaxEpochs',30,'Shuffle','never',...
                          'VerboseFrequency',30,'CheckpointPath',tempdir);

% Load gTruth data from mat file and create datastore for training
load(labelData); 
[imds,blds]     = objectDetectorTrainingData(gTruth);
ds              = combine(imds,blds);
[detector,info] = trainYOLOv2ObjectDetector(ds,lgraph,options);
%%
% Verify the detector using sample image
img             = imread(sampleImage);
[bboxes,scores] = detect(detector,img); % bboxes = (x,y,length,breadth)
imgWithBox      = insertObjectAnnotation(img,'rectangle',bboxes,scores);
imshow(imgWithBox);
%%
% Save the detector to a mat file for future use
save('detectorSaved.mat','detector')


