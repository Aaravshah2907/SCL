%% Example: Timer Component That Performs Startup Tasks
% This example shows how to program the startup tasks and behavior of a
% custom timer component. The |PostSetupFcn| creates and configures the
% underlying |timer| object that controls the component behavior.
%
% <<../TimerComponentScreenshot.png>>
% 
% The component consists of:
% 
% * Text that counts down the time remaining on the timer
% * |Start|, |Stop|, and |Reset| buttons for app users to interact with the
% timer
% * Public properties named |Seconds| and |Minutes| for app creators to
% specify the length of the timer
% * A public callback named |TimerEndedFcn| for app creators to program a
% response to the timer reaching zero
%
% To explore the component code, open the |TimerComponent.mlapp| file
% in App Designer.

% Copyright 2021 The MathWorks, Inc.
