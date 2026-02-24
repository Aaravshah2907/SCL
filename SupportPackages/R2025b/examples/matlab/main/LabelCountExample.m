%% Label Count
% Create an |ImageDatastore| object and label each image according to the
% folder it is in.
imds = imageDatastore(fullfile(matlabroot, 'toolbox', 'matlab', {'demos','imagesci'}),...
'LabelSource', 'foldernames', 'FileExtensions', {'.jpg', '.png', '.tif'})

%%  
% List the file count for each label.
T = countEachLabel(imds)

%% 
% Copyright 2012 The MathWorks, Inc.