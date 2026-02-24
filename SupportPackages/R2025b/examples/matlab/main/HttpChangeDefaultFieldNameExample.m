%% Change Default Field Name
% Assume that you receive a header field |H| in a response message from a 
% server with the Value property 
% |media-type; name1=value1; name2=value2|. To run this example, create
% the variable |H|. 
H = matlab.net.http.HeaderField('Test-Name','media-type; name1=value1; name2=value2')
%% 
% Parse the |Value| property of |H|. MATLAB creates a default field name 
% |Arg_1|.
var = parse(H)
%% 
% Change the default to a more meaningful name |MediaType|.
var = parse(H,'MediaType')

%% 
% Copyright 2012 The MathWorks, Inc.