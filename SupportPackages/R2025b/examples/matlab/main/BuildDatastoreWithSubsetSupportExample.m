%% Build Datastore with Subset Support
% Build a datastore with subset processing support and use it to bring your 
% data into MATLAB(R).

%%
% Create a class definition file that contains the code implementing
% your datastore. Save this file in your working folder or in a
% folder that is on the MATLAB path. The name of the |.m| file must be
% the same as the name of your object constructor function. In this example, 
% create the |MyHDF5Datastore| class in a file named |MyHDF5Datastore.m|. 
% The |.m| class definition contains the following steps:
%
% * Step 1: Inherit from the |matlab.io.Datastore| and
% |matlab.io.datastore.Subsettable| classes. 
% * Step 2: Define the constructor as well as the |subsetByReadIndices| and 
% |maxpartitions| methods.
% * Step 3: Define your custom file-reading function. Here, the
% |MyHDF5Datastore| class creates and uses the 
% |listHDF5Datasets| function. 
%
% <include>MyHDF5Datastore.m</include>
% 
%%
% Copyright 2022 The MathWorks, Inc.


