%% Build Datastore to Read Binary Files 
% Build a datastore to bring your custom or proprietary data into
% MATLAB(R) for serial processing.

%%
% Create a |.m| class definition file that contains the code implementing
% your custom datastore. You must save this file in your working folder or
% in a folder that is on the MATLAB(R) path. The name of the |.m| file must
% be the same as the name of your object constructor function. For example,
% if you want your constructor function to have the name MyDatastore,
% then the name of the |.m| file must be |MyDatastore.m|. The |.m|
% class definition file must contain the following steps:
%
% * Step 1: Inherit from the datastore classes.
% * Step 2: Define the constructor and the required methods.
% * Step 3: Define your custom file reading function.
%
% In addition to these steps, define any other properties or methods that
% you need to process and analyze your data. 
%
% <include>MyDatastore.m</include>
%
%%
% Your custom datastore is now ready. Use |MyDatastore| to create a
% datastore object for reading your binary data files.


%% 
% Copyright 2012 The MathWorks, Inc.