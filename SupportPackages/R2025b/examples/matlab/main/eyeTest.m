function tests = eyeTest
tests = functiontests(localfunctions);
end

function doubleClassTest(testCase)
actual = eye;
verifyClass(testCase,actual,"double")
end

function singleClassTest(testCase)
actual = eye("single");
verifyClass(testCase,actual,"single")
end

function uint16ClassTest(testCase)
actual = eye("uint16");
verifyClass(testCase,actual,"uint16")
end

function sizeTest(testCase)
expected = [7 13];
actual = eye(expected);
verifySize(testCase,actual,expected)
end

function valueTest(testCase)
actual = eye(42);
verifyEqual(testCase,unique(diag(actual)),1)    % Diagonal values must be 1
verifyEqual(testCase,unique(triu(actual,1)),0)  % Upper triangular values must be 0
verifyEqual(testCase,unique(tril(actual,-1)),0) % Lower triangular values must be 0
end