%% Show 100 Characters of HTTP Message Content
% Display the first 100 characters only of the body of a message from 
% |mathworks.com|. MATLAB displays text indicating the total number of 
% characters in the message body. 
request = matlab.net.http.RequestMessage;
uri = matlab.net.URI('https://www.mathworks.com');
r = send(request,uri);
show(r,100)

%% 
% Copyright 2012 The MathWorks, Inc.