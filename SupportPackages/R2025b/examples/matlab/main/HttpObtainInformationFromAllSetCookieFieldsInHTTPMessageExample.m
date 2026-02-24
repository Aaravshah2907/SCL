%% Obtain Information from All Set-Cookie Fields in HTTP Message
%
r = matlab.net.http.RequestMessage();
uri = matlab.net.URI('http://httpbin.org/cookies/set?xxx=zzz&abc=def');
opts = matlab.net.http.HTTPOptions('MaxRedirects',0);
resp = r.send(uri,opts);
setCookieFields = resp.getFields('Set-Cookie');
if ~isempty(setCookieFields)
   cookieInfos = setCookieFields.convert(uri);
   r = r.addFields(matlab.net.http.field.CookieField([cookieInfos.Cookie]));
end
resp = r.send('http://httpbin.org/cookies');
disp(resp.Body.Data.cookies)

%% 
% Copyright 2012 The MathWorks, Inc.