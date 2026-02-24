%% Display HTML Content in an App
% You can add HTML content, like JavaScript(R), CSS, and icons, to your app
% in App Designer. This app shows how to display an 
% HTML button styled by CSS and plot data that is generated in JavaScript. 
% This example also desmonstrates these app building tasks:
%
% * Access HTML, CSS, and supporting files within an app.
% * Write a callback function for HTML UI components.
%
% <<../uihtml_CSS_and_Plot.png>>
%
%% Create and Add HTML Content to App
% Create a styled button using HTML with these files:
%
% * |dataForm.html| &mdash; This HTML file creates an HTML button element and
% implements JavaScript code to respond to user interaction.
% * |inputStyles.css| &mdash; This CSS file styles the HTML button element.
% * |gears-icon.png| &mdash; This supporting image file provides a custom icon
% for the HTML button element. 
%
% Within your CSS file, style the button with the icon image file as 
% the background image. Then reference both the
% CSS and image file inside of body tags in your HTML file.
% 
%   <link rel="stylesheet" type="text/css" href="./inputStyles.css">
%   <link rel="icon" type="image/png" href="gears-icon.png">
%
% To add this HTML button styled by CSS to your App Designer app, drag an HTML UI
% component from the *Component Library* to your app canvas in *Design View*. 
% Link this component to your HTML file by selecting the HTML UI component 
% in the *Component Browser* and setting the |HTMLSource| property as your 
% HTML file. Make sure that your HTML file and all supporting files are in the same
% folder and on your MATLAB path so that you can reference these files in
% your app code. 
%
%% Connect HTML File Content to HTML UI Component
% To access the data from the HTML file in your app,
% you must first implement a JavaScript function named |setup| inside 
% script tags in your HTML file. In this |setup| function, define
% and initialize a local JavaScript |htmlComponent| object that links to the
% MATLAB |HTML| object. Then add a button callback in the |setup| 
% function to generate random numbers using this JavaScript object.
%
%   function setup(htmlComponent) {
%       var initialData = htmlComponent.Data; 
%       % Add button callback to generate random number on click
%       % ...
%   }
%
% For more information about using HTML elements in
% MATLAB, see <docid:creating_guis#mw_91d32db7-b12c-47e3-893d-502c2f8b0c98
% Create HTML Content in Apps>.
%
%% Create Callback Function for HTML Component
% To plot the random numbers in your app, create a |DataChangedFcn|
% callback for the HTML UI component. The callback functions in the HTML file and App Designer work  
% in conjunction. When you click the HTML button in the app, the JavaScript button
% callback executes and generates a random number. The JavaScript function stores the random number in
% the |Data| property of the |htmlComponent| object which is synchronized with the |Data| property of the
% MATLAB |HTML| object. Because the data value changed, MATLAB executes the
% |DataChangedFcn| callback.
% 
% Access the synchronized data value using dot notation in your App Designer 
% callback code.
% 
%   data = app.JSDataHTML.Data;
% 
% Then plot an animated line to visualize the data changing as you click the
% HTML button.
%           
%   for k = 1:length(app.numclicks)
%       aline = animatedline(app.UIAxes,"MaximumNumPoints",10000,"Marker","*");
%       addpoints(aline,app.numclicks,data(k)); 
%       drawnow
%   end
%
% To view the fully coded app and embedded HTML files, launch this example
% in App Designer.
%
% Copyright 2019 The MathWorks, Inc.
