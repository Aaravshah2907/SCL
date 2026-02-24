%% Display HTTP Status Code Category
%  
%% 
% Send a message to |mathworks.com| and display the status code category.
uri = matlab.net.URI('https://www.mathworks.com');
req = matlab.net.http.RequestMessage;
resp = send(req, uri);
sc = getClass(resp.StatusCode);
disp(getReasonPhrase(sc))

%% 
% Copyright 2012 The MathWorks, Inc.