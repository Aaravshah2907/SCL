%% Apply Custom Function to Measurement Results
% In your current working folder, create a class-based test, |preallocationTest.m|, that compares different methods of preallocation.
%
% <include>preallocationTest.m</include>
%
% Create a test suite.
suite = testsuite('preallocationTest');
%%
% Construct a fixed time experiment with 26 sample measurements, and run the tests.
import matlab.perftest.TimeExperiment
experiment = TimeExperiment.withFixedSampleSize(26);
R = run(experiment,suite);
%%
% In your current working folder, create a function, |customSampleFun|,
% that computes the mean of each of the 26 samples, converts the mean to
% milliseconds, and returns a character vector indicating if the mean time was fast or
% slow.
%
% <include>customSampleFun</include>
%
%%
% Apply |customSampleFun| to each element in the |MeasurementResult| array.
% Since the character vectors aren't scalar, specify |UniformOutput| as
% false.
[mean_ms,speed] = samplefun(@customSampleFun,R,'UniformOutput',false)

%% 
% Copyright 2012 The MathWorks, Inc.