%% Apply Function to Measurement Results
% In your current working folder, create a class-based test, |preallocationTest.m|, that compares different methods of preallocation.
%
% <include>preallocationTest.m</include>
%
% Create a test suite.
suite = testsuite('preallocationTest');
%%
% Construct a variable time experiment, and run the tests.
import matlab.perftest.TimeExperiment
experiment = TimeExperiment.limitingSamplingError;
R = run(experiment,suite);
%%
% For each test element, find the mean time of the samples.
M = samplefun(@mean,R)
%% 
% For each test element, find the minimum time and index to the minimum
% time.
[M,I] = samplefun(@min,R)

%% 
% Copyright 2012 The MathWorks, Inc.