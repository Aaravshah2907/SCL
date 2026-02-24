%% Example: App that Populates Tree Nodes Based on a Data File
% This app shows how to dynamically add tree nodes at run time.
% The three hospital nodes exist in the tree before the app runs. 
% However at run time, the app adds several child nodes under each hospital
% name. The number of child nodes and the labels on the child nodes
% are determined by the contents of the |patients.xls| spreadsheet.
%
% When the user clicks a patient name in the tree, the *Patient Information* 
% panel displays data such as age, gender, and health status. The app stores 
% changes to the data in a table array.
%
% <<../treeapp_screenshot.png>>
%
% Copyright 2018 The MathWorks, Inc.