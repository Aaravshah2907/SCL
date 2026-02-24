classdef QuadraticPolynomialTest2 < matlab.unittest.TestCase
    methods (Test)
        function nonnumericInput(testCase)
            testCase.verifyError(@()QuadraticPolynomial(1,"-3",2), ...
                "QuadraticPolynomial:InputMustBeNumeric")
        end
        function plotPolynomial(testCase)
            p = QuadraticPolynomial(1,-3,2);
            fig = figure;
            testCase.addTeardown(@close,fig)
            ax = axes(fig);
            p.plot(ax)
            actYLabelText = ax.YLabel.String;
            expYLabelText = '1.00x^2-3.00x+2.00';
            testCase.verifyEqual(actYLabelText,expYLabelText)
        end
    end
end