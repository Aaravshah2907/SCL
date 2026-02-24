% Enter your MATLAB Code below
% Copyright 2024 The MathWorks, Inc.
% Enter the thingSpeak configuration
readChannelID = 2392616;
readAPIKey = "AWH0SUC2K9Z7KJEG";

% read the mode of the rotating device
[Mode] = thingSpeakRead(readChannelID,'Fields',[1],'ReadKey',readAPIKey)

% Set the alert API key
alertApiKey="TAKxGfifAN8MiUtTmnY";
alertURL = "https://api.thingspeak.com/alerts/send";
mode = "";

options = weboptions("HeaderFields", ["ThingSpeak-Alerts-API-Key", alertApiKey ]);

if(Mode == 3)
    mode = "Block";
end
if(Mode == 4)
    mode = "RotorImbalance";
end

message = "The mode of the machine is :" +  mode;

alertBody = sprintf(message);
alertSubject = sprintf("Abnormality detected in machine");
try
    webwrite(alertURL, "body", alertBody, "subject", alertSubject, options);
catch
    % Code execution will end up here when an error 429 (error due to frequent request) is caught
end