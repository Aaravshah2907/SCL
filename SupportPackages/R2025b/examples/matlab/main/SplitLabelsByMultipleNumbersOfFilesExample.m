%% Split Labels Several Ways by Number of Files
% Create an |ImageDatastore| object and label each image according to the
% name of the folder it is in.  The resulting label names are |demos| and
% |imagesci|.
imds = imageDatastore(fullfile(matlabroot, 'toolbox', 'matlab', {'demos','imagesci'}),...
'LabelSource', 'foldernames', 'FileExtensions', {'.jpg', '.png', '.tif'});

imds.Labels

%%  
% Create three new datastores from the files in |imds|.  The first
% datastore |imds1| contains the first file with the |demos| label and the
% first file with the |imagesci| label.  The second datastore |imds2|
% contains the next file from each label.  The third datastore |imds3|
% contains the remaining files from each label.
[imds1, imds2, imds3] = splitEachLabel(imds,1,1)


%% 
% Copyright 2012 The MathWorks, Inc.