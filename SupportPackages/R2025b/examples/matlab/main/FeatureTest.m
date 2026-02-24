classdef FeatureTest < matlab.unittest.TestCase
    methods (Test)
        function defaultBehavior(testCase)
            testCase.verifyFail
        end
        function otherBehavior(testCase)
            testCase.verifyFail("Add code to test nondefault behavior.")
        end
    end
end