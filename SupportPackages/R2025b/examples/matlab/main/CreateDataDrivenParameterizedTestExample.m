%% Use External Parameters in Parameterized Test

% Copyright 2020 The MathWorks, Inc.

%%
% You can inject variable inputs into your existing class-based test. To
% provide test data that is defined outside the test file and that should
% be used iteratively by the test (via parameterized testing), create an
% array of |Parameter| instances, and then use the |ExternalParameters| 
% name-value argument with |TestSuite| creation methods such as 
% |fromClass|.
%%
% Create the |cleanData| function. The function accepts an
% array, vectorizes the array, removes |0|, |NaN|, and |Inf|, and then
% sorts the array.	
% 
% <include>cleanData.m</include>
%
%% 
% Create a parameterized test to test the |cleanData| function. The
% test repeats each of the four |Test| methods for the two 
% data sets that are defined in the |properties| block.
%
% <include>TestClean.m</include>
%
%%
% Run the tests. The framework runs the eight parameterized tests using
% the data defined in the test file.

import matlab.unittest.TestSuite
suite1 = TestSuite.fromClass(?TestClean);
results = suite1.run;
table(results)
%%
% Create a data set external to the test file.
A = [NaN 2 0;1 Inf 3];
%%
% Create an array of |Parameter| instances from the external data set. The
% |fromData| method accepts the name of the parameterization property from
% the |properties| block in |TestClean| and the new data as a cell array
% (or structure).
import matlab.unittest.parameters.Parameter
newData = {A};
param = Parameter.fromData("Data",newData);
%%
% Create a new test suite using the external parameters. The framework 
% appends the characters |#ext| to the end of the parameter names, 
% indicating that the parameters are defined externally.
suite2 = TestSuite.fromClass(?TestClean,"ExternalParameters",param);
{suite2.Name}'
%%
% To have full control over parameter names in the suite, define the
% parameters using a structure. Then, run the tests.
newData = struct("commandLineData",A);
param = Parameter.fromData("Data",newData);
suite2 = TestSuite.fromClass(?TestClean,"ExternalParameters",param);
{suite2.Name}'
results = suite2.run;
%%
% Create another data set that is stored in an ASCII-delimited file.
B = rand(3);
B(2,4) = 0;
writematrix(B,"myFile.dat")
clear B
%%
% Create parameters from the stored data set and |A|, and then create a
% test suite.
newData = struct("commandLineData",A,"storedData",readmatrix("myFile.dat"));
param2 = Parameter.fromData("Data",newData);
suite3 = TestSuite.fromClass(?TestClean,"ExternalParameters",param2);
%%
% To run the tests using parameters defined in the test file and
% externally, concatenate the test suites. View the suite element names and
% run the tests.
suite = [suite1 suite3];
{suite.Name}'
results = suite.run;