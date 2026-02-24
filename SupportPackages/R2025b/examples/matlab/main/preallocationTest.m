classdef preallocationTest < matlab.perftest.TestCase
    methods (Test)
        function testOnes(testCase)
            x = ones(1,1e7);
        end

        function testIndexingWithVariable(testCase)
            id = 1:1e7;
            x(id) = 1;
        end

        function testIndexingOnLHS(testCase)
            x(1:1e7) = 1;
        end

        function testForLoop(testCase)
            for i = 1:1e7
                x(i) = 1;
            end
        end
    end
end