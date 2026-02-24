classdef FigurePropertiesTest < matlab.unittest.TestCase
    properties
        TestFigure
    end

    methods (TestMethodSetup)
        function createFigure(testCase)
            testCase.TestFigure = figure;
            testCase.addTeardown(@close,testCase.TestFigure)
        end
    end

    methods (Test)
        function defaultCurrentPoint(testCase)
            cp = testCase.TestFigure.CurrentPoint;
            testCase.verifyEqual(cp,[0 0], ...
                "Default current point must be [0 0].")
        end

        function defaultCurrentObject(testCase)
            import matlab.unittest.constraints.IsEmpty
            co = testCase.TestFigure.CurrentObject;
            testCase.verifyThat(co,IsEmpty, ...
                "Default current object must be empty.")
        end
    end
end