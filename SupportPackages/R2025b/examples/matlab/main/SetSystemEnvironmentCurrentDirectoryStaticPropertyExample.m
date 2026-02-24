%% Set System.Environment.CurrentDirectory Static Property
% This example shows how to set a static property using the |NET.setStaticProperty| function.
%% 
% The |CurrentDirectory| property in the
% |System.Environment| class is a static, read/write
% property. The following code creates a folder |temp|
% in the current folder and changes the |CurrentDirectory| property to the new folder.
%% 
% Set your current folder.
cd('C:\Work')
%% 
% Set the |CurrentDirectory| property.
saveDir = System.Environment.CurrentDirectory;
newDir = [char(saveDir) '\temp'];
mkdir(newDir)
NET.setStaticProperty('System.Environment.CurrentDirectory',newDir)
System.Environment.CurrentDirectory
%% 
% Restore the original |CurrentDirectory| value.
NET.setStaticProperty('System.Environment.CurrentDirectory',saveDir)

%% 
% Copyright 2012 The MathWorks, Inc.