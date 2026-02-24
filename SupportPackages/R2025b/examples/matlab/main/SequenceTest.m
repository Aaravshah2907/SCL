classdef SequenceTest < matlab.unittest.TestCase
    methods (Test)
        function testSequence(testCase)
            import matlab.unittest.fixtures.PathFixture

            % Iterative implementation
            f1 = PathFixture("fibonacci_i");    
            output1 = f1.applyAndRun(@() sequence(10));
          
            % Recursive implementation
            f2 = PathFixture("fibonacci_r");    
            output2 = f2.applyAndRun(@() sequence(10));

            testCase.verifyEqual(output1,output2)
        end
    end
end