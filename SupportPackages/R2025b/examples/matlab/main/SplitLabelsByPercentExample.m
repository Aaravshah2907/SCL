%% Split Labels by Percentage
% Create an |ImageDatastore| object and label each image according to the
% name of the folder it is in.  The resulting label names are |demos| and
% |imagesci|.
imds = imageDatastore(fullfile(matlabroot, 'toolbox', 'matlab', {'demos','imagesci'}),...
'LabelSource', 'foldernames', 'FileExtensions', {'.jpg', '.png', '.tif'});

imds.Labels

%%  
% Create two new datastores from the files in |imds|.  The first datastore
% |imds60| contains the first 60% of files with the |demos| label and the
% first 60% of files with the |imagesci| label.  The second datastore
% |imds40| contains the remaining 40% of files from each label.  If the
% percentage applied to a label does not result in a whole number of files,
% |splitEachLabel| rounds down to the nearest whole number.
[imds60,imds40] = splitEachLabel(imds,0.6)


%% 
% Copyright 2012 The MathWorks, Inc.