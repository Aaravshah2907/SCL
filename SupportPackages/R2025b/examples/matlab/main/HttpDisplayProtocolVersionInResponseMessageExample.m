%% Display Protocol Version in Response Message
% Send an HTTP request message to |mathworks.com| using default values.
% Display the protocol version in the response message.
request = matlab.net.http.RequestMessage;
uri = matlab.net.URI('https://www.mathworks.com');
response = send(request,uri);
version = string(response.StatusLine.ProtocolVersion)

%% 
% Copyright 2012 The MathWorks, Inc.