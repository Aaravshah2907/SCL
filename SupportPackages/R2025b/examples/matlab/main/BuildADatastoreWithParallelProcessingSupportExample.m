%% Build Datastore with Parallel Processing Support
% Build a datastore with parallel processing support and use it to
% bring your custom or proprietary data into MATLAB(R). Then, process the
% data in a parallel pool.

%%
% Create a |.m| class definition file that contains the code implementing
% your custom datastore. You must save this file in your working folder or
% in a folder that is on the MATLAB(R) path. The name of the |.m| file must
% be the same as the name of your object constructor function. For example,
% if you want your constructor function to have the name MyDatastorePar,
% then the name of the |.m| file must be |MyDatastorePar.m|. The |.m|
% class definition file must contain the following steps:
%
% * Step 1: Inherit from the datastore classes.
% * Step 2: Define the constructor and the required methods.
% * Step 3: Define your custom file reading function.
%
% In addition to these steps, define any other properties or methods that
% you need to process and analyze your data. 
%
% <include>MyDatastorePar.m</include>
%
%%
% Your custom datastore is now ready. Use your custom datastore to read and
% process the data in a parallel pool.

%% 
% Copyright 2012 The MathWorks, Inc.