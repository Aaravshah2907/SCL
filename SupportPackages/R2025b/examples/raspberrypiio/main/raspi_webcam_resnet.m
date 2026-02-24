function raspi_webcam_resnet()
%#codegen
% Copyright 2020 The MathWorks, Inc.

%Create raspi & webcam obj
raspiObj = raspi();
cam      = webcam(raspiObj,1);

%Initialize DNN and the input size
net        = coder.loadDeepLearningNetwork('resnet50');
inputSize  = [224, 224,3]; %net.Layers(1).InputSize;

%Initialize text to display
textToDisplay = '......';

% Main loop
start = tic;
fprintf('Entering into while loop.\n');
while true
    %Capture image from webcam
    img = snapshot(cam);
    
    elapsedTime = toc(start);
    %Process frames at 1 per second
    if elapsedTime > 1
        %Resize the image
        imgSizeAdjusted = imresize(img,inputSize(1:2));
        
        %Classify the input image
        [label,score] = net.classify(imgSizeAdjusted);
        maxScore = max(score);
        
        labelStr = cellstr(label);
        textToDisplay = sprintf('Label : %s \nScore : %f',labelStr{:},maxScore);
        start = tic;
    end
    
    %Display the predicted label
    img_label = insertText(img,[0,0],textToDisplay);
    displayImage(raspiObj,img_label);
end
end

