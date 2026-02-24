%% Create App That Resizes with Auto-Reflow
% This example shows how to create an app with auto-reflow that responds to
% resizing by automatically growing, shrinking, and reflowing the app
% content. Use auto-reflow for apps that you intend to be shared across
% multiple environments with varying resolutions and screen sizes. With
% auto-reflow, your app can resize and reflow the app contents to fit the
% screen size of each app user. For more information about auto-reflow in apps, see
% <docid:creating_guis#mw_2f1316f6-130f-49da-a9fd-1a4eabc9791c Apps with
% Auto-Reflow>.
%
%% App Auto-Reflow Behavior 
% In this app, the controls are in an anchored panel on the left. The right
% panel that reflows contains two tabs with visualizations and a table of data.
% The app content in this panel resizes and reflows based on the app window 
% size. For example, when you reduce the width of the app window, the
% right panel dynamically adjusts to the resizing and moves below the
% anchored left panel.
%
% <<../patientsdisplay_screenshot_19a.png>>
%
%% Create App with Auto-Reflow
% Start by creating a new 2-panel app with auto-reflow from the App Designer Start
% Page. App Designer creates two panels; the left panel is fixed and the
% right panel reflows. Then lay out the components in *Design View*:
%
% * Add the controls to the left panel from the *Component Library*. Use 
% additional panels within the left panel to group related controls. 
% * Add the axes for visualizations and a table for data within a tab group
% to the right panel. When you adjust the size
% of the app window, the components in this reflowing panel automatically
% adjust their layout. 
%
% After you lay out the app, program the app to respond to
% user input in *Code View*. For more information about how to create 
% callback functions to update the axes and table based on user input, see
% <docid:creating_guis#busp3ol-4 Callbacks in App Designer>.
% To explore the fully coded app and see how the  auto-reflow works in the 
% app, launch this example in App Designer.
%
% Copyright 2015 The MathWorks, Inc.