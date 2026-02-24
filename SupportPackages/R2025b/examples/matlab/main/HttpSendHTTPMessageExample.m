%% Send HTTP Message
% Send an HTTP message to read the MathWorks Contact Support web page and
% display the message status code.
import matlab.net.*
import matlab.net.http.*
r = RequestMessage;
uri = URI('https://www.mathworks.com/support/contact_us');
resp = send(r,uri);
status = resp.StatusCode

%% 
% Copyright 2012 The MathWorks, Inc.