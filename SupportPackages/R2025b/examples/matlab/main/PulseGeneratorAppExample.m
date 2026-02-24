%% Manage App Component Position and Sizing with Grid Layout
% This app shows how to use a grid layout manager to control the alignment
% and resizing of app components when the app is resized. Grid layout
% managers allow you to easily manage the layout of app components without
% having to set the pixel positions of each component. Additionally, a
% grid layout provides more flexibility in resize behavior. For more
% information about using a grid layout manager, see
% <docid:creating_guis#mw_a93aadaa-4795-4cb0-a4d8-9515145bdd56 Use Grid
% Layout Managers in App Designer>.
% 
%% Component Behavior in Grid Layout
% In this app, the UI components on the left panel control parameters of a
% pulse. To provide a consistent experience no matter what size the app window is,
% the controls are laid out using a grid layout manager. The grid layout
% manages the alignment of the controls when the app is resized. The right
% panel contains axes for data visualization so that when a user changes
% the parameters of the pulse, the plot updates
% accordingly. To see how the components in a grid layout react to resizing,
% reduce the width of the app window. The components in the grid layout
% maintain a consistent size as the app window shrinks.
%
% <<../pulsegen_screenshot_gridlayout.png>>
%
%% Create App with Grid Layout
% Add and configure a grid layout manager in *Design View*, and then add UI
% components to the configured layout:
%
% # Create a new 2-panel app with auto-reflow from the App Designer Start
% Page.
% # Add a grid layout to the left panel. App Designer applies the grid
% layout to the entire app window or the container you place it in (in this
% case, the left panel).
% # Adjust the numbers of rows and columns in the grid. Right-click the 
% grid layout and select *Configure Grid Layout* from the context menu.
% You can add and remove rows and columns in the
% *Resize Configuration* menu by selecting a row or column. For this
% example, arrange the grid layout to have seven rows and four columns.
% # Set the |ColumnWidth| and |RowHeight| properties in the *Resize Configuration*
% menu. For this example, set |ColumnWidth| for the columns that
% contain the knobs to |"1x"| so that the columns adjust to fill the space
% as the app is resized. This weighted width ensures that the knobs
% are the same width and share space in the grid equally. Set the
% |RowHeight| property of the rows that contain edit fields to |"fit"| so
% that the rows automatically adjust to fit. 
% # Specify additional properties of the grid layout in the *Component
% Browser*. Change the spacing between columns and rows by editing the
% |ColumnSpacing| and |RowSpacing| values, and adjust the spacing around the
% outer perimeter of the grid with the |Padding| property. For more
% information about these properties, see
% <docid:matlab_ref#mw_c9790f96-bf9e-464e-b445-a64025826e6c GridLayout
% Properties>.
% # Add the UI components to the grid by dragging them from the *Component
% Library* to the corresponding location in the grid layout.
%   
% After you lay out the app using the grid layout, program the app to
% respond to user input in *Code View*. For more information about
% callbacks and how to update the plot based on user input, see
% <docid:creating_guis#busp3ol-4 Callbacks in App Designer>. Launch the
% example in App Designer to run the app and see how the grid layout
% adjusts the position and sizing of components as the app window resizes.
%
% Copyright 2015 The MathWorks, Inc.