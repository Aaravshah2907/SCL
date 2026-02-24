%% Compress a Folder
% Compress the contents of a folder including all subfolders, and store the relative
% paths in the zip file.

%%
% Create a folder |myfolder| containing a subfolder |mysubfolder| and the
% files |membrane.m| and |logo.m|.
mkdir myfolder;
movefile('membrane.m','myfolder');
movefile('logo.m','myfolder');
cd myfolder;
mkdir mysubfolder;
cd ..

%%
% Compress the contents of |myfolder|, including all subfolders.
zippedfiles = zip('myfiles.zip','myfolder');


%% 
% Copyright 2012 The MathWorks, Inc.