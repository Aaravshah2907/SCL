%% Build MEX File from Multiple Source Files
% The MEX file example |fulltosparse| consists of two Fortran source files,
% |loadsparse.F| and |fulltosparse.F|. To run this example, you need a 
% supported Fortran compiler installed on your system.
%% 
% Copy the source files to the current folder.
copyfile(fullfile(matlabroot,'extern','examples','refbook','loadsparse.F'),'.','f')
copyfile(fullfile(matlabroot,'extern','examples','refbook','fulltosparse.F'),'.','f')
%% 
% Build the |fulltosparse| MEX file. The MEX file name is |fulltosparse| 
% because |fulltosparse.F| is the first file on the command line. The output 
% contains information specific to your compiler.
mex -largeArrayDims fulltosparse.F loadsparse.F
%% 
% Test.
full = eye(5);
spar = fulltosparse(full)

%% 
% Copyright 2012 The MathWorks, Inc.