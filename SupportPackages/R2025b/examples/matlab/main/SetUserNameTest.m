classdef SetUserNameTest < matlab.unittest.TestCase
    properties (SetAccess = private)
        OriginalUserName
    end
    
    methods (Test)
        function testUpdate(testCase)
            testCase.OriginalUserName = getenv('UserName');
            setUserName('David')
            testCase.addTeardown(@() testCase.resetUserName)
            testCase.verifyEqual(getenv('UserName'),'David')
        end
    end

    methods (Access = private)
        function resetUserName(testCase)
            setUserName(testCase.OriginalUserName)
            testCase.fatalAssertEqual(getenv('UserName'),testCase.OriginalUserName)
        end
    end
end