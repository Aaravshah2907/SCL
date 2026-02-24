%% Display HTTP Error Code Information
% Use the status code to provide error information.
%% 
% Send a PUT message to the |mathworks.com| website.
uri = matlab.net.URI('https://www.mathworks.com');
header = matlab.net.http.field.ContentTypeField('text/plain');
req = matlab.net.http.RequestMessage('put',header,'Data');
resp = send(req, uri);
%% 
% The website does not allow PUT methods. Display a user-friendly message.
sc = resp.StatusCode;
if sc ~= matlab.net.http.StatusCode.OK
    disp([getReasonPhrase(getClass(sc)),': ',getReasonPhrase(sc)])
    disp(resp.StatusLine.ReasonPhrase)
end

%% 
% Copyright 2012 The MathWorks, Inc.