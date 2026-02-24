%% Change Row Height in Range of Spreadsheet Cells
% This example shows how to change the height of a row, defined by a |Range| 
% object, in a spreadsheet.
%% 
% The Excel(R) |Range| object is a property that takes input arguments.
% MATLAB(R) treats such a property as a method. Use the |methods| function 
% to get information about creating a |Range| object.
%% 
% Create a |Worksheet| object |ws|.
e = actxserver('Excel.Application');
wb = Add(e.Workbooks);
e.Visible = 1;
ws = e.Activesheet;
%% 
% Display the default height of all the rows in the worksheet.
ws.StandardHeight
%% 
% Display the function syntax for creating a |Range| object. Search the 
% displayed list for the |Range| entry: 
% |handle Range(handle,Variant,Variant(Optional))|
methods(ws,'-full')
%% 
% Create a |Range| object consisting of the first row.
wsRange = Range(ws,'A1');
%% 
% Increase the row height.
wsRange.RowHeight = 25;
%% 
% Open the worksheet, click in row 1, and notice the height.
%% 
% Close the workbook without saving.
wb.Saved = 1;
Close(e.Workbook)
%% 
% Close the application.
Quit(e)
delete(e)

%% 
% Copyright 2012 The MathWorks, Inc.