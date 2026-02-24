%% Change, and then Restore Current Folder
% Change the current folder to the featured examples folder for MATLAB 
% R2017a, assuming that version is installed on your |C:| drive.
% Then restore the current folder to its original location.


%%
% Change the current folder to the featured examples folder for MATLAB 
% R2017a.
cd 'C:\Program Files\MATLAB\R2017a\examples\matlab_featured'

%%
% Change the current folder to |C:\Program Files|, saving the folder path
% before changing it. 
oldFolder = cd('C:\Program Files') 

%%
% Use the |cd| command to display the new current folder.
cd

%%
% Change the current folder back to the original folder, using the stored
% path. Use the |cd| command to display the new current folder.
cd(oldFolder)
cd


%% 
% Copyright 2012 The MathWorks, Inc.