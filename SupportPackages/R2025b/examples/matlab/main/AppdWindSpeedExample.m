%% Use Timer to Plot Data Periodically in an App
% This app shows how to configure a timer in App Designer to execute a task
% at regular time intervals. In this example, the app uses a timer to query
% wind speed data from a website every five seconds and then plots the
% returned value.
%
% <<../windspeed_app_screenshot.png>>
%
%% Query and Plot Data
% In a callback function for the timer, write the code for the task that 
% you want to execute periodically. Create a private function named 
% |WindSpeedTimerFcn| and include two extra input
% arguments in the function header. The first argument, often named |src|,
% specifies the object that triggers the callback, and the second argument,
% often named |event|, provides event data to the callback function.
% Passing these two extra input arguments specify the function as a timer
% callback. For more information about the syntax for timer callbacks, see
% <docid:matlab_prog#f9-39541 Timer Callback Functions>. 
% 
% Within this callback, add code to extract and process data from a website. 
% Then plot the data using the axes as the first argument in the |plot|
% function. For more information about plotting within an app, see
% <docid:creating_guis#bu4x85e Display Graphics in App Designer>.
%
%   function WindSpeedTimerFcn(app,src,event)
%      % Get current time
%      tnow = datetime("now","TimeZone","America/New_York");
%      % Get wind speed data from MathWorks weather station
%      weatherdata = webread("https://api.thingspeak.com/channels/12397/feeds/last.json");
%      y = str2double(weatherdata.field2);
%      % Plot data 
%      plot(app.UIAxes,tnow,y,"ob");
%      % Adjust x and y limits based on plotted data
%      % ...
% end    
%
%% Create Timer
% Create a timer that runs the |WindSpeedTimerFcn| function every five
% seconds. First, create a private property named |WindSpeedTimer| to
% store the timer so that you can modify and delete the timer in
% different parts of the app code. Select *Property* from the *Editor* tab
% in the App Designer toolstrip and choose the *Private Property* option.
% Then in a |startupFcn| callback, create the timer and store it in |WindSpeedTimer|.
%
%   app.WindSpeedTimer = timer("ExecutionMode","fixedRate","Period",5, ...
%       "BusyMode","queue","TimerFcn",@app.WindSpeedTimerFcn)
%
% This function call configures the timer to run repeatedly every five
% seconds. It also queues timer callbacks when the timer is busy and 
% specifies the function |WindSpeedTimerFcn| as the
% callback function to execute at regular intervals when the timer is
% running. Use the function handle |@app.WindSpeedTimerFcn| to associate
% this function with the |TimerFcn| callback of the |timer| object. MATLAB(R)
% automatically passes two input arguments to the callback function when
% the function executes, so the function handle does not explicitly refer
% to any input arguments.
%
%% Start and Stop the Timer
% Create callback functions to start and stop the timer when the
% corresponding buttons are pushed. Access the |timer| object in these
% callback functions by referencing the |app.WindSpeedTimer| property:
%
% * Start the timer, if it is not already running, in a callback function
% for when the *Start* button is pushed.
%
%   if strcmp(app.WindSpeedTimer.Running,"off")
%      start(app.WindSpeedTimer);
%   end
%
% * Stop the timer in a callback function for when the *Stop* button is
% pushed.
%
%   stop(app.WindSpeedTimer);
%
% For more information about callbacks, see <docid:creating_guis#busp3ol-4
% Callbacks in App Designer>.
%
%% Delete Timer When App Closes
% To optimize app performance, delete the timer when the app closes by
% creating a close request callback function. Start by adding a
% |CloseRequestFcn| callback for the app by right-clicking the UI figure in the
% *Component Browser* and selecting *Callbacks > Add CloseRequestFcn
% callback* in the context menu. Then in this |CloseRequestFcn| callback,
% stop the timer.
%
%   stop(app.WindSpeedTimer);
%
% Finally, delete the timer and figure.
%
%   delete(app.WindSpeedTimer); 
%   delete(app);
%
% To view and run the fully coded app, launch this example in App Designer.
%
% Copyright 2018 The MathWorks, Inc.