%% Write Tests Using Shared Fixtures
% You can share test fixtures across test classes using the 
% |SharedTestFixtures| attribute of the <docid:matlab_ref#ref_q22tyqu3l>
% class. When you share a fixture across test classes that run together,
% the testing framework sets up the fixture once for all the 
% test classes and tears it down after all the test classes run. If you
% specify the fixture using the |TestClassSetup| |methods| block of each
% class instead, the testing framework sets up the fixture before and
% tears it down after running each test class.
% 
% This example shows how to use shared fixtures when creating tests. It
% shows how to share a fixture for adding a folder containing source code
% to the path across two test classes. The test classes use this fixture
% to access the source code required by the tests.   

% Copyright 2022 The MathWorks, Inc.
%% 
% Open the example to make the source and test code available in your
% current folder.
openExample("matlab/WriteTestsUsingSharedTestFixturesExample")
%% |DocPolynomTest| Class Definition
% This code shows the contents of the |DocPolynomTest| class definition
% file, which uses a shared fixture to access the folder defining the
% |DocPolynom| class. For more information about the |DocPolynom| class
% and to view the class code, see <docid:matlab_oop#f3-28024>.
%
% <include>fixture_example_tests\DocPolynomTest.m</include>
%
%% |BankAccountTest| Class Definition
% This code shows the contents of the |BankAccountTest| class definition
% file, which uses a shared fixture to access the folder defining the
% |BankAccount| class. For more information about the |BankAccount| class
% and to view the class code, see <docid:matlab_oop#brhzttf>.
%
% <include>fixture_example_tests\BankAccountTest.m</include>
%
%% Run the Tests
% Run the tests in your current folder and its subfolders. The testing
% framework sets up the shared test fixture, runs the tests in the
% |BankAccountTest| and |DocPolynomTest| classes, and tears down the
% fixture after running the tests. In this example, all of the tests pass.
runtests("IncludeSubfolders",true);