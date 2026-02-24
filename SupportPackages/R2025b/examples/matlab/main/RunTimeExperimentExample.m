%% Run Time Experiment
% In your current working folder, create a class-based test,
% preallocationTest.m, that compares different methods of preallocation.
%
% <include>preallocationTest.m</include>
%%
% Create a test suite.
suite = testsuite('preallocationTest');
%%
% Construct a time experiment with a fixed number of sample measurements,
% and run the tests.
import matlab.perftest.TimeExperiment
numSamples = 10;
experiment = TimeExperiment.withFixedSampleSize(numSamples);
result = run(experiment,suite)

%% 
% Copyright 2012 The MathWorks, Inc.