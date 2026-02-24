%% Create Modal UI Figure
% Create two UI figure windows. Block interactions in Figure 1 by
% specifying |'modal'| as the |WindowStyle| property value for Figure 2.
% Notice that you cannot interact with Figure 1 until Figure 2 is closed.

% Copyright 2020 The MathWorks, Inc.

%%
fig1 = uifigure('Name','Figure 1');
fig1.Position = [500 500 370 270];

fig2 = uifigure('Name','Figure 2');
fig2.Position = [540 450 370 270];
fig2.WindowStyle = 'modal';
%%
%
% <<../uifigure_modal.png>>
%