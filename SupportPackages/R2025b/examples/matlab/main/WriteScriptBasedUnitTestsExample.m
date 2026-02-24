%% Write Script-Based Unit Tests  
% This example shows how to write a script that tests a function that you
% create. The example function computes the angles of a right triangle,
% and you create a script-based unit test to test the function.   

%% Create rightTri Function to Test 
% Create this function in a file, |rightTri.m|, in your current MATLAB(R)
% folder. This function takes lengths of two sides of a triangle as input
% and returns the three angles of the corresponding right triangle. The
% input sides are the two shorter edges of the triangle, not the hypotenuse. 
%
% <include>rightTri.m</include>
%
%% Create Test Script 
% In your working folder, create a new script, |rightTriTest.m|. Each unit
% test checks a different output of the |rightTri| function. A test script
% must adhere to the following conventions: 
%  
% * The name of the test file must start or end with the word 'test',
% which is case-insensitive. If the file name does not start or end with
% the word 'test', the tests in the file might be ignored in certain cases.  
% * Place each unit test into a separate section of the script file. Each
% section begins with two percent signs (|%%|), and the text that follows
% on the same line becomes the name of the test element. If no text follows
% the |%%|, MATLAB assigns a name to the test.  If MATLAB encounters a test
% failure, it still runs remaining tests.  
% * In a test script, the shared variable section consists of any code that
% appears before the first explicit code section (the first line beginning
% with |%%|). Tests share the variables that you define in this section.
% Within a test, you can modify the values of these variables. However,
% in subsequent tests, the value is reset to the value defined in the shared
% variables section.  
% * In the shared variables section (first code section), define any preconditions
% necessary for your tests. If the inputs or outputs do not meet this precondition,
% MATLAB does not run any of the tests. MATLAB marks the tests as failed
% and incomplete.  
% * When a script is run as a test, variables defined in one test are not
% accessible within other tests unless they are defined in the shared
% variables section (first code section).  Similarly, variables defined in
% other workspaces are not accessible to the tests.
% * If the script file does not include any code sections, MATLAB generates
% a single test element from the full contents of the script file. The name
% of the test element is the same as the script file name. In this case,
% if MATLAB encounters a failed test, it halts execution of the entire script.    

%% 
% In |rightTriTest.m|, write four tests to test the output of |rightTri|.
% Use the |assert| function to test the different conditions. In the shared
% variables section, define four triangle geometries and define a precondition
% that the |rightTri| function returns a right triangle. 
%
% <include>rightTriTest.m</include>
%
% Test 1 tests the summation of the triangle angles. If the summation is
% not equal to 180 degrees, |assert| throws an error.
%
% Test 2 tests that if two sides are equal, the corresponding angles are
% equal. If the non-right angles are not both equal to 45 degrees, the
% |assert| function throws an error.
%
% Test 3 tests that if the triangle sides are |1| and |sqrt(3)|, the angles are
% 30, 60, and 90 degrees. If this condition is not true, |assert| throws an
% error.
%
% Test 4 tests the small-angle approximation. The small-angle approximation
% states that for small angles the sine of the angle in radians is
% approximately equal to the angle. If it is not true, |assert| throws an
% error.
%% Run Tests
% Execute the |runtests| function to run the four tests in |rightTriTest.m|.
% The |runtests| function executes each test in each code section
% individually. If Test 1 fails, MATLAB still runs the remaining tests. If
% you execute |rightTriTest| as a script instead of by using |runtests|, MATLAB
% halts execution of the entire script if it encounters a failed assertion.
% Additionally, when you run tests using the |runtests| function, MATLAB
% provides informative test diagnostics.
result = runtests('rightTriTest'); 

%%
% The test for the |30-60-90| triangle and the test for the small-angle
% approximation fail in the comparison of floating-point numbers.
% Typically, when you compare floating-point values, you specify a
% tolerance for the comparison. In Test 3 and Test 4, MATLAB throws an
% error at the failed assertion and does not complete the test. Therefore,
% the test is marked as both |Failed| and |Incomplete|.
%
% To provide diagnostic information (|Error Details|) that is more
% informative than |'Assertion failed'| (Test 3), consider passing a message
% to the |assert| function (as in Test 4). Or you can also consider
% using function-based unit tests.
%% Revise Test to Use Tolerance
% Save |rightTriTest.m| as |rightTriTolTest.m|, and revise Test 3 and Test 4 to use a tolerance. In Test 3
% and Test 4, instead of asserting that the angles are equal to an expected
% value, assert that the difference between the actual and expected values
% is less than or equal to a specified tolerance. Define the tolerance in
% the shared variables section of the test script so it is accessible to
% both tests.
%
% For script-based unit tests, manually verify that the difference between
% two values is less than a specified tolerance. If instead you write a
% function-based unit test, you can access built-in constraints to specify
% a tolerance when comparing floating-point values.
%
% <include>rightTriTolTest.m</include>
%
% Rerun the tests.
result = runtests('rightTriTolTest');
%%
% All the tests pass.  
%%
% Create a table of test results. 
rt = table(result)   



%% 
% Copyright 2012 The MathWorks, Inc.