%% Send All Received HTTP Cookies Back to Server
% This example sends all cookies to a server. In practice, you would send 
% only unexpired cookies. 
%% 
% If the initial exchange involves multiple messages for authentication and 
% redirection, you might want to obtain the |CookieInfo| object from the 
% history containing all these messages. For more information, see 
% |CookieInfo.collectFromLog|.
r = matlab.net.http.RequestMessage;
resp = send(r,'https://www.mathworks.com');
setCookieFields = resp.getFields('Set-Cookie');
if ~isempty(setCookieFields)
   % fetch all CookieInfos from Set-Cookie fields and add to request
   cookieInfos = setCookieFields.convert;
   r = r.addFields(matlab.net.http.field.CookieField([cookieInfos.Cookie]));
end
resp = r.send('https://www.mathworks.com');

%% 
% Copyright 2012 The MathWorks, Inc.