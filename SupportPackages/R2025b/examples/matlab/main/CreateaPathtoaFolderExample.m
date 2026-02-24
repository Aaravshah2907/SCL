%% Collapse File Separators and Dot Symbols on Windows
% Create paths to folders using file separators and dot symbols. 
%
% |fullfile| does not trim leading or trailing file separators. |filesep|
% returns the platform-specific file separator character.

f = fullfile('c:\','myfiles','matlab',filesep)

%%
% |fullfile| collapses repeated file separators unless they appear at 
% the beginning of the full file specification. 

f = fullfile('c:\folder1', '\\\folder2\\')

%%
% |fullfile| collapses relative directories indicated by the dot symbol 
% unless they appear at the end of the full file specification. 
% Relative directories indicated by the double-dot symbol are not collapsed.

f = fullfile('c:\folder1', '.\folder2', '..\folder3\.')

%% 
% Copyright 2012 The MathWorks, Inc.