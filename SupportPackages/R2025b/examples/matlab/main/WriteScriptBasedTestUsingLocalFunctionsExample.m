%% Write Script-Based Test Using Local Functions
% This example shows how to write a script-based test that uses local
% functions as helper functions.  The example function approximates the
% sine and cosine of an angle.  The script-based test checks the
% approximation using local functions to check for equality within a
% tolerance. 
%% Create |approxSinCos| Function to Test
% Create this function in a file, |approxSinCos.m|, in your current MATLAB
% folder.  This function takes an angle in radians and approximates the
% sine and cosine of the angle using Taylor series. 
% 
% <include>approxSinCos.m</include>
%
%% Create Test Script
% In your current MATLAB folder, create a new script, |approxSinCosTest.m|.  
% 
% *Note:* Including functions in scripts requires MATLAB(R) R2016b or later.
%
% <include>approxSinCosTest.m</include>
%
%%
% Each unit test uses |assert| to check different output of the
% |approxSinCos| function. Typically, when you compare floating-point
% values, you specify a tolerance for the comparison. The local functions
% |assertWithAbsTol| and |assertWithRelTol| are helper functions to compute
% whether the actual and expected values are equal within the specified
% absolute or relative tolerance. 
%
% * |Test 0rad| tests whether the computed and expected values for an angle
% of 0 radians are within an absolute tolerance of |1e-6| or a relative
% tolerance 0.1%.  Typically, you use absolute tolerance to compare values close to 0. 
% * |Test 2pi| tests whether the computed and expected values for an angle of $2\pi$
% radians are equal within an absolute tolerance of |1e-6| or a relative
% tolerance 0.1%.
% * |Test pi over 4 equality| tests whether the sine and cosine of $pi/4$ are equal
% within a relative tolerance of 0.1%.
% * |Test matches MATLAB fcn| tests whether the computed sine and cosine of $2pi/3$ are equal
% to the values from the |sin| and |cos| functions within a relative tolerance of 0.1%.
%% Run Tests
% Execute the |runtests| function to run the four tests in
% |approxSinCosTest.m|. The |runtests| function executes each test individually. If one test fails, MATLAB still runs the
% remaining tests. If you execute |approxSinCosTest| as a script instead of
% using |runtests|, MATLAB halts execution of the entire script if it
% encounters a failed assertion. Additionally, when you run tests using the
% |runtests| function, MATLAB provides informative test diagnostics.
results = runtests('approxSinCosTest');
%%
% All the tests pass.
%
% Create a table of test results.
rt = table(results)

%% 
% Copyright 2012 The MathWorks, Inc.