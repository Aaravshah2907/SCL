%% Partition Datastore by Files
% Create a datastore that contains three image files.

ds = imageDatastore({'street1.jpg','peppers.png','corn.tif'})

%%
% Partition the datastore by files and return the part corresponding to the second file.

subds = partition(ds,'Files',2)

%%
% |subds| contains one file.

%% 
% Copyright 2012 The MathWorks, Inc.