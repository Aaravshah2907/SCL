%% Query Sheet Names
% Create a datastore containing the file |airlinesmall_subset.xlsx|.
ssds = spreadsheetDatastore('airlinesmall_subset.xlsx')

%%
% Query the sheet names of the first (and only) file in the datastore.
sheetnames(ssds,1)

% Copyright 2016 The MathWorks, Inc.