%% Request Image from Website
% Send a message to the Hubble Heritage website requesting an image of Jupiter. 
%% 
% Format an HTTP request message and display the Content-Type of the
% response message body. The server returns a JPEG image.
request = matlab.net.http.RequestMessage;
uri = matlab.net.URI('http://heritage.stsci.edu/2007/14/images/p0714aa.jpg');
r = send(request,uri);
r.Body.ContentType
%% 
% Display the image using the |imshow| function. MATLAB resizes the image
% to fit on the screen.
warning('off','Images:initSize:adjustingMag');
imshow(r.Body.Data)

%% 
% Copyright 2012 The MathWorks, Inc.