classdef LinuxTests < matlab.unittest.TestCase
    methods (TestClassSetup)
        function testPlatform(testCase)
            testCase.assumeTrue(isunix && ~ismac, ...
                "Tests must run on a Linux platform.")
        end
    end

    methods (Test)
        function test1(testCase)
            testCase.verifyWarningFree(@rand)
        end
        function test2(testCase)
            testCase.verifyWarningFree(@() size([]))
        end
    end
end