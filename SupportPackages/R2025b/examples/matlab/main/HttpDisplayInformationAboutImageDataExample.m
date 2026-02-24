%% Display Information About Image Data
% Display data about an image received from the Hubble Heritage website. 
req = matlab.net.http.RequestMessage;
uri = matlab.net.URI('http://heritage.stsci.edu/2007/14/images/p0714aa.jpg');
r = send(req,uri);
show(r.Body)

%% 
% Copyright 2012 The MathWorks, Inc.