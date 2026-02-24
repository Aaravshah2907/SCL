%% Run Select Parameterized Tests
% In your working folder, create |testZeros.m|. This class contains four
% test methods.
%
% <include>testZeros.m</include>
%%
% The full test suite has 11 test elements: 6 from the |testClass| method,
% 2 from the |testSize| method, and 1 each from the |testDefaultClass|,
% |testDefaultSize|, and |testDefaultValue| methods.
%
% At the command prompt, run all the parameterizations for the |testSize|
% method.
runtests('testZeros/testSize')
%% 
% The |runtests| function executed the two parameterized tests from the
% |testSize| method. Alternatively, you can specify the test procedure name
% with |runtests('testZeros','ProcedureName','testSize')|.
%
% Run the test elements that use the |outSize| parameter property.
runtests('testZeros','ParameterProperty','outSize')
%%
% The |runtests| function executed eight tests that use the |outSize|
% parameter property: six from the |testClass| method and two from the
% |testSize| method.
%
% Run the test elements that use the |single| parameter name.
runtests('testZeros','ParameterName','single')
%%
% The |runtests| function executed the two tests from the |testClass|
% method that use the |outSize| parameter name.