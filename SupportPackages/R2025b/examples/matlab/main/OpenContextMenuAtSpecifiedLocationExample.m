%% Open Context Menu at Specified Location
% 

% Copyright 2019 The MathWorks, Inc.

%% 
% Create a UI figure. Create a context menu with two submenus and assign it to the UI figure.
%%
fig = uifigure;

cm = uicontextmenu(fig);
m1 = uimenu(cm,'Text','Import Data');
m2 = uimenu(cm,'Text','Export Data');

fig.ContextMenu = cm;
%% 
% Then, open the context menu at location |(250,250)|.
%%
open(cm,250,250)
%%
%
% <<../open_atlocation.png>>
%