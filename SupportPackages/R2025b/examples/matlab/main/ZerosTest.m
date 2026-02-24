classdef ZerosTest < matlab.unittest.TestCase
    properties (TestParameter)
        type = {'single','double','uint16'};
        size = struct("s2d",[3 3],"s3d",[2 5 4]);
    end
    
    methods (Test)
        function testClass(testCase,size,type)
            testCase.verifyClass(zeros(size,type),type)
        end
        
        function testSize(testCase,size)
            testCase.verifySize(zeros(size),size)
        end
        
        function testDefaultClass(testCase)
            testCase.verifyClass(zeros,"double")
        end
        
        function testDefaultSize(testCase)
            testCase.verifySize(zeros,[1 1])
        end
        
        function testDefaultValue(testCase)
            testCase.verifyEqual(zeros,0)
        end
    end
end