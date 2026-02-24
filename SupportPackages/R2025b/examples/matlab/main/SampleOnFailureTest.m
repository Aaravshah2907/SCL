classdef SampleOnFailureTest < matlab.unittest.TestCase
    methods (TestMethodSetup)
        function addFailureDiag(testCase)
            testCase.onFailure('Failure Detected')
        end
    end
    methods (Test)
        function verificationFailTest(testCase)
            testCase.onFailure(@()disp(datetime))
            testCase.verifyEqual(42,13)
        end
        function passingTest(testCase)
            testCase.assertTrue(true)
        end
        function assumptionFailTest(testCase)
            testCase.assumeEmpty(rand(2))
        end
        function assertionFailTest(testCase)
            act = randi(100,1,15);
            floor = randi(100,1,15);
            f = figure;
            plot(1:length(act),act,1:length(floor),floor)
            legend('actual','floor')
            testCase.addTeardown(@close,f)
            import matlab.unittest.diagnostics.FigureDiagnostic
            testCase.onFailure(FigureDiagnostic(f,'Formats','png'))
            testCase.assertGreaterThan(act,floor)
        end
    end
end