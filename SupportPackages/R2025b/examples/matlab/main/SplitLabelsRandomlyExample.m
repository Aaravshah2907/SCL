%% Randomly Split Labels
% Create an |ImageDatastore| object and label each image according to the
% name of the folder it is in.  The resulting label names are |demos| and
% |imagesci|.
imds = imageDatastore(fullfile(matlabroot, 'toolbox', 'matlab', {'demos','imagesci'}),...
'LabelSource', 'foldernames', 'FileExtensions', {'.jpg', '.png', '.tif'});

imds.Labels

%%  
% Create two new datastores from the files in |imds| by randomly drawing
% from each label.  The first datastore |imds1| contains one random file
% with the |demos| label and one random file with the |imagesci| label.  The
% second datastore |imds2| contains the remaining files from each label.
[imds1, imds2] = splitEachLabel(imds,1,'randomized')


%% 
% Copyright 2012 The MathWorks, Inc.