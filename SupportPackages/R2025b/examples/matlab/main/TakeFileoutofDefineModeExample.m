%% Take File out of Define Mode  
% When you create a file using |netcdf.create|, the function opens the
% file in define mode. This example uses |netcdf.endDef| to take the file
% out of define mode.

%% 
% Create a netCDF file. 
ncid = netcdf.create('myfile.nc','CLASSIC_MODEL');  

%% 
% Define a dimension. 
dimid = netcdf.defDim(ncid,'lat',50);  

%% 
% Leave define mode. 
netcdf.endDef(ncid)  

%% 
% Copyright 2012 The MathWorks, Inc.