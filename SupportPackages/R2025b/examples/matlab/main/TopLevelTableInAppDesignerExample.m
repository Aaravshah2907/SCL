%% Create Interactive Table in an App
% Tables are useful for storing and displaying tabular data. This example
% shows how to display data in an app using a table UI component. You can
% also configure the table so that app users can interact with it by
% sorting or editing the data.
%
%% App Overview
% When the app starts up, it loads a spreadsheet of patient data into a table array.
% Then it displays and plots a subset of the data from the table array. One
% of the plots updates when an app user edits values or sorts columns in the
% table UI component at run time. The app provides a plot of the original
% data for comparison.
%
% <<../table_app_screenshot.png>>
%
%% Create App with Table
% Display patient data in a table UI component and enable its interactive
% features:
%
% # Add a table to the app canvas in *Design View*, and configure the
% table in the *Component Browser*. Rename the four table columns, and specify
% whether the columns can be editable and sortable when a user interacts
% with the table UI component. For more information about using tables in App
% Designer and configuring table behavior, see
% <docid:creating_guis#mw_ef9792c8-0f43-4ec6-9a95-a23465c35705 Add Tables
% to App Designer Apps>.
% # Populate the table UI component programmatically within a |startupFcn| 
% callback function. Create the |startupFcn| callback by right-clicking the app node in the 
% *Component Browser* and selecting *Callbacks > Add StartupFcn callback*. 
% First, load the patient data from a spreadsheet and then programmatically assign this tabular
% data to the table UI component using the |Data| property. For more 
% information about displaying table data in a table
% UI component, see <docid:creating_guis#bvetvmr Format Tabular Data in
% Apps>. 
%
%   function startupFcn(app)
%       % Read table array from file
%       t = readtable("patients.xls");
%       % Configure table appearance
%       % ...
%       % Add data to the table UI component
%       app.UITable.Data = t;
%   end
%
% After you add and configure the table UI component, program the app to
% update a plot when an app user modifies the table data. In a 
% helper function named |updatePlot|, add code to get the
% current table data and plot the modified data. Then create a
% callback function named |UITableDisplayDataChanged| to update the plot 
% when an app user changes the table data by using the |updatePlot| helper 
% function. For more information about callbacks, see 
% <docid:creating_guis#busp3ol-4 Callbacks in App Designer>.
%
%   function UITableDisplayDataChanged(app,event)
%       % Update the plots when user sorts the columns of the table
%       updatePlot(app);
%   end
%
% To view and explore the fully coded app, launch this
% example in App Designer. Run the app and edit some of the table fields to
% see changes in the Updated Data plot.
%
% Copyright 2018 The MathWorks, Inc.