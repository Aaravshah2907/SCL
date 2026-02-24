classdef EnvironmentVariableTest < matlab.unittest.TestCase
    methods (Test)
        function testEnvironmentVariable(testCase)
            import matlab.unittest.fixtures.EnvironmentVariableFixture
            fixture = EnvironmentVariableFixture("NAME","David");
            disp("Initial value of the environment variable " + ...
                fixture.Name + ": " + getenv(fixture.Name))
            testCase.applyFixture(fixture)
            disp("Updated value of the environment variable " + ...
                fixture.Name + ": " + getenv(fixture.Name))
        end
    end
end