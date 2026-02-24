%% Example: Helper Function That Updates Plot
% This app shows how to use a helper function to both initialize and update
% a plot. The app calls the |updatePlot| private helper function at the end
% of the |startupFcn| callback to initialize a plot when the app starts up.
% The |UITableDisplayDataChanged| callback also calls the |updatePlot|
% function to update the same plot when the user sorts columns or changes a
% value in the table.
%
% <<../table_app_screenshot.png>>

%% 
% Copyright 2012 The MathWorks, Inc.