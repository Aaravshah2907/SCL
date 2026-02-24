function tests = sampleTest
tests = functiontests(localfunctions);
end

function testA(testCase)      % Test passes
verifyEqual(testCase,2+3,5)
end

function testB(testCase)      % Test fails
verifyGreaterThan(testCase,13,42)
end

function testC(testCase)      % Test passes
verifySubstring(testCase,"Hello World!","llo")
end
