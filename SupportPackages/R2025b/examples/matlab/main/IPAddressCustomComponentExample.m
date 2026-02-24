%% IP Address Component Overview
% This example IP address component accepts input formatted using either
% the IPv4 or IPv6 protocol. The protocol determines how the component is
% displayed:
% 
% * IPv4 &mdash; The component contains four numeric edit fields, each with a
% value between 0 and 255. 
% * IPv6 &mdash; The component contains eight text
% edit fields, each with four characters representing hexadecimal digits.
%
% <<../IP-address-screenshot.png>>
% 
% The IP address component interface consists of:
%
% * A public property named |Address| to store the value of the IP address
% * A public property named |Protocol| to specify the IP address protocol
% * A public callback named |AddressChangedFcn| that executes when an app
% user changes the IP address by typing in an edit field
% 
% Because the |Address| property can store either a four-element numeric
% vector (when the protocol is IPv4) or an eight-element cell array (when
% the protocol is IPv6), use custom validation logic in a property set
% method to check whether the |Address| value is valid.
% 
%% 
% To view the full |IPAddress| component code in App Designer, enter this
% command in the MATLAB(R) Command Window:
%
%  openExample('matlab/IPAddressCustomComponentExample');

% Copyright 2021 The MathWorks, Inc.

