classdef (SharedTestFixtures={ ...
        matlab.unittest.fixtures.PathFixture( ...
        fullfile("..","fixture_example_source"))}) ...
        DocPolynomTest < matlab.unittest.TestCase

    properties
        TextToDisplay = "Equation under test: "
    end

    methods (Test)
        function testConstructor(testCase)
            p = DocPolynom([1 0 1]);
            testCase.verifyClass(p,?DocPolynom)
        end

        function testAddition(testCase)
            p1 = DocPolynom([1 0 1]);
            p2 = DocPolynom([5 2]);
            actual = p1 + p2;
            expected = DocPolynom([1 5 3]);
            diagnostic = [testCase.TextToDisplay ...
                "(x^2 + 1) + (5*x + 2) = x^2 + 5*x + 3"];
            testCase.verifyEqual(actual,expected,diagnostic)
        end

        function testMultiplication(testCase)
            p1 = DocPolynom([1 0 3]);
            p2 = DocPolynom([5 2]);
            actual = p1 * p2;
            expected = DocPolynom([5 2 15 6]);
            diagnostic = [testCase.TextToDisplay ...
                "(x^2 + 3) * (5*x + 2) = 5*x^3 + 2*x^2 + 15*x + 6"];
            testCase.verifyEqual(actual,expected,diagnostic)
        end
    end
end