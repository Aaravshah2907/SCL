%% Do Not Allow HTTP Message Redirects
% Prevent message redirects from |mathworks.com| website by setting the 
% HTTP option |MaxRedirects| to zero. Then display status code information.
import matlab.net.*
import matlab.net.http.*
r = RequestMessage;
uri = URI('https://www.mathworks.com/support/contact_us');
options = HTTPOptions('MaxRedirects',0);
[resp,~,hist] = send(r,uri,options);
status = getReasonPhrase(resp.StatusCode)


%% 
% Copyright 2012 The MathWorks, Inc.