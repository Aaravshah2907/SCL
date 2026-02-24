function [] = myDatasets()

% Define 20x24 mockup elevation data based on MATLAB peaks functions.
Z = abs(peaks(24)).' ;
Z = Z(3:22,:) ;

% Define individual datasets and save them into HDF5 files.

% #1. Define 20x10 Western slab.
elevation_W = Z(:,1:10) ;
h5create('data_W.h5','/data/elevation', size(elevation_W)) ;
h5write('data_W.h5', '/data/elevation', elevation_W) ;

% #2. Define 11x12 North-Eastern slab.
elevation_NE = Z(10:end,11:22) ;
h5create('data_NE.h5','/z', size(elevation_NE)) ;
h5write('data_NE.h5', '/z', elevation_NE) ;

% #3. Define 9x13 South-Eastern slab.
elevation_SE = Z(1:9,12:end) ;
h5create('data_SE.h5','/Elev', size(elevation_SE)) ;
h5write('data_SE.h5', '/Elev', elevation_SE) ;
end