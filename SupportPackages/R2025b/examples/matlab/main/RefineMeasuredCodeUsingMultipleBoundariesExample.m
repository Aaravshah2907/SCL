%% Refine Measured Code Using Multiple Boundaries
% Create a performance test class, |fprintfTest2|. Multiple boundaries
% (calls to |startMeasuring| and |stopMeasuring|) enable the performance
% framework to measure the code that opens the file, writes to the file, and
% closes the file.
%
% <include>fprintfTest2.m</include>
%%
% Run the performance test and view the sample summary. The performance
% framework measured that the mean time to open, write to, and close the
% file for the |testPrintingToFile| test was approximately 0.02 seconds.
% Your results might vary.
results = runperf('fprintfTest2');
T = sampleSummary(results)

%% 
% Copyright 2012 The MathWorks, Inc.