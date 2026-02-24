%% Share Data in Multiwindow Apps
% This example shows how to pass data from one app to another. This
% multiwindow app consists of a main app that calls a dialog box app with
% input arguments. The dialog box displays a set of options for modifying
% aspects of the main app. When the user closes it, the dialog box sends
% their selections back to the main app.
%
% This example demonstrates the following app building tasks:
%
% * Calling an app with input arguments
% * Calling an app with a return argument that is the app object
% * Passing values to an app by calling a public function in the app
% * Writing |CloseRequestFcn| callbacks to perform maintenance tasks when each app closes
%
% <<../multiwindowapp_screenshot.png>>
%
%
% Copyright 2018 The MathWorks, Inc.