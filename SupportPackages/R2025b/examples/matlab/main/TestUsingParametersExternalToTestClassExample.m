%% Test Using Parameters External to Test Class
% Create parameters that are external to a test class by using
% the |matlab.unittest.parameters.Parameter.fromData| method. Then, create
% a test suite by injecting these parameters and run the tests.

% Copyright 2025 The MathWorks, Inc.
%%
% First, import the classes used in this example. 
import matlab.unittest.parameters.Parameter
import matlab.unittest.TestSuite
%%
% In a file named |ZerosTest.m| in your current folder, create the
% |ZerosTest| test class, which tests the |zeros| function.
% 
% <include>ZerosTest.m</include>
%
%%
% Using the |fromData| static method, redefine the parameters associated 
% with the |type| property so that parameterized tests use |int64| and
% |uint64| instead of |single|, |double|, and |uint16| as the data type.
newType = {'int64','uint64'};
param = Parameter.fromData("type",newType);
%%
% Create a test suite from the test class by injecting the new parameters,
% and then display the test names. The injected parameters are indicated by
% |#ext|.
suite = TestSuite.fromClass(?ZerosTest,ExternalParameters=param);
disp({suite.Name}')
%%
% Run the tests in the test suite. In this example, all the tests pass. 
results = suite.run;
%%
% Redefine the parameters associated with both the |type| and |size| 
% parameterization properties.
newSize = struct("s1d",[1 5],"s4d",[2 3 2 4]);
param = Parameter.fromData("type",newType,"size",newSize);
%%
% Create a test suite by injecting the new parameters in the |param| 
% array. Then, display the test names.
suite = TestSuite.fromClass(?ZerosTest,ExternalParameters=param);
disp({suite.Name}')
%%
% Run the tests using the newly injected parameters. The tests pass.
results = suite.run;