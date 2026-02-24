%% Example: Convert Components to Use Grid Layout Manager Instead of Pixel-Based Positions
% This app shows how to apply a grid layout manager to the figure of an
% app that already has components in it. It also shows how to configure the 
% grid layout manager so that the rows and columns automatically adjust to 
% accommodate changes in size of text-based components.

% Copyright 2019 The MathWorks, Inc.

%%
% # Open the app in App Designer. In *Design View*, drag a grid layout 
% manager into the figure.
% # Right-click the grid layout manager that you just added to the
% figure and select *Configure Grid Layout* from the context menu.
% # One-by-one, select the rows and columns of the grid that contain the
% drop-down menus and the table and change their resize configurations to
% *Fit*. When you are finished, verify that in the *Inspector* tab of the
% *Component Browser*, the *ColumnWidth* values are 
% |12.64x,1.89x,fit,fit,fit,fit| and the *RowHeight* values are 
% |1x,fit,1.93x,fit,3.07x,fit|.
% # Switch to *Code View*. Update each of the |DropDownValueChanged|
% callbacks so that the |allchild| functions set the font name and font 
% size on components in |app.GridLayout|, instead of in |app.UIFigure|. 
% # Now run the app to see how the grid adjusts to accommodate the
% components as their sizes change.
% 
% <<../afterAddingGridWithFit.png>>
%