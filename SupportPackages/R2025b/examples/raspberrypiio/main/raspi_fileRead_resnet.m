function raspi_fileRead_resnet(fileName)
%#codegen
assert(size(fileName,2)==1); % Filename is a 1d array of size Nx1
assert(all(size(fileName) <= 50));
assert(isa(fileName,'char'));

%Initialize DNN and the input size
net        = coder.loadDeepLearningNetwork('resnet50');
inputSize  = [224, 224,3]; %net.Layers(1).InputSize;

%Read the image
imgSizeAdjusted = readResizedImg(fileName,inputSize);

%Classify the input image
[label,score] = net.classify(imgSizeAdjusted);

labelStr  = cellstr(label);
maxScore  = max(score);
outputStr = sprintf('Label : %s \nScore : %f',labelStr{:},maxScore);

%Print label and score to stdout
fprintf('%s\n',outputStr);
end
