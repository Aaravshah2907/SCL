%% Change Cursor in Spreadsheet
% This example shows how to change the cursor icon in an Excel(R) spreadsheet.
%% 
% Create a COM server running a Microsoft(R) Excel application.
h = actxserver('Excel.Application');
h.Visible = 1;
%% 
% Open the Excel program and notice the cursor.
%% 
% View the options for the |Cursor| property. These values are enumerated values, 
% which means they are the only values allowed for the property.
set(h,'Cursor')
%% 
% Change the cursor to |xlIBeam|.
h.Cursor = 'xlIBeam';
%% 
% Notice the cursor in the program.
%% 
% Reset the cursor.
h.Cursor = 'xlDefault';
%% 
% Close workbook objects you created to prevent potential memory leaks.
Quit(h)
delete(h)

%% 
% Copyright 2012 The MathWorks, Inc.