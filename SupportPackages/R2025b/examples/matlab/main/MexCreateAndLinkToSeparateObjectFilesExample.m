%% Create and Link to Separate Object Files
% You can link to object files that you compile separately from your source MEX files.
%% 
% The MEX file example fulltosparse consists of two Fortran source files. 
% The |fulltosparse| file is the gateway routine (contains the |mexFunction| 
% subroutine) and |loadsparse| contains the computational routine.
%% 
% To run this example, you need a supported Fortran compiler installed on 
% your system. Copy the computational subroutine to your current folder.
copyfile(fullfile(matlabroot,'extern','examples','refbook','loadsparse.F'),'.','f')
%% 
% Compile the subroutine and place the object file in a separate folder, 
% |c:\objfiles|.
mkdir c:\objfiles
mex -largeArrayDims -c -outdir c:\objfiles loadsparse.F
%% 
% Copy the gateway subroutine to your current folder. Compile and link with 
% the |loadsparse| object file.
copyfile(fullfile(matlabroot,'extern','examples','refbook','fulltosparse.F'),'.','f')
mex -largeArrayDims fulltosparse.F c:\objfiles\loadsparse.obj

%% 
% Copyright 2012 The MathWorks, Inc.