%% Shuffle Files
% Create an |ImageDatastore| object |imds|.  Shuffle the files to
% create a new datastore containing the same files in random order. 
imds = imageDatastore(fullfile(matlabroot, 'toolbox', 'matlab', {'demos','imagesci'}),'LabelSource','foldernames','FileExtensions', {'.jpg', '.png', '.tif'})

%%
imdsrand = shuffle(imds)

%% 
% Copyright 2012 The MathWorks, Inc.