%% Plot Data Read from ThingSpeak Channel
% This example shows how to read data from a public ThingSpeak&trade; channel and
% create a simple plot visualization from the results.

% Copyright 2018 The MathWorks, Inc.

%% Read Data from ThingSpeak Channel
% ThingSpeak channel 102698 contains air quality data from a parking garage
% in Natick, Massachusetts. Field 5 is a measure of dust concentration.
%%
[dustData,Timestamps]=thingSpeakRead(102698,'Fields',5,'NumPoints',3000);
%% Plot the Dust Concentration over Time
% Use |plot| to visualize the data. Use |ylabel| and |title| to add labels to your plot.
%%
plot(Timestamps,dustData);
ylabel('Dust Concentration (ppm)');
title('MathWorks Air Quality Station, East Parking Garage');
%%
% During business days, you can see spikes in the dust concentration
% at times when cars arrive or depart.