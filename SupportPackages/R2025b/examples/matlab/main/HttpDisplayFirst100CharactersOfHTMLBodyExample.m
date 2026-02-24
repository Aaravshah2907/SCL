%% Display First 100 Characters of HTML Body
% Request the MATLAB(R) |webread| documentation from |mathworks.com|. 
uri = matlab.net.URI('https://www.mathworks.com/help/matlab/ref/webread.html');
request = matlab.net.http.RequestMessage;
r = send(request,uri);
%% 
% Display the first 100 characters of the message body.
show(r.Body,100)

%% 
% Copyright 2012 The MathWorks, Inc.