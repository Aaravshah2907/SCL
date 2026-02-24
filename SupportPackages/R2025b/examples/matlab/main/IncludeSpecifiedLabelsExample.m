%% Include and Exclude Specified Labels
% Create an |ImageDatastore| object and label each image according to the
% name of the folder it is in.  The resulting label names are |demos| and
% |imagesci|.
imds = imageDatastore(fullfile(matlabroot, 'toolbox', 'matlab', {'demos','imagesci'}),...
'LabelSource', 'foldernames', 'FileExtensions', {'.jpg', '.png', '.tif'});

imds.Labels

%%  
% Create two new datastores from the files in |imds|, including only the
% files with the |demos| label.  The first datastore |imds60| contains
% the first 60% of files with the |demos| label and the second datastore |imds40| contains the
% remaining 40% of files with the |demos| label.  
[imds60, imds40] = splitEachLabel(imds,0.6,'Include','demos')

%%
% Equivalently, you can split only the |demos| label by excluding the
% |imagesci| label.
[imds60, imds40] = splitEachLabel(imds,0.6,'Exclude','imagesci')

%% 
% Copyright 2012 The MathWorks, Inc.