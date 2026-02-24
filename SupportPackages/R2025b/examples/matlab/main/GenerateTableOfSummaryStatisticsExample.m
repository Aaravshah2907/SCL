%% Generate Table of Summary Statistics
% In your current working folder, create a class-based test, |preallocationTest.m|, that compares different methods of preallocation.
%
% <include>preallocationTest.m</include>
%
% Create a test suite.
suite = testsuite('preallocationTest');
%%
% Construct a time experiment with a variable number of sample measurements, and run the tests.
import matlab.perftest.TimeExperiment
experiment = TimeExperiment.limitingSamplingError; 
R = run(experiment,suite);
%%
% Create a table of summary statistics from the result array |R|.
T = sampleSummary(R)

%% 
% Copyright 2012 The MathWorks, Inc.