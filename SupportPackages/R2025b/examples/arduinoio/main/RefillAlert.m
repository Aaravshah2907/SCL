% Corresponding fruit IDs
appleFieldID = 1;
guavaFieldID = 2;
bananaFieldID = 3;

% ID which is keeping track whether count of any fruit reduced to zero or not
isEmptyId = 4;

% Channel ID
readChannelID = xxxxxxxxx ;
% Channel Read API Key 
% If your channel is private, then enter the read API Key between the '' below: 
readAPIKey = 'xxxxxxxxxxx';

appleCount = thingSpeakRead(readChannelID,'Fields',appleFieldID,'ReadKey',readAPIKey);
guavaCount = thingSpeakRead(readChannelID,'Fields',guavaFieldID,'ReadKey',readAPIKey);
bananaCount = thingSpeakRead(readChannelID,'Fields',bananaFieldID,'ReadKey',readAPIKey);


%Please find the alertAPI key in your profile
alertApiKey = 'xxxxxxxxxxxxxx'; 
alertURL = "https://api.thingspeak.com/alerts/send"; 
options = weboptions("HeaderFields", ["ThingSpeak-Alerts-API-Key", alertApiKey ]);

% variable to keep track that which fruit's count reduced to zero.
fruit = "";

if(appleCount == 0)
    fruit = "Apples";
elseif(guavaCount == 0)
    fruit="Guavas";
elseif(bananaCount == 0)
    fruit="Bananas";
end
    
    
    

%alert body
message = "There are no " +  fruit +  " in the box.";
alertBody = sprintf(message); 

%alert subject 
alertSubject = sprintf("Time to refill"); 
try 
    webwrite(alertURL, "body", alertBody, "subject", alertSubject, options); 
catch 
    % Code execution will end up here when a 429 (error due to frequent request) is caught 
end 