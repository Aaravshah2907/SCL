%% Display datetime Value in Header Field
% Send a message to the Hubble Heritage website and display the year an  
% image was modified.
uri = matlab.net.URI('http://heritage.stsci.edu/2007/14/images/p0714aa.jpg');
req = matlab.net.http.RequestMessage;
r = send(req,uri);
d = convert(getFields(r,'Last-Modified'));
LastModified = d.Year

%% 
% Copyright 2012 The MathWorks, Inc.