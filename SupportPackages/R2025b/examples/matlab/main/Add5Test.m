classdef Add5Test < matlab.unittest.TestCase
    properties (TestParameter)
        type = {'double','single','int8','int32'};
    end

    methods (Test)
        function numericInput(testCase,type)
            actual = add5(cast(1,type));
            testCase.verifyClass(actual,type)
        end
        function nonnumericInput(testCase)
            testCase.verifyError(@() add5("0"),"add5:InputMustBeNumeric")
        end
    end
end