%% Aggregate Data in ThingSpeak Channel
% This example shows how to aggregate data to a lower time resolution in a ThingSpeak&trade; channel to remove irregularity.
% Irregularity in a data can be caused due to several factors such as event driven sensing, malfunctioning of sensors, or network latencies.

% Copyright 2018 The MathWorks, Inc.

%% Read Data
% ThingSpeak channel 22641 contains tide and weather data measured once a minute at Ockway Bay, Cape Cod.
% Field 2 of the channel contains air temperature data. Read the air temperature data for the past 3 hours from channel 22641 using the |thingSpeakRead| function.
%%
datetimeStop = dateshift(datetime('now'),'start','hour');
datetimeStart = dateshift(datetime('now'),'start','hour') - hours(3);

data = thingSpeakRead(22641,'DateRange',[datetimeStart,datetimeStop],...
    'Fields',2,'outputFormat','timetable'); 
%% Aggregate the Data
% Data is measured once every minute. However, due to network latency associated with the measurement system,
% the actual timestamps can be greater than or less than a minute apart. Further, for the application of interest,
% the frequency of data measured every minute is high. Data at an hourly time resolution is sufficient.
% You can use the |retime| function to aggregate the data for each hour to a single value.
% You can use the maximum value for each hour to aggregate the data. 
% Preview the first four values of the data with |head|.
%%
dataHourly = retime(data,'hourly','max');
head(dataHourly,4)
%% Send Data to ThingSpeak
% Change the channelID and the writeAPIKey to send data to your channel
%
channelID=17504;
writeAPIKey='23ZLGOBBU9TWHG2H';
thingSpeakWrite(channelID,data,'writeKey',writeAPIKey);