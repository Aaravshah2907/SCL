%% Example: UI Component with Custom Event Data
%
% Use the custom event data of the |RGBPicker| UI component to update the
% background color of a panel when the slider values changes.
%
% * Create an |RGBPicker| component and a panel in a UI figure.
% * Define a |ColorChangedFcn| callback for the component that executes when a user updates one of the slider values.
% * In the callback function, use the event input argument to access the new RGB triplet value associated with the user interaction and update the panel background color.

fig = uifigure;
fig.Position(3:4) = [550 170];
c = RGBPicker(fig);
p = uipanel(fig);
p.Position = [300 10 200 130];
p.BackgroundColor = c.RGB;
c.ColorChangedFcn = @(src,event)updatePanelColor(src,event,p);

function updatePanelColor(src,event,p)
color = event.RGB;
p.BackgroundColor = color;
end

% Copyright 2021 The MathWorks, Inc.
